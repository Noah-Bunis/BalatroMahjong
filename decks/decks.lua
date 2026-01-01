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
        local suits = {'S','C','D','H'}
        local ranks = {'2','3','4','5','6','7','8','9','10','J','Q','K','A'}
        for i=1,3 do
            for _, suit in ipairs(suits) do
                for _, rank in ipairs(ranks) do
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after', delay = 0.05,
                        func = function()
                            local card = SMODS.add_card({set = 'Base', area = G.deck, suit = suit, rank = rank})
                            return true
                        end
                    }))
                end
            end
        end
    end
}