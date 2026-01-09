-- Winds
SMODS.Rank {
    key = 'North',
    card_key = 'N',
    pos = {x = 3, y = 0},
    nominal = 25,
    bm_honor = true,
    shorthand = 'N',
    in_pool = function(self, args)
        if G.GAME.selected_back then
            return G.GAME.selected_back.effect.center.key == 'b_bm_mahjong_red'
        end
    end
}
SMODS.Rank {
    key = 'East',
    card_key = 'E',
    pos = {x = 4, y = 0},
    nominal = 25,
    bm_honor = true,
    shorthand = 'E',
    in_pool = function(self, args)
        if G.GAME.selected_back then
            return G.GAME.selected_back.effect.center.key == 'b_bm_mahjong_red'
        end
    end
}
SMODS.Rank {
    key = 'South',
    card_key = 'S',
    pos = {x = 5, y = 0},
    nominal = 25,
    bm_honor = true,
    shorthand = 'S',
    in_pool = function(self, args)
        if G.GAME.selected_back then
            return G.GAME.selected_back.effect.center.key == 'b_bm_mahjong_red'
        end
    end
}
SMODS.Rank {
    key = 'West',
    card_key = 'We',
    pos = {x = 6, y = 0},
    nominal = 25,
    bm_honor = true,
    shorthand = 'We',
    in_pool = function(self, args)
        if G.GAME.selected_back then
            return G.GAME.selected_back.effect.center.key == 'b_bm_mahjong_red'
        end
    end
}
-- Dragons
SMODS.Rank {
    key = 'Red',
    card_key = 'R',
    pos = {x = 0, y = 0},
    nominal = 25,
    bm_honor = true,
    shorthand = 'R',
    in_pool = function(self, args)
        if G.GAME.selected_back then
            return G.GAME.selected_back.effect.center.key == 'b_bm_mahjong_red'
        end
    end
}
SMODS.Rank {
    key = 'Green',
    card_key = 'G',
    pos = {x = 1, y = 0},
    nominal = 25,
    bm_honor = true,
    shorthand = 'G',
    in_pool = function(self, args)
        if G.GAME.selected_back then
            return G.GAME.selected_back.effect.center.key == 'b_bm_mahjong_red'
        end
    end
}
SMODS.Rank {
    key = 'White',
    card_key = 'Wh',
    pos = {x = 2, y = 0},
    nominal = 25,
    bm_honor = true,
    shorthand = 'Wh',
    in_pool = function(self, args)
        if G.GAME.selected_back then
            return G.GAME.selected_back.effect.center.key == 'b_bm_mahjong_red'
        end
    end
}