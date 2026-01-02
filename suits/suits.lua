SMODS.Suit {
    key = 'Winds',
    card_key = 'Wi',
    pos = {x = 0, y = 0},
    ui_pos = {x=0,y=0},
    keep_base_colors = true,
    in_pool = function(self, args)
        if G.GAME.selected_back then
            return G.GAME.selected_back.effect.center.key == 'b_bm_mahjong_red'
        end
    end
}
SMODS.Suit {
    key = 'Dragons',
    card_key = 'D',
    pos = {x = 0, y = 0},
    ui_pos = {x=0,y=0},
    keep_base_colors = true,
    in_pool = function(self, args)
        if G.GAME.selected_back then
            return G.GAME.selected_back.effect.center.key == 'b_bm_mahjong_red'
        end
    end
}