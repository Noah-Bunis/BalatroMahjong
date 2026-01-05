BalatroMahjong = {}

assert(SMODS.load_file("globals.lua"))()

-- Jokers
local joker_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "jokers")
for _, file in ipairs(joker_src) do
    assert(SMODS.load_file("jokers/" .. file))()
end

-- Poker Hands
local pokerhands_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "pokerhands")
for _, file in ipairs(pokerhands_src) do
    assert(SMODS.load_file("pokerhands/" .. file))()
end

-- Decks
local decks_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "decks")
for _, file in ipairs(decks_src) do
    assert(SMODS.load_file("decks/" .. file))()
end

-- Ranks
local ranks_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "ranks")
for _, file in ipairs(ranks_src) do
    assert(SMODS.load_file("ranks/" .. file))()
end

-- Suits
local suits_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "suits")
for _, file in ipairs(suits_src) do
    assert(SMODS.load_file("suits/" .. file))()
end

-- Round Evaluation
local round_eval_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "round_eval")
for _, file in ipairs(round_eval_src) do
    assert(SMODS.load_file("round_eval/" .. file))()
end

-- Tags
local tags_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "tags")
for _, file in ipairs(tags_src) do
    assert(SMODS.load_file("tags/" .. file))()
end

