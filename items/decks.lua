local function construct_mahjong_deck()
    SMODS.change_play_limit(9)
    SMODS.change_discard_limit(9)

    local regular_suits = {'S', 'C', 'D', 'H'}
    local regular_ranks = {'2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'}

    for i = 1, 3 do
        for _, suit in ipairs(regular_suits) do
            for _, rank in ipairs(regular_ranks) do
                local card = SMODS.add_card({
                    set = 'Base',
                    area = G.deck,
                    suit = suit,
                    rank = rank
                })
            end
        end
    end

    local winds = {'bm_North', 'bm_East', 'bm_South', 'bm_West'}
    local dragons = {'bm_Red', 'bm_Green', 'bm_White'}
    for _, wind in ipairs(winds) do
        for i = 1, 3 do
            local card = SMODS.add_card({
                set = 'Base',
                area = G.deck,
                suit = 'bm_Winds',
                rank = wind
            })
        end
    end

    for _, dragon in ipairs(dragons) do
        for i = 1, 3 do
            local card = SMODS.add_card({
                set = 'Base',
                area = G.deck,
                suit = 'bm_Dragons',
                rank = dragon
            })
        end
    end
end

-- Mahjong Deck
SMODS.Back {
    key = "mahjong_red",
    pos = {
        x = 0,
        y = 0
    },
    config = {
        discards = 1,
        hand_size = 14,
        ante_scaling = 4
    },
    loc_vars = function(self, info_queue, back)
        return {
            vars = {self.config.discards, self.config.hand_size, self.config.ante_scaling}
        }
    end,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                construct_mahjong_deck()
                return true
            end
        }))
    end
}

SMODS.Back {
    key = "mahjong_blue",
    pos = {
        x = 0,
        y = 2
    },
    config = {
        hands = 1,
        hand_size = 14,
        ante_scaling = 4
    },
    loc_vars = function(self, info_queue, back)
        return {
            vars = {self.config.hands, self.config.hand_size, self.config.ante_scaling}
        }
    end,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                construct_mahjong_deck()
                return true
            end
        }))
    end
}

SMODS.Back { 
    key = "mahjong_yellow",
    pos = {
        x = 1,
        y = 2
    },
    config = {
        dollars = 10,
        hand_size = 14,
        ante_scaling = 4
    },
    loc_vars = function(self, info_queue, back)
        return {
            vars = {self.config.dollars, self.config.hand_size, self.config.ante_scaling}
        }
    end,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                construct_mahjong_deck()
                return true
            end
        }))
    end
}

SMODS.Back {
    key = "mahjong_green",
    pos = {
        x = 2,
        y = 2
    },
    config = {
        extra_hand_bonus = 2,
        extra_discard_bonus = 1,
        no_interest = true,
        hand_size = 14,
        ante_scaling = 4
    },
    loc_vars = function(self, info_queue, back)
        return {
            vars = {self.config.extra_hand_bonus, self.config.extra_discard_bonus, self.config.hand_size, self.config.ante_scaling}
        }
    end,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                construct_mahjong_deck()
                return true
            end
        }))
    end
}

SMODS.Back {
    key = "mahjong_true",
    pos = {
        x = 3,
        y = 3
    },
    config = {
        discards = 17,
        hand_size = 14,
        ante_scaling = 4
    },
    loc_vars = function(self, intro_queue, back)
            return {
                vars = {self.config.discards, self.config.hand_size, self.config.ante_scaling}
            }
    end,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                construct_mahjong_deck()
                SMODS.change_discard_limit(-13)
                return true
            end
        }))
    end
}