local yaku = {"bm_Tanyao", "bm_Honroutou", "bm_Chinroutou", "bm_SevenPairs", "bm_PureDoubleChi",
              "bm_TwicePureDoubleChi", "bm_OutsideHand", "bm_PureStraight", "bm_HalfFlush", "bm_FullFlush",
              "bm_ThirteenOrphans", "bm_Tsuiisou", "bm_LittleFourWinds", "bm_BigFourWinds", "bm_Junchan"}

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
end