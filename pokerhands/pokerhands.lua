SMODS.PokerHand {
    key = "Mahjong",
    mult = 20,
    chips = 200,
    l_mult = 6,
    l_chips = 60,
    example = {{'S_A', true}, {'S_A', true}, {'S_2', true}, {'S_3', true}, {'S_4', true}, {'C_5', true}, {'C_6', true},
               {'C_7', true}, {'D_9', true}, {'D_T', true}, {'D_J', true}, {'H_5', true}, {'H_5', true}, {'H_5', true}},
    evaluate = function(parts, hand)
        if not (#parts.bm_mahjong > 0) then return {} end
        return { hand }
    end,
    modify_display_text = function(self, cards, scoring_hand)
        local tanyao = true -- no honors or teminals
        local honroutou = true -- all honors or terminals
        local chinroutou = true -- all terminals

        local pure_double_chi_count
        pure_double_chi_count = function(hand)
            local suits = {
                "Spades",
                "Hearts",
                "Clubs",
                "Diamonds",
                "bm_Winds",
                "bm_Dragons"
            }
            
            local total_pairs = 0
            
            -- Find all chows in the hand
            for _, suit in ipairs(suits) do
                local rank_counts = {}
                
                -- Count cards by rank for this suit
                for i = 1, #hand do
                    if hand[i]:is_suit(suit, nil, true) then
                        local rank = hand[i]:get_id()
                        if not rank_counts[rank] then
                            rank_counts[rank] = 0
                        end
                        rank_counts[rank] = rank_counts[rank] + 1
                    end
                end
                
                -- Get unique ranks and sort them
                local unique_ranks = {}
                for rank, _ in pairs(rank_counts) do
                    table.insert(unique_ranks, rank)
                end
                table.sort(unique_ranks)
                
                -- Look for consecutive rank triples that form chows
                for i = 1, #unique_ranks - 2 do
                    local rank1 = unique_ranks[i]
                    local rank2 = unique_ranks[i + 1]
                    local rank3 = unique_ranks[i + 2]
                    
                    -- Check if these ranks are consecutive
                    if rank2 == rank1 + 1 and rank3 == rank2 + 1 then
                        -- Found a valid chow pattern, count how many pairs can be formed
                        local chow_count = math.min(rank_counts[rank1], rank_counts[rank2], rank_counts[rank3])
                        if chow_count >= 2 then
                            total_pairs = total_pairs + math.floor(chow_count / 2)
                        end
                    end
                end
            end
            return total_pairs
        end

        for j = 1, #scoring_hand do
            local rank = SMODS.Ranks[scoring_hand[j].base.value]
            local honor = rank.bm_honor
            if rank.key == "Ace" or rank.key == "King" then
                tanyao = false
            elseif honor then
                chinroutou = false
                tanyao = false
            else
                honroutou = false
                chinroutou = false
            end
        end
        if chinroutou then
            return "bm_Chinroutou"
        elseif pure_double_chi_count(scoring_hand) > 1 then
            return "bm_Twice Pure Double Chi"
        elseif honroutou then
            return "bm_Honroutou"
        elseif pure_double_chi_count(scoring_hand) > 0 then
            return "bm_Pure Double Chi"
        elseif tanyao then
            return "bm_Tanyao"
        end
    end
}

SMODS.PokerHand {
    key = "Seven Pairs",
    mult = 22,
    chips = 222,
    l_mult = 6,
    l_chips = 60,
    example = {{'S_A', true}, {'S_A', true}, {'S_2', true}, {'S_2', true}, {'H_5', true}, {'H_5', true}, {'C_7', true}, 
                {'C_7', true}, {'D_9', true}, {'D_9', true}, {'C_3', true}, {'C_3', true}, {'C_K', true}, {'C_K', true}},
    evaluate = function(parts, hand)
        if #hand ~= 14 then return {} end
        if not (#parts.bm_unique_flush_2 > 6) then return {} end
        return { hand }
    end
}

SMODS.PokerHandPart {
    key = "mahjong",
    func = function(hand)
        if #hand ~= 14 then return {} end
        
        local suits = {
            "Spades",
            "Hearts",
            "Clubs",
            "Diamonds",
            "bm_Winds",
            "bm_Dragons"
        }
        
        local validate_and_get_groups
        validate_and_get_groups = function(hand, num_groups)
            if num_groups == 0 then
                return #hand == 0 and {} or nil
            end
            if #hand < 3 then
                return nil
            end
            
            -- Try to form groups from each suit
            for j = 1, #suits do
                local suit = suits[j]
                local suit_cards = {}
                local suit_indices = {}
                
                for i = 1, #hand do
                    if hand[i]:is_suit(suit, nil, true) then
                        table.insert(suit_cards, hand[i])
                        table.insert(suit_indices, i)
                    end
                end
                
                if #suit_cards >= 3 then
                    -- Try to form a triplet (3 of same rank)
                    local rank_groups = {}
                    for i = 1, #suit_cards do
                        local rank = suit_cards[i]:get_id()
                        if not rank_groups[rank] then
                            rank_groups[rank] = {}
                        end
                        table.insert(rank_groups[rank], i)
                    end
                    
                    for rank, indices in pairs(rank_groups) do
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
                    
                    -- Try to form a chow (consecutive 3 of same suit)
                    -- Group cards by rank for more flexible chow selection
                    local rank_groups_chow = {}
                    for i = 1, #suit_cards do
                        local rank = suit_cards[i]:get_id()
                        if not rank_groups_chow[rank] then
                            rank_groups_chow[rank] = {}
                        end
                        table.insert(rank_groups_chow[rank], {card = suit_cards[i], hand_index = suit_indices[i]})
                    end
                    
                    -- Try to form chows with any available consecutive ranks
                    local sorted_ranks = {}
                    for rank, _ in pairs(rank_groups_chow) do
                        table.insert(sorted_ranks, rank)
                    end
                    table.sort(sorted_ranks)
                    
                    for k = 1, #sorted_ranks - 2 do
                        local rank1 = sorted_ranks[k]
                        local rank2 = sorted_ranks[k + 1]
                        local rank3 = sorted_ranks[k + 2]
                        
                        if rank2 == rank1 + 1 and rank3 == rank2 + 1 then
                            if rank_groups_chow[rank1] and rank_groups_chow[rank2] and rank_groups_chow[rank3] then
                                -- Found a valid chow pattern, take one card from each rank
                                local card1 = table.remove(rank_groups_chow[rank1])
                                local card2 = table.remove(rank_groups_chow[rank2])
                                local card3 = table.remove(rank_groups_chow[rank3])
                                
                                local new_hand = {}
                                local used = {}
                                used[card1.hand_index] = true
                                used[card2.hand_index] = true
                                used[card3.hand_index] = true
                                
                                for i = 1, #hand do
                                    if not used[i] then
                                        table.insert(new_hand, hand[i])
                                    end
                                end
                                
                                local rest_groups = validate_and_get_groups(new_hand, num_groups - 1)
                                if rest_groups then
                                    local chow = {card1.card, card2.card, card3.card}
                                    table.insert(rest_groups, 1, chow)
                                    return rest_groups
                                end
                                
                                -- Restore cards if this path didn't work
                                table.insert(rank_groups_chow[rank1], card1)
                                table.insert(rank_groups_chow[rank2], card2)
                                table.insert(rank_groups_chow[rank3], card3)
                            end
                        end
                    end
                end
            end
            
            return nil
        end
        
        -- Try each potential pair
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
            
            -- Try each pair (2 or more cards of same rank and suit, use 2 as pair)
            for rank, cards in pairs(rank_groups) do
                if #cards >= 2 then
                    local pair = {cards[1], cards[2]}
                    local remaining = {}
                    
                    -- Create remaining hand without the pair
                    for i = 1, #hand do
                        if hand[i] ~= pair[1] and hand[i] ~= pair[2] then
                            table.insert(remaining, hand[i])
                        end
                    end
                    
                    -- Try to validate remaining 12 cards as 4 groups
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

--[[SMODS.PokerHandPart {
    key = "chow",
    func = function(hand)
        local ret = {}
        if #hand < 3 then
            return ret
        end
        
        local suits = {
            "Spades",
            "Hearts",
            "Clubs",
            "Diamonds",
            "bm_Winds",
            "bm_Dragons"
        }
        
        for j = 1, #suits do
            local suit = suits[j]
            local suit_cards = {}
            
            for i = 1, #hand do
                if hand[i]:is_suit(suit, nil, true) then
                    table.insert(suit_cards, hand[i])
                end
            end
            
            if #suit_cards >= 3 then
                local sorted = {}
                for i = 1, #suit_cards do
                    table.insert(sorted, {
                        card = suit_cards[i],
                        id = suit_cards[i]:get_id()
                    })
                end
                table.sort(sorted, function(a, b)
                    return a.id < b.id
                end)
                
                local i = 1
                while i <= #sorted - 2 do
                    if sorted[i].id + 1 == sorted[i + 1].id and sorted[i + 1].id + 1 == sorted[i + 2].id then
                        table.insert(ret, {sorted[i].card, sorted[i + 1].card, sorted[i + 2].card})
                        i = i + 3
                    else
                        i = i + 1
                    end
                end
            end
        end
        
        return ret
    end
} --]]

SMODS.PokerHandPart {
    key = "unique_flush_2",
    func = function(hand)
        local ret = {}
        local suits = {
            "Spades",
            "Hearts",
            "Clubs",
            "Diamonds",
            "bm_Winds",
            "bm_Dragons"
        }
        
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
    --[[
SMODS.PokerHandPart {
    key = "unique_flush_3",
    func = function(hand)
        local ret = {}
        local suits = {
            "Spades",
            "Hearts",
            "Clubs",
            "Diamonds"
        }
        
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
                if #cards == 3 then
                    table.insert(ret, {cards[1], cards[2], cards[3]})
                end
            end
        end
        
        return ret
    end
}--]]