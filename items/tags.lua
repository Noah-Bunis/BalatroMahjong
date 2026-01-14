SMODS.Tag {
    key = "WindTriplet",
    pos = { x = 2, y = 1 },
    config = { dollars = 1 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.dollars } }
    end,
    in_pool = function(self, args) return false end,
    apply = function(self, tag, context)
        if context.type == 'eval' then
            tag:yep('+', G.C.GOLD, function() return true end)
            tag.triggered = true
            return {
                dollars = tag.config.dollars,
                condition = localize('ph_bm_WindTriplet'),
                pos = tag.pos,
                tag = tag
            }
        end
    end
}

SMODS.Tag {
    key = "DragonTriplet",
    pos = { x = 2, y = 1 },
    config = { dollars = 1 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.dollars } }
    end,
    in_pool = function(self, args) return false end,
    apply = function(self, tag, context)
        if context.type == 'eval' then
            tag:yep('+', G.C.GOLD, function() return true end)
            tag.triggered = true
            return {
                dollars = tag.config.dollars,
                condition = localize('ph_bm_DragonTriplet'),
                pos = tag.pos,
                tag = tag
            }
        end
    end
}

SMODS.Tag {
    key = "Tanyao",
    pos = { x = 2, y = 1 },
    config = { dollars = 1 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.dollars } }
    end,
    in_pool = function(self, args) return false end,
    apply = function(self, tag, context)
        if context.type == 'eval' then
            tag:yep('+', G.C.GOLD, function() return true end)
            tag.triggered = true
            return {
                dollars = tag.config.dollars,
                condition = localize('ph_bm_Tanyao'),
                pos = tag.pos,
                tag = tag
            }
        end
    end
}

SMODS.Tag {
    key = "Honroutou",
    pos = { x = 2, y = 1 },
    config = { dollars = 2 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.dollars } }
    end,
    in_pool = function(self, args) return false end,
    apply = function(self, tag, context)
        if context.type == 'eval' then
            tag:yep('+', G.C.GOLD, function() return true end)
            tag.triggered = true
            return {
                dollars = tag.config.dollars,
                condition = localize('ph_bm_Honroutou'),
                pos = tag.pos,
                tag = tag
            }
        end
    end
}

SMODS.Tag {
    key = "Chinroutou",
    pos = { x = 2, y = 1 },
    config = { dollars = 13 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.dollars } }
    end,
    in_pool = function(self, args) return false end,
    apply = function(self, tag, context)
        if context.type == 'eval' then
            tag:yep('+', G.C.GOLD, function() return true end)
            tag.triggered = true
            return {
                dollars = tag.config.dollars,
                condition = localize('ph_bm_Chinroutou'),
                pos = tag.pos,
                tag = tag
            }
        end
    end
}

SMODS.Tag {
    key = "SevenPairs",
    pos = { x = 2, y = 1 },
    config = { dollars = 2 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.dollars } }
    end,
    in_pool = function(self, args) return false end,
    apply = function(self, tag, context)
        if context.type == 'eval' then
            tag:yep('+', G.C.GOLD, function() return true end)
            tag.triggered = true
            return {
                dollars = tag.config.dollars,
                condition = localize('ph_bm_SevenPairs'),
                pos = tag.pos,
                tag = tag
            }
        end
    end
}

SMODS.Tag {
    key = "PureDoubleChi",
    pos = { x = 2, y = 1 },
    config = { dollars = 1 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.dollars } }
    end,
    in_pool = function(self, args) return false end,
    apply = function(self, tag, context)
        if context.type == 'eval' then
            tag:yep('+', G.C.GOLD, function() return true end)
            tag.triggered = true
            return {
                dollars = tag.config.dollars,
                condition = localize('ph_bm_PureDoubleChi'),
                pos = tag.pos,
                tag = tag
            }
        end
    end
}

SMODS.Tag {
    key = "TwicePureDoubleChi",
    pos = { x = 2, y = 1 },
    config = { dollars = 3 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.dollars } }
    end,
    in_pool = function(self, args) return false end,
    apply = function(self, tag, context)
        if context.type == 'eval' then
            tag:yep('+', G.C.GOLD, function() return true end)
            tag.triggered = true
            return {
                dollars = tag.config.dollars,
                condition = localize('ph_bm_TwicePureDoubleChi'),
                pos = tag.pos,
                tag = tag
            }
        end
    end
}

SMODS.Tag {
    key = "OutsideHand",
    pos = { x = 2, y = 1 },
    config = { dollars = 2 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.dollars } }
    end,
    in_pool = function(self, args) return false end,
    apply = function(self, tag, context)
        if context.type == 'eval' then
            tag:yep('+', G.C.GOLD, function() return true end)
            tag.triggered = true
            return {
                dollars = tag.config.dollars,
                condition = localize('ph_bm_OutsideHand'),
                pos = tag.pos,
                tag = tag
            }
        end
    end
}

SMODS.Tag {
    key = "PureStraight",
    pos = { x = 2, y = 1 },
    config = { dollars = 2 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.dollars } }
    end,
    in_pool = function(self, args) return false end,
    apply = function(self, tag, context)
        if context.type == 'eval' then
            tag:yep('+', G.C.GOLD, function() return true end)
            tag.triggered = true
            return {
                dollars = tag.config.dollars,
                condition = localize('ph_bm_PureStraight'),
                pos = tag.pos,
                tag = tag
            }
        end
    end
}

SMODS.Tag {
    key = "HalfFlush",
    pos = { x = 2, y = 1 },
    config = { dollars = 3 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.dollars } }
    end,
    in_pool = function(self, args) return false end,
    apply = function(self, tag, context)
        if context.type == 'eval' then
            tag:yep('+', G.C.GOLD, function() return true end)
            tag.triggered = true
            return {
                dollars = tag.config.dollars,
                condition = localize('ph_bm_HalfFlush'),
                pos = tag.pos,
                tag = tag
            }
        end
    end
}

SMODS.Tag {
    key = "FullFlush",
    pos = { x = 2, y = 1 },
    config = { dollars = 6 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.dollars } }
    end,
    in_pool = function(self, args) return false end,
    apply = function(self, tag, context)
        if context.type == 'eval' then
            tag:yep('+', G.C.GOLD, function() return true end)
            tag.triggered = true
            return {
                dollars = tag.config.dollars,
                condition = localize('ph_bm_FullFlush'),
                pos = tag.pos,
                tag = tag
            }
        end
    end
}

SMODS.Tag {
    key = "ThirteenOrphans",
    pos = { x = 2, y = 1 },
    config = { dollars = 13 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.dollars } }
    end,
    in_pool = function(self, args) return false end,
    apply = function(self, tag, context)
        if context.type == 'eval' then
            tag:yep('+', G.C.GOLD, function() return true end)
            tag.triggered = true
            return {
                dollars = tag.config.dollars,
                condition = localize('ph_bm_ThirteenOrphans'),
                pos = tag.pos,
                tag = tag
            }
        end
    end
}

SMODS.Tag {
    key = "Tsuiisou",
    pos = { x = 2, y = 1 },
    config = { dollars = 13 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.dollars } }
    end,
    in_pool = function(self, args) return false end,
    apply = function(self, tag, context)
        if context.type == 'eval' then
            tag:yep('+', G.C.GOLD, function() return true end)
            tag.triggered = true
            return {
                dollars = tag.config.dollars,
                condition = localize('ph_bm_Tsuiisou'),
                pos = tag.pos,
                tag = tag
            }
        end
    end
}

SMODS.Tag {
    key = "LittleFourWinds",
    pos = { x = 2, y = 1 },
    config = { dollars = 13 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.dollars } }
    end,
    in_pool = function(self, args) return false end,
    apply = function(self, tag, context)
        if context.type == 'eval' then
            tag:yep('+', G.C.GOLD, function() return true end)
            tag.triggered = true
            return {
                dollars = tag.config.dollars,
                condition = localize('ph_bm_LittleFourWinds'),
                pos = tag.pos,
                tag = tag
            }
        end
    end
}

SMODS.Tag {
    key = "BigFourWinds",
    pos = { x = 2, y = 1 },
    config = { dollars = 13 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.dollars } }
    end,
    in_pool = function(self, args) return false end,
    apply = function(self, tag, context)
        if context.type == 'eval' then
            tag:yep('+', G.C.GOLD, function() return true end)
            tag.triggered = true
            return {
                dollars = tag.config.dollars,
                condition = localize('ph_bm_BigFourWinds'),
                pos = tag.pos,
                tag = tag
            }
        end
    end
}

SMODS.Tag {
    key = "Junchan",
    pos = { x = 2, y = 1 },
    config = { dollars = 3 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.dollars } }
    end,
    in_pool = function(self, args) return false end,
    apply = function(self, tag, context)
        if context.type == 'eval' then
            tag:yep('+', G.C.GOLD, function() return true end)
            tag.triggered = true
            return {
                dollars = tag.config.dollars,
                condition = localize('ph_bm_Junchan'),
                pos = tag.pos,
                tag = tag
            }
        end
    end
}

SMODS.Tag {
    key = "NineGates",
    pos = { x = 2, y = 1 },
    config = { dollars = 13 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.dollars } }
    end,
    in_pool = function(self, args) return false end,
    apply = function(self, tag, context)
        if context.type == 'eval' then
            tag:yep('+', G.C.GOLD, function() return true end)
            tag.triggered = true
            return {
                dollars = tag.config.dollars,
                condition = localize('ph_bm_NineGates'),
                pos = tag.pos,
                tag = tag
            }
        end
    end
}

