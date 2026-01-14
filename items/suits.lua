SMODS.Suit {
    key = 'Winds',
    card_key = 'Wi',
    lc_atlas = 'bm_honors',
    hc_atlas = 'bm_honors',
    pos = {
        x = 0,
        y = 0
    },
    ui_pos = {
        x = 0,
        y = 0
    },
    keep_base_colors = true,
    in_pool = function(self, args)
        if G.GAME.selected_back then
            if string.find(G.GAME.selected_back.effect.center.key, 'b_bm_mahjong') then
                local legal_ranks = {
                    bm_North = true,
                    bm_East = true,
                    bm_South = true,
                    bm_West = true
                }
                if args and legal_ranks[args.rank] then
                    return true
                end
            end
        end
    end
}
SMODS.Suit {
    key = 'Dragons',
    card_key = 'D',
    lc_atlas = 'bm_honors',
    hc_atlas = 'bm_honors',
    pos = {
        x = 0,
        y = 0
    },
    ui_pos = {
        x = 0,
        y = 0
    },
    keep_base_colors = true,
    in_pool = function(self, args)
        if G.GAME.selected_back then
            if string.find(G.GAME.selected_back.effect.center.key, 'b_bm_mahjong') then
                local legal_ranks = {
                    bm_Red = true,
                    bm_White = true,
                    bm_Green = true
                }
                if args and legal_ranks[args.rank] then
                    return true
                end
            end
        end
    end
}

SMODS.Atlas {
    key = "bm_honors",
    path = "honors.png",
    px = 71,
    py = 95
}
