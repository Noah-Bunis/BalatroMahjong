-- Mahjong Deck
SMODS.Back {
    key = "mahjong_red",
    pos = { x = 0, y = 0 },
    config = { discards = 1, hand_size = 10, ante_scaling = 4},
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.discards, self.config.hand_size, self.config.ante_scaling} }
    end,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.change_play_limit(9)
                SMODS.change_discard_limit(9)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            func = function()
                local suits_to_remove = {'bm_Dragons', 'bm_Winds'}
                local ranks_to_remove = {'bm_East', 'bm_South', 'bm_West', 'bm_North', 'bm_White', 'bm_Green', 'bm_Red'}
                
                for _, suit in ipairs(suits_to_remove) do
                    for _, playing_card in ipairs(G.deck.cards) do
                        if playing_card.base.suit == suit then
                            SMODS.destroy_cards(playing_card)
                        end
                    end
                end
                
                for _, rank in ipairs(ranks_to_remove) do
                    for _, playing_card in ipairs(G.deck.cards) do
                        if playing_card.base.value == rank then
                            SMODS.destroy_cards(playing_card)
                        end
                    end
                end
                
                return true
            end
        }))
        
        local regular_suits = {'S','C','D','H'}
        local regular_ranks = {'2','3','4','5','6','7','8','9','10','J','Q','K','A'}
        for i=1,3 do
            for _, suit in ipairs(regular_suits) do
                for _, rank in ipairs(regular_ranks) do
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local card = SMODS.add_card({set = 'Base', area = G.deck, suit = suit, rank = rank})
                            return true
                        end
                    }))
                end
            end
        end
        
        local winds = {'bm_North', 'bm_East', 'bm_South', 'bm_West'}
        local dragons = {'bm_Red', 'bm_Green', 'bm_White'}
        G.E_MANAGER:add_event(Event({
            func = function()
                for _, wind in ipairs(winds) do
                    for i=1,4 do
                        local card = SMODS.add_card({set = 'Base', area = G.deck, suit = 'bm_Winds', rank = wind})
                    end
                end
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            func = function()
                for _, dragon in ipairs(dragons) do
                    for i=1,4 do
                    local card = SMODS.add_card({set = 'Base', area = G.deck, suit = 'bm_Dragons', rank = dragon})
                    end
                end
                return true
            end
        }))
    end
}