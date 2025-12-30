SMODS.PokerHand {
    key = "Mahjong",
    mult = 20,
    chips = 200,
    l_mult = 6,
    l_chips = 60,
    example = {{'S_A', true}, {'S_A', true}, {'S_2', true}, {'S_3', true}, {'S_4', true}, {'C_5', true}, {'C_6', true},
               {'C_7', true}, {'D_9', true}, {'D_T', true}, {'D_J', true}, {'H_5', true}, {'H_5', true}, {'H_5', true}},
    evaluate = function(parts, hand)
        if not (#parts.bm_mahjong_groups > 0) then return {} end
        return { hand }
    end
}

SMODS.PokerHandPart {
    key = "mahjong_groups",
    func = function(hand)
        if #hand ~= 14 then return {} end
        
        local suits = {
            "Spades",
            "Hearts",
            "Clubs",
            "Diamonds"
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
                        if #indices == 3 then
                            local new_hand = {}
                            local used = {}
                            for k = 1, #indices do
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
                    local sorted = {}
                    for i = 1, #suit_cards do
                        table.insert(sorted, {
                            card = suit_cards[i],
                            id = suit_cards[i]:get_id(),
                            hand_index = suit_indices[i]
                        })
                    end
                    table.sort(sorted, function(a, b) return a.id < b.id end)
                    
                    for i = 1, #sorted - 2 do
                        if sorted[i].id + 1 == sorted[i+1].id and sorted[i+1].id + 1 == sorted[i+2].id then
                            local new_hand = {}
                            local used = {}
                            used[sorted[i].hand_index] = true
                            used[sorted[i+1].hand_index] = true
                            used[sorted[i+2].hand_index] = true
                            
                            for k = 1, #hand do
                                if not used[k] then
                                    table.insert(new_hand, hand[k])
                                end
                            end
                            
                            local rest_groups = validate_and_get_groups(new_hand, num_groups - 1)
                            if rest_groups then
                                local chow = {sorted[i].card, sorted[i+1].card, sorted[i+2].card}
                                table.insert(rest_groups, 1, chow)
                                return rest_groups
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
            "Diamonds"
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
}

SMODS.PokerHandPart {
    key = "unique_flush_2",
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
                if #cards == 2 then
                    table.insert(ret, {cards[1], cards[2]})
                end
            end
        end
        
        return ret
    end
}

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