-- LevelSystem Script

local Players = game:GetService("Players")

local MAX_LEVEL = 100

-- Function to calculate XP required for next level
local function CalculateXPRequirement(level)
	-- Example formula: XP required increases by 100 each level
	return 100 + (level - 1) * 50
end

-- Function to handle XP and leveling up
local function OnXPChanged(player)
	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then return end

	local xpStat = leaderstats:FindFirstChild("XP")
	local levelStat = leaderstats:FindFirstChild("Level")
	local xpRequiredStat = leaderstats:FindFirstChild("XPRequired")

	if not xpStat or not levelStat or not xpRequiredStat then return end

	while xpStat.Value >= CalculateXPRequirement(levelStat.Value) and levelStat.Value < MAX_LEVEL do
		local requiredXP = CalculateXPRequirement(levelStat.Value)
		xpStat.Value = xpStat.Value - requiredXP
		levelStat.Value = levelStat.Value + 1
		xpRequiredStat.Value = CalculateXPRequirement(levelStat.Value)
	end

	if levelStat.Value >= MAX_LEVEL then
		xpStat.Value = 0
		xpRequiredStat.Value = 0
	end
end

-- Function to set up leaderstats for a player
local function SetupLeaderstats(player)
	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then
		leaderstats = Instance.new("Folder")
		leaderstats.Name = "leaderstats"
		leaderstats.Parent = player
	end

	local xpStat = leaderstats:FindFirstChild("XP")
	if not xpStat then
		xpStat = Instance.new("IntValue")
		xpStat.Name = "XP"
		xpStat.Value = 0
		xpStat.Parent = leaderstats
	end

	local levelStat = leaderstats:FindFirstChild("Level")
	if not levelStat then
		levelStat = Instance.new("IntValue")
		levelStat.Name = "Level"
		levelStat.Value = 1
		levelStat.Parent = leaderstats
	end

	local xpRequiredStat = leaderstats:FindFirstChild("XPRequired")
	if not xpRequiredStat then
		xpRequiredStat = Instance.new("IntValue")
		xpRequiredStat.Name = "XPRequired"
		xpRequiredStat.Value = CalculateXPRequirement(levelStat.Value)
		xpRequiredStat.Parent = leaderstats
	end

	-- Connect XP changed event to handle leveling up
	xpStat.Changed:Connect(function()
		OnXPChanged(player)
	end)

	-- Ensure XPRequired is always correct on join
	xpRequiredStat.Value = CalculateXPRequirement(levelStat.Value)
end

-- PlayerAdded event to set up leaderstats
Players.PlayerAdded:Connect(function(player)
	SetupLeaderstats(player)
end)

-- For players already in game (if script is reset)
for _, player in Players:GetPlayers() do
	SetupLeaderstats(player)
end

-- Function to save player stats (if needed elsewhere)
local function SavePlayerStats(player)
	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then return end

	local xpStat = leaderstats:FindFirstChild("XP")
	local levelStat = leaderstats:FindFirstChild("Level")
	local xpRequiredStat = leaderstats:FindFirstChild("XPRequired")
	-- Save logic here if needed
end

