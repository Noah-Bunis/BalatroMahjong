SMODS.current_mod.calculate = function(self, context)
    if context.evaluate_poker_hand and context.before then
        if context.display_name == "bm_Tanyao" then
            return {
            message = 'Upgraded!',
            colour = G.C.RED
        }   
        end
    end
end