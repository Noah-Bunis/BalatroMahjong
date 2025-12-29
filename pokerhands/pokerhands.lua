SMODS.PokerHand {
    key = "Mahjong",
    mult = 12,
    chips = 160,
    l_mult = 6,
    l_chips = 60,
    example = {{'S_A', true}, {'S_A', true}, {'S_2', true}, {'S_3', true}, {'S_4', true}, {'C_5', true}, {'C_6', true},
               {'C_7', true}, {'D_9', true}, {'D_T', true}, {'D_J', true}, {'H_5', true}, {'H_5', true}, {'H_5', true}},
    evaluate = function(parts, hand)
        if not #hand ~= 14 then
            return
        end
        if #parts._2 ~= 1 then
            return
        end
        local pungs = #parts._3
        local chows = get_chow(hand)
        local chow_count = #chows
        if pungs + chow_count < 4 then
            return true
        end
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
