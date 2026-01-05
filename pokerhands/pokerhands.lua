local SUITS = {"Spades", "Hearts", "Clubs", "Diamonds", "bm_Winds", "bm_Dragons"}

local function validate_and_get_groups(hand, num_groups)
    if num_groups == 0 then
        return #hand == 0 and {} or nil
    end
    if #hand < 3 then
        return nil
    end

    for j = 1, #SUITS do
        local suit = SUITS[j]
        local suit_cards = {}
        local suit_indices = {}

        for i = 1, #hand do
            if hand[i]:is_suit(suit, nil, true) then
                table.insert(suit_cards, hand[i])
                table.insert(suit_indices, i)
            end
        end

        if #suit_cards >= 3 then
            -- Triplets (same rank)
            local rank_groups = {}
            for i = 1, #suit_cards do
                local rank = suit_cards[i]:get_id()
                rank_groups[rank] = rank_groups[rank] or {}
                table.insert(rank_groups[rank], i)
            end

            for _, indices in pairs(rank_groups) do
                if #indices >= 3 then
                    local new_hand = {}
                    local used = {}

                    for k = 1, 3 do
                        used[suit_indices[indices[k]]] = true
                    end

                    for i = 1, #hand do
                        if not used[i] then
                            table.insert(new_hand, hand[i])
                        end
                    end

                    local rest_groups = validate_and_get_groups(new_hand, num_groups - 1)
                    if rest_groups then
                        local triplet = {suit_cards[indices[1]], suit_cards[indices[2]], suit_cards[indices[3]]}
                        table.insert(rest_groups, 1, triplet)
                        return rest_groups
                    end
                end
            end
            -- Chows (straights)
            local rank_groups_chow = {}
            for i = 1, #suit_cards do
                local rank = suit_cards[i]:get_id()
                rank_groups_chow[rank] = rank_groups_chow[rank] or {}
                table.insert(rank_groups_chow[rank], {
                    card = suit_cards[i],
                    hand_index = suit_indices[i]
                })
            end
            -- Ace can also be low (A,2,3)
            if rank_groups_chow[14] then
                rank_groups_chow[1] = rank_groups_chow[1] or {}
                for _, entry in ipairs(rank_groups_chow[14]) do
                    table.insert(rank_groups_chow[1], entry)
                end
            end

            local sorted_ranks = {}
            for rank, _ in pairs(rank_groups_chow) do
                table.insert(sorted_ranks, rank)
            end
            table.sort(sorted_ranks)

            local function pop_card(rank)
                if rank == 1 then
                    rank = 14
                end
                return table.remove(rank_groups_chow[rank])
            end

            local function push_card(rank, card)
                if rank == 1 then
                    rank = 14
                end
                table.insert(rank_groups_chow[rank], card)
            end

            for k = 1, #sorted_ranks - 2 do
                local r1 = sorted_ranks[k]
                local r2 = sorted_ranks[k + 1]
                local r3 = sorted_ranks[k + 2]

                if r2 == r1 + 1 and r3 == r2 + 1 then
                    if rank_groups_chow[r1] and rank_groups_chow[r2] and rank_groups_chow[r3] then
                        local c1 = pop_card(r1)
                        local c2 = pop_card(r2)
                        local c3 = pop_card(r3)

                        if c1 and c2 and c3 then
                            local new_hand = {}
                            local used = {
                                [c1.hand_index] = true,
                                [c2.hand_index] = true,
                                [c3.hand_index] = true
                            }

                            for i = 1, #hand do
                                if not used[i] then
                                    table.insert(new_hand, hand[i])
                                end
                            end

                            local rest_groups = validate_and_get_groups(new_hand, num_groups - 1)
                            if rest_groups then
                                table.insert(rest_groups, 1, {c1.card, c2.card, c3.card})
                                return rest_groups
                            end

                            push_card(r1, c1)
                            push_card(r2, c2)
                            push_card(r3, c3)
                        end
                    end
                end
            end
        end
    end

    return nil
end

local function get_chows(hand)
    local chow_patterns = {}

    for _, suit in ipairs(SUITS) do
        local rank_counts = {}

        for i = 1, #hand do
            if hand[i]:is_suit(suit, nil, true) then
                local rank = hand[i]:get_id()
                if not rank_counts[rank] then
                    rank_counts[rank] = 0
                end
                rank_counts[rank] = rank_counts[rank] + 1
            end
        end

        local unique_ranks = {}
        for rank, _ in pairs(rank_counts) do
            table.insert(unique_ranks, rank)
        end
        table.sort(unique_ranks)

        for i = 1, #unique_ranks - 2 do
            local rank1 = unique_ranks[i]
            local rank2 = unique_ranks[i + 1]
            local rank3 = unique_ranks[i + 2]

            if rank2 == rank1 + 1 and rank3 == rank2 + 1 then
                local chow_count = math.min(rank_counts[rank1], rank_counts[rank2], rank_counts[rank3])
                if chow_count > 0 then
                    local pattern = suit .. "-" .. rank1 .. "-" .. rank2 .. "-" .. rank3
                    chow_patterns[pattern] = chow_count
                end
            end
        end
    end

    return chow_patterns
end

--[[ SMODS.PokerHand {
    key = "Mahjong",
    mult = 20,
    chips = 200,
    l_mult = 6,
    l_chips = 60,
    example = {{'S_A', true}, {'S_A', true}, {'S_2', true}, {'S_3', true}, {'S_4', true}, {'C_5', true}, {'C_6', true},
               {'C_7', true}, {'D_9', true}, {'D_T', true}, {'D_J', true}, {'H_5', true}, {'H_5', true}, {'H_5', true}},
    evaluate = function(parts, hand)
        if not (#parts.bm_mahjong > 0) then
            return {}
        end
        return {}
    end,
    modify_display_text = function(self, cards, scoring_hand)
        local tanyao = true -- no honors or teminals
        local honroutou = true -- all honors or terminals
        local chinroutou = true -- all terminals
        local tsuuiisou = true -- all honors

        local half_flush
        half_flush = function(hand)
            if not pure_straight(hand) then
                return false
            end
            -- ensure all cards are of one suit plus honors
            for j = 1, #SUITS do
                local suit = SUITS[j]
                local has_suit = false
                local all_valid = true
                for i = 1, #hand do
                    if hand[i]:is_suit(suit, nil, true) then
                        has_suit = true
                    else
                        local rank = SMODS.Ranks[hand[i].base.value]
                        if not rank.bm_honor then
                            all_valid = false
                            break
                        end
                    end
                end
                if has_suit and all_valid then
                    return true
                end
            end
        end

        local full_flush
        full_flush = function(hand)
            if not pure_straight(hand) then
                return false
            end
            -- ensure all cards are of one suit
            for j = 1, #SUITS do
                local suit = SUITS[j]
                local all_valid = true
                for i = 1, #hand do
                    if not hand[i]:is_suit(suit, nil, true) then
                        all_valid = false
                        break
                    end
                end
                if all_valid then
                    return true
                end
            end
        end

        local nine_gates
        nine_gates = function(hand)
            if not full_flush(hand) and pure_straight(hand) then
                return false
            end
            local ace_count = 0
            local ten_count = 0
            for i = 1, #hand do
                local rank = SMODS.Ranks[hand[i].base.value]
                if rank.key == "Ace" then
                    ace_count = ace_count + 1
                elseif rank.key == "10" then
                    ten_count = ten_count + 1
                end
            end
            return ace_count >= 3 and ten_count >= 3
        end

        for j = 1, #scoring_hand do
            local rank = SMODS.Ranks[scoring_hand[j].base.value]
            local honor = rank.bm_honor
            if rank.key == "Ace" or rank.key == "King" then
                tanyao = false
                tsuuiisou = false
            elseif honor then
                chinroutou = false
                tanyao = false
            else
                honroutou = false
                chinroutou = false
                tsuuiisou = false
            end
        end

        local four_winds
        function four_winds(hand)
            local wind_counts = {
                ['bm_East'] = 0,
                ['bm_South'] = 0,
                ['bm_West'] = 0,
                ['bm_North'] = 0
            }
            for j = 1, #hand do
                local rank = SMODS.Ranks[hand[j].base.value]
                if wind_counts[rank.key] ~= nil then
                    wind_counts[rank.key] = wind_counts[rank.key] + 1
                end
            end
            local completed_winds = 0
            local pair_winds = 0
            for _, count in pairs(wind_counts) do
                if count == 3 then
                    completed_winds = completed_winds + 1
                elseif count == 2 then
                    pair_winds = pair_winds + 1
                end
            end
            if completed_winds == 4 then
                return 2
            elseif completed_winds == 3 and pair_winds == 1 then
                return 1
            else
                return 0
            end
        end

        -- Return Mahjong Yaku
        if nine_gates(scoring_hand) then
            return "bm_Nine Gates"
        elseif four_winds(scoring_hand) == 2 then
            return "bm_Big Four Winds"
        elseif four_winds(scoring_hand) == 1 then
            return "bm_Little Four Winds"
        elseif chinroutou then
            return "bm_Chinroutou"
        elseif tsuuiisou then
            return "bm_Tsuiiisou"
        elseif full_flush(scoring_hand) then
            return "bm_Full Flush"
        elseif pure_double_chi_count(scoring_hand) > 1 then
            return "bm_Twice Pure Double Chi"
        elseif half_flush(scoring_hand) then
            return "bm_Half Flush"
        elseif honroutou then
            return "bm_Honroutou"
        elseif outside_hand(scoring_hand) then
            return "bm_Outside Hand"
        end
    end
} --]]

SMODS.PokerHand {
    key = "Tanyao",
    mult = 20,
    chips = 200,
    l_mult = 6,
    l_chips = 60,
    example = {{'S_2', true}, {'S_3', true}, {'S_4', true}, {'C_5', true}, {'C_6', true}, {'C_7', true}, {'D_4', true},
               {'D_5', true}, {'D_6', true}, {'H_5', true}, {'H_6', true}, {'H_7', true}, {'C_9', true}, {'C_9', true}},
    evaluate = function(parts, hand)
        if not (#parts.bm_mahjong > 0) then
            return {}
        end
        for j = 1, #hand do
            local rank = SMODS.Ranks[hand[j].base.value]
            local honor = rank.bm_honor
            if rank.key == "Ace" or rank.key == "King" then
                return {}
            elseif honor then
                return {}
            end
        end
        return {hand}
    end
}

SMODS.PokerHand {
    key = "Pure Double Chi",
    mult = 20,
    chips = 200,
    l_mult = 6,
    l_chips = 60,
    example = {{'S_2', true}, {'S_3', true}, {'S_4', true}, {'S_2', true}, {'S_3', true}, {'S_4', true}, {'C_5', true},
               {'C_5', true}, {'C_5', true}, {'D_9', true}, {'D_T', true}, {'D_J', true}, {'bm_Wi_bm_E', true},
               {'bm_Wi_bm_E', true}},
    evaluate = function(parts, hand)
        if not (#parts.bm_mahjong > 0) then
            return {}
        end
        local chow_patterns = get_chows(hand)
        local total_pairs = 0
        for pattern, chow_count in pairs(chow_patterns) do
            if chow_count >= 2 then
                total_pairs = total_pairs + math.floor(chow_count / 2)
            end
        end
        if total_pairs ~= 1 then
            return {}
        end
        return {hand}
    end
}

SMODS.PokerHand {
    key = "Seven Pairs",
    mult = 24,
    chips = 240,
    l_mult = 6,
    l_chips = 60,
    example = {{'S_A', true}, {'S_A', true}, {'S_2', true}, {'S_2', true}, {'H_5', true}, {'H_5', true}, {'C_7', true},
               {'C_7', true}, {'D_9', true}, {'D_9', true}, {'C_3', true}, {'C_3', true}, {'C_K', true}, {'C_K', true}},
    evaluate = function(parts, hand)
        if #hand ~= 14 then
            return {}
        end
        if not (#parts.bm_unique_flush_2 > 6) then
            return {}
        end
        return {hand}
    end
}

SMODS.PokerHand {
    key = "Pure Straight",
    mult = 24,
    chips = 240,
    l_mult = 6,
    l_chips = 60,
    example = {{'S_2', true}, {'S_3', true}, {'S_4', true}, {'S_5', true}, {'S_6', true}, {'S_7', true}, {'S_8', true},
               {'S_9', true}, {'S_T', true}, {'C_5', true}, {'C_6', true}, {'C_7', true}, {'bm_D_bm_G', true},
               {'bm_D_bm_G', true}},
    evaluate = function(parts, hand)
        if not (#parts.bm_mahjong > 0) then
            return {}
        end
        for j = 1, #SUITS do
            local suit = SUITS[j]
            local bools = {false, false, false, false, false, false, false, false, false}
            for i = 1, #hand do
                if hand[i]:is_suit(suit, nil, true) then
                    local rank = SMODS.Ranks[hand[i].base.value]
                    if rank.key == "2" then
                        bools[0] = true
                    elseif rank.key == "3" then
                        bools[1] = true
                    elseif rank.key == "4" then
                        bools[2] = true
                    elseif rank.key == "5" then
                        bools[3] = true
                    elseif rank.key == "6" then
                        bools[4] = true
                    elseif rank.key == "7" then
                        bools[5] = true
                    elseif rank.key == "8" then
                        bools[6] = true
                    elseif rank.key == "9" then
                        bools[7] = true
                    elseif rank.key == "10" then
                        bools[8] = true
                    end
                end
            end
            local count = 0
            for j = 0, 8 do
                if bools[j] then
                    count = count + 1
                end
            end
            if count == 9 then
                return {hand}
            end
        end
        return {}
    end
}

SMODS.PokerHand {
    key = "Outside Hand",
    mult = 24,
    chips = 240,
    l_mult = 6,
    l_chips = 60,
    example = {{'S_A', true}, {'S_2', true}, {'S_3', true}, {'C_J', true}, {'C_Q', true}, {'C_K', true}, {'D_A', true},
               {'D_2', true}, {'D_3', true}, {'H_K', true}, {'H_Q', true}, {'H_A', true}, {'bm_Wi_bm_E', true},
               {'bm_Wi_bm_E', true}},
    evaluate = function(parts, hand)
        if not (#parts.bm_mahjong > 0) then
            return {}
        end
        for j = 1, #SUITS do
            local suit = SUITS[j]
            local rank_groups = {}
            for i = 1, #hand do
                if hand[i]:is_suit(suit, nil, true) then
                    local rank = hand[i]:get_id()
                    if not rank_groups[rank] then
                        rank_groups[rank] = {}
                    end
                    table.insert(rank_groups[rank], hand[i])
                end
            end
            for rank, cards in pairs(rank_groups) do
                if #cards >= 2 then
                    local pair = {cards[1], cards[2]}
                    local remaining = {}
                    for i = 1, #hand do
                        if hand[i] ~= pair[1] and hand[i] ~= pair[2] then
                            table.insert(remaining, hand[i])
                        end
                    end
                    local groups = validate_and_get_groups(remaining, 4)
                    if groups then
                        for g = 1, #groups do
                            local group = groups[g]
                            local has_terminal_or_honor = false

                            for c = 1, #group do
                                local card = group[c]
                                local card_rank = SMODS.Ranks[card.base.value]
                                if card_rank.key == "Ace" or card_rank.key == "King" or card_rank.bm_honor then
                                    has_terminal_or_honor = true
                                    break
                                end
                            end
                            if not has_terminal_or_honor then
                                return {}
                            end
                        end
                        return {hand}
                    end
                end
            end
        end
        return {}
    end
}

SMODS.PokerHand {
    key = "Honroutou", -- All Terminals and Honors
    mult = 24,
    chips = 240,
    l_mult = 6,
    l_chips = 60,
    example = {{'S_A', true}, {'S_A', true}, {'S_A', true}, {'C_K', true}, {'C_K', true}, {'C_K', true}, {'H_A', true},
               {'H_A', true}, {'H_A', true}, {'bm_D_bm_R', true}, {'bm_D_bm_R', true}, {'bm_D_bm_R', true},
               {'bm_Wi_bm_E', true}, {'bm_Wi_bm_E', true}},
    evaluate = function(parts, hand)
        if not (#parts.bm_mahjong > 0) then
            return {}
        end
        for j = 1, #hand do
            local rank = SMODS.Ranks[hand[j].base.value]
            local honor = rank.bm_honor
            if not (rank.key == "Ace" or rank.key == "King" or honor) then
                return {}
            end
            return {hand}
        end
    end
}

SMODS.PokerHand {
    key = "Thirteen Orphans",
    mult = 26,
    chips = 260,
    l_mult = 13,
    l_chips = 130,
    example = {{'S_A', true}, {'C_A', true}, {'H_A', true}, {'S_K', true}, {'C_K', true}, {'D_K', true}, {'H_K', true},
               {'bm_Wi_bm_E', true}, {'bm_Wi_bm_S', true}, {'bm_Wi_bm_We', true}, {'bm_Wi_bm_N', true},
               {'bm_D_bm_R', true}, {'bm_D_bm_G', true}, {'bm_D_bm_Wh', true}},
    evaluate = function(parts, hand)
        -- Win with all terminals and each type of honor
        local required_honors = {
            ['bm_East'] = false,
            ['bm_South'] = false,
            ['bm_West'] = false,
            ['bm_North'] = false,
            ['bm_Red'] = false,
            ['bm_Green'] = false,
            ['bm_White'] = false
        }
        if #hand ~= 14 then
            return {}
        end
        if #parts.bm_unique_flush_2 > 0 then
            return {}
        end
        for i = 1, #hand do
            local card = hand[i]
            local rank = SMODS.Ranks[card.base.value]
            if rank.key == 'Ace' or rank.key == 'King' then
                -- valid terminal
            elseif rank.bm_honor then
                if required_honors[rank.key] ~= nil then
                    required_honors[rank.key] = true
                end
            else
                return {}
            end
        end
        for _, found in pairs(required_honors) do
            if not found then
                return {}
            end
        end
        return {hand}
    end
}

SMODS.PokerHandPart {
    key = "mahjong",
    func = function(hand)
        if #hand ~= 14 then
            return {}
        end

        for j = 1, #SUITS do
            local suit = SUITS[j]
            local rank_groups = {}

            for i = 1, #hand do
                if hand[i]:is_suit(suit, nil, true) then
                    local rank = hand[i]:get_id()
                    if not rank_groups[rank] then
                        rank_groups[rank] = {}
                    end
                    table.insert(rank_groups[rank], hand[i])
                end
            end

            for rank, cards in pairs(rank_groups) do
                if #cards >= 2 then
                    local pair = {cards[1], cards[2]}
                    local remaining = {}

                    for i = 1, #hand do
                        if hand[i] ~= pair[1] and hand[i] ~= pair[2] then
                            table.insert(remaining, hand[i])
                        end
                    end

                    local groups = validate_and_get_groups(remaining, 4)
                    if groups then
                        local ret = {pair}
                        for i = 1, #groups do
                            table.insert(ret, groups[i])
                        end
                        return ret
                    end
                end
            end
        end

        return {}
    end
}

SMODS.PokerHandPart {
    key = "unique_flush_2",
    func = function(hand)
        local ret = {}
        local suits = {"Spades", "Hearts", "Clubs", "Diamonds", "bm_Winds", "bm_Dragons"}

        for j = 1, #suits do
            local suit = suits[j]
            local rank_groups = {}

            for i = 1, #hand do
                if hand[i]:is_suit(suit, nil, true) then
                    local rank = hand[i]:get_id()
                    if not rank_groups[rank] then
                        rank_groups[rank] = {}
                    end
                    table.insert(rank_groups[rank], hand[i])
                end
            end

            for rank, cards in pairs(rank_groups) do
                if #cards == 2 then
                    table.insert(ret, {cards[1], cards[2]})
                end
            end
        end

        return ret
    end
}
