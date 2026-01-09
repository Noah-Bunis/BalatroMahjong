return {
    descriptions = {
        Back = {
            b_bm_mahjong_red = {
                name = "Mahjong Red Deck",
                text = {"{C:attention}Standard Mahjong Deck{}", "{C:red}+#1#{} discard", "every round"}
            },
            b_bm_mahjong_blue = {
                name = "Mahjong Blue Deck",
                text = {"{C:attention}Standard Mahjong Deck{}", "{C:blue}+#1#{} hand", "every round"}
            },
            b_bm_mahjong_yellow = {
                name = "Mahjong Yellow Deck",
                text = {"{C:attention}Standard Mahjong Deck{}", "Start with", "extra {C:money}$#1#"}
            },
            b_bm_mahjong_green = {
                name = "Mahjong Green Deck",
                text = {"{C:attention}Standard Mahjong Deck{}", "At end of each Round:",
                        "{C:money}$#1#{s:0.85} per remaining {C:blue}Hand",
                        "{C:money}$#2#{s:0.85} per remaining {C:red}Discard", "Earn no {C:attention}Interest"}
            }
        },
        Tag = {
            tag_bm_WindTriplet = {
                name = "Wind Triplet Yaku",
                text = {"Reward for scoring a {C:red}Wind Triplet{} ({C:money}$1{})"}
            }, -- 1 han
            tag_bm_DragonTriplet = {
                name = "Dragon Triplet Yaku",
                text = {"Reward for scoring a {C:red}Dragon Triplet{} ({C:money}$1{})"}
            }, -- 1 han
            tag_bm_Tanyao = {
                name = "Tanyao Yaku",
                text = {"Reward for scoring a {C:red}Tanyao{} ({C:money}$1{})"}
            }, -- 1 han

            tag_bm_Honroutou = {
                name = "All Terminals and Honors Yaku",
                text = {"Reward for scoring a {C:red}All Terminals and Honors{} ({C:money}$2{})"}
            }, -- 2 han

            tag_bm_Chinroutou = {
                name = "All Terminals Yaku",
                text = {"Reward for scoring a {C:red}All Terminals{} ({C:money}$13{})"}
            }, -- Yakuman

            tag_bm_SevenPairs = {
                name = "Seven Pairs Yaku",
                text = {"Reward for scoring a {C:red}Seven Pairs{} ({C:money}$2{})"}
            }, -- 2 han

            tag_bm_PureDoubleChi = {
                name = "Pure Double Chi Yaku",
                text = {"Reward for scoring a {C:red}Pure Double Chi{} ({C:money}$1{})"}
            }, -- 1 han

            tag_bm_TwicePureDoubleChi = {
                name = "Twice Pure Double Chi Yaku",
                text = {"Reward for scoring a {C:red}Twice Pure Double Chi{} ({C:money}$3{})"}
            }, -- 3 han

            tag_bm_OutsideHand = {
                name = "Outside Hand Yaku",
                text = {"Reward for scoring a {C:red}Outside Hand{} ({C:money}$2{})"}
            }, -- 2 han

            tag_bm_PureStraight = {
                name = "Pure Straight Yaku",
                text = {"Reward for scoring a {C:red}Pure Straight{} ({C:money}$2{})"}
            }, -- 2 han

            tag_bm_HalfFlush = {
                name = "Half Flush Yaku",
                text = {"Reward for scoring a {C:red}Half Flush{} ({C:money}$3{})"}
            }, -- 3 han

            tag_bm_FullFlush = {
                name = "Full Flush Yaku",
                text = {"Reward for scoring a {C:red}Full Flush{} ({C:money}$6{})"}
            }, -- 6 han

            tag_bm_ThirteenOrphans = {
                name = "Thirteen Orphans Yaku",
                text = {"Reward for scoring a {C:red}Thirteen Orphans{} ({C:money}$13{})"}
            }, -- Yakuman

            tag_bm_Tsuiisou = {
                name = "All Honors Yaku",
                text = {"Reward for scoring a {C:red}All Honors{} ({C:money}$13{})"}
            }, -- Yakuman

            tag_bm_LittleFourWinds = {
                name = "Little Four Winds Yaku",
                text = {"Reward for scoring a {C:red}Little Four Winds{} ({C:money}$13{})"}
            }, -- Yakuman

            tag_bm_BigFourWinds = {
                name = "Big Four Winds Yaku",
                text = {"Reward for scoring a {C:red}Big Four Winds{} ({C:money}$13{})"}
            }, -- Yakuman

            tag_bm_Junchan = {
                name = "Terminal in Each Group Yaku",
                text = {"Reward for scoring a {C:red}Terminal in Each Group{} ({C:money}$3{})"}
            } -- 3 han

        },
        Joker = {
            j_bm_sample_wee = {
                name = "Sample Wee",
                text = {"This Joker gains", "{C:chips}+#2#{} Chips when each", "played {C:attention}2{} is scored",
                        "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"}
            },
            j_bm_sample_obelisk = {
                name = "Sample Obelisk",
                text = {{"This Joker gives {X:mult,C:white} X#1# {} Mult",
                         "for each time you've played this {C:attention}hand"}}
            },
            j_bm_sample_specifichand = {
                name = "Sample Specific Hand",
                text = {{"If the hand played is #1#,", "Gives {X:mult,C:white} X#2# {} Mult"}}
            },
            j_bm_sample_money = {
                name = "Sample Money",
                text = {{"Earn (Ante x 2) {C:money}${} at", "end of round, also here's some text effects:",
                         "{C:money} money{}, {C:chips} chips{}, {C:mult} mult{}, {C:red} red{}, {C:blue} blue{}, {C:green} green{}",
                         "{C:attention} attention{}, {C:purple} purple{}, {C:inactive} inactive{}",
                         "{C:spades} spades{}, {C:hearts} hearts{}, {C:clubs} clubs{}, {C:diamonds} diamonds{}",
                         "{C:tarot} tarot{}, {C:planet} planet{}, {C:spectral} spectral{}",
                         "{C:edition} edition{}, {C:dark_edition} dark edition{}, {C:legendary} legendary{}, {C:enhanced} enhanced{}"}}
            },
            j_bm_sample_roomba = {
                name = "Sample Roomba",
                text = {{"Attempts to remove edition", "from another Joker", "at the end of each round",
                         "{C:inactive}(Foil, Holo, Polychrome)"}}
            },
            j_bm_sample_drunk_juggler = {
                name = "Sample Drunk Juggler",
                text = {{"{C:red}+#1#{} discard,", "also here's some {X:legendary,C:white}text effects{}:",
                         "{s:0.5} scaled down by 0.5", "{C:attention,T:tag_double}#2#"}}
            },
            j_bm_sample_hackerman = {
                name = "Sample Hackerman",
                text = {{"Retrigger", "each played",
                         "{C:attention}6{}, {C:attention}7{}, {C:attention}8{}, or {C:attention}9{}"}}
            },
            j_bm_sample_baroness = {
                name = "Sample Baroness",
                text = {{"Each {C:attention}Queen{}", "held in hand", "gives {X:mult,C:white} X#1# {} Mult"}}
            },
            j_bm_sample_rarebaseballcard = {
                name = "Sample Rare Baseball Card",
                text = {{"{X:mult,C:white}Rare{} Jokers", "each give {X:mult,C:white} X#1# {} Mult"}}
            },
            j_bm_sample_multieffect = {
                name = "Sample Multi-Effect",
                text = {{"Each played {C:attention}10{}", "gives {C:chips}+#1#{} Chips and",
                         "{C:mult}+#2#{} Mult when scored"}}
            }
        }
    },
    misc = {

        -- do note that when using messages such as: 
        -- message = localize{type='variable',key='a_xmult',vars={current_xmult}},
        -- that the key 'a_xmult' will use provided values from vars={} in that order to replace #1#, #2# etc... in the localization file.

        dictionary = {
            a_chips = "+#1#",
            a_chips_minus = "-#1#",
            a_hands = "+#1# Hands",
            a_handsize = "+#1# Hand Size",
            a_handsize_minus = "-#1# Hand Size",
            a_mult = "+#1# Mult",
            a_mult_minus = "-#1# Mult",
            a_remaining = "#1# Remaining",
            a_sold_tally = "#1#/#2# Sold",
            a_xmult = "X#1# Mult",
            a_xmult_minus = "-X#1# Mult",

            ph_bm_WindTriplet = "Wind Triplet",
            ph_bm_DragonTriplet = "Dragon Triplet",
            ph_bm_Tanyao = "Tanyao",
            ph_bm_Honroutou = "All Terminals and Honors",
            ph_bm_Chinroutou = "All Terminals",
            ph_bm_SevenPairs = "Seven Pairs",
            ph_bm_PureDoubleChi = "Pure Double Chi",
            ph_bm_TwicePureDoubleChi = "Twice Pure Double Chi",
            ph_bm_OutsideHand = "Outside Hand",
            ph_bm_PureStraight = "Pure Straight",
            ph_bm_HalfFlush = "Half Flush",
            ph_bm_FullFlush = "Full Flush",
            ph_bm_ThirteenOrphans = "Thirteen Orphans",
            ph_bm_Tsuiisou = "All Honors",
            ph_bm_LittleFourWinds = "Little Four Winds",
            ph_bm_BigFourWinds = "Big Four Winds",
            ph_bm_Junchan = "Terminal in Each Group"

        },

        poker_hand_descriptions = {
            ["bm_WindTriplet"] = {"A Mahjong hand that contains a triplet of Wind cards"},
            ["bm_DragonTriplet"] = {"A Mahjong hand that contains a triplet of Dragon cards"},
            ["bm_Tanyao"] = {"A Mahjong hand that does not contain any honor cards or terminals (Kings or Aces)."},
            ["bm_Honroutou"] = {"A Mahjong hand that contains only honor cards or terminals (Kings or Aces)."},
            ["bm_Chinroutou"] = {"A Mahjong hand that contains only terminals (Kings or Aces)."},
            ["bm_SevenPairs"] = {"Seven unique Pairs."},
            ["bm_PureDoubleChi"] = {"Two identical Chows in the same suit."},
            ["bm_TwicePureDoubleChi"] = {"Two sets of Pure Double Chi in the same suit."},
            ["bm_OutsideHand"] = {"A Mahjong hand where all sets contain at least one terminal (Kings or Aces) or Honor."},
            ["bm_PureStraight"] = {"A Mahjong hand that contains a sequence from 2 to 10 in the same suit."},
            ["bm_HalfFlush"] = {"A Mahjong hand that contains tiles from one suit and honor tiles."},
            ["bm_FullFlush"] = {"A Mahjong hand that contains tiles from only one suit."},
            ["bm_ThirteenOrphans"] = {"A Mahjong hand consisting of one of each honor tile and terminal"},
            ["bm_Tsuiisou"] = {"A Mahjong hand that contains only honor tiles."},
            ["bm_LittleFourWinds"] = {"A Mahjong hand that contains Pungs or Kongs of three Winds and a Pair of the fourth Wind."},
            ["bm_BigFourWinds"] = {"A Mahjong hand that contains Pungs or Kongs of all four Winds."},
            ["bm_Junchan"] = {"A Mahjong hand where all sets contain at least one terminal (Kings or Aces)."}
        },
        poker_hands = {
            ["bm_WindTriplet"] = "Wind Triplet",
            ["bm_DragonTriplet"] = "Dragon Triplet",
            ["bm_Tanyao"] = "Tanyao",
            ["bm_Honroutou"] = "All Terminals and Honors",
            ["bm_Chinroutou"] = "All Terminals",
            ["bm_SevenPairs"] = "Seven Pairs",
            ["bm_PureDoubleChi"] = "Pure Double Chi",
            ["bm_TwicePureDoubleChi"] = "Twice Pure Double Chi",
            ["bm_OutsideHand"] = "Outside Hand",
            ["bm_PureStraight"] = "Pure Straight",
            ["bm_HalfFlush"] = "Half Flush",
            ["bm_FullFlush"] = "Full Flush",
            ["bm_ThirteenOrphans"] = "Thirteen Orphans",
            ["bm_Tsuiisou"] = "All Honors",
            ["bm_LittleFourWinds"] = "Little Four Winds",
            ["bm_BigFourWinds"] = "Big Four Winds",
            ["bm_Junchan"] = "Terminal in Each Group"
        },
        ranks = {
            bm_North = "North",
            bm_East = "East",
            bm_South = "South",
            bm_West = "West",
            bm_Red = "Red",
            bm_Green = "Green",
            bm_White = "White"
        },
        suits_plural = {
            bm_Winds = "Winds",
            bm_Dragons = "Dragons"
        },
        suits_singular = {
            bm_Winds = "Wind",
            bm_Dragons = "Dragon"
        }
    }
}
