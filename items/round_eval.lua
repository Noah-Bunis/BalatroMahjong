local yaku = {"bm_WindTriplet", "bm_DragonTriplet", "bm_Tanyao", "bm_Honroutou", "bm_Chinroutou", "bm_SevenPairs",
              "bm_PureDoubleChi", "bm_TwicePureDoubleChi", "bm_OutsideHand", "bm_PureStraight", "bm_HalfFlush",
              "bm_FullFlush", "bm_ThirteenOrphans", "bm_Tsuiisou", "bm_LittleFourWinds", "bm_BigFourWinds", "bm_Junchan"}
local restricted_hands = {"Flush Five", "Flush House", "Straight Flush", "Royal Flush"}

SMODS.current_mod.calculate = function(self, context)
    if context.before then
        for i = 1, #yaku do
            if next(context.poker_hands[yaku[i]]) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        add_tag(Tag(("tag_" .. yaku[i])))
                        play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                        return true
                    end
                }))
            end
        end
    end
    if context.debuff_hand then
        if string.find(G.GAME.selected_back.effect.center.key, 'b_bm_mahjong') and #context.full_hand > 5 then
            for i = 1, #restricted_hands do
                if context.scoring_name == restricted_hands[i] then
                    return {
                        debuff = true
                    }
                end
            end
        end
    end
end
