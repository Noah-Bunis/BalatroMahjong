SMODS.PokerHand {
    key = "Mahjong",
    mult = 20,
    chips = 200,
    l_mult = 6,
    l_chips = 60,
    example = {{'S_A', true}, {'S_A', true}, {'S_2', true}, {'S_3', true}, {'S_4', true}, {'C_5', true}, {'C_6', true},
               {'C_7', true}, {'D_9', true}, {'D_T', true}, {'D_J', true}, {'H_5', true}, {'H_5', true}, {'H_5', true}},
    evaluate = function(parts, hand)
        if not (#hand > 13) then return {} end
        if not (#parts.bm_unique_flush_2 > 0) then return {} end -- needs to be a unique flush pair
        if not (#parts.bm_unique_flush_3 > 3) then return {} end -- needs to be flush threes
        --[[if not #hand ~= 14 then
            return {}
        end
        if #parts._2 < 1 then
            return {}
        end
        local pungs = #parts._3
        local chows = get_chow(hand)
        local chow_count = #chows--]]
        return { hand }
    end
}

function get_chow(hand)
    local ret = {}
    local chow_count = 0
    if #hand < 3 then
        return ret
    end
    local SUITS = {}
    for i = 1, #hand do
        local card = hand[i]
        local suit = card.suit
        if not SUITS[suit] then
            SUITS[suit] = {}
        end
        table.insert(SUITS[suit], card)
    end
    for suit, cards in pairs(SUITS) do
        if #cards >= 3 then
            local sorted = {}
            for i = 1, #cards do
                table.insert(sorted, {
                    card = cards[i],
                    id = cards[i]:get_id()
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
                if #cards >= 2 and #cards < 3 then
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
}
