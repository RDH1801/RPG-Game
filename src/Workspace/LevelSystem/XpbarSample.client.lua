-- Client-Side Script for Enhanced XP Bar UI

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create the ScreenGui container for the XP bar
local xpBarGui = Instance.new("ScreenGui")
xpBarGui.Parent = playerGui

-- Create the frame for the XP bar
local xpBarFrame = Instance.new("Frame")
xpBarFrame.Size = UDim2.new(0.5, 0, 0.05, 0)  -- 50% width of the screen, small height
xpBarFrame.Position = UDim2.new(0.25, 0, 0.9, 0)  -- Positioned at the bottom of the screen
xpBarFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Black background for the bar frame
xpBarFrame.BorderSizePixel = 2  -- Border size for the frame
xpBarFrame.BorderColor3 = Color3.fromRGB(200, 200, 200)  -- Light gray border
xpBarFrame.Parent = xpBarGui

-- Add rounded corners to the XP bar frame
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)  -- Rounded corners
corner.Parent = xpBarFrame

-- Create the fill for the XP bar
local xpBarFill = Instance.new("Frame")
xpBarFill.Size = UDim2.new(0, 0, 1, 0)  -- Start with 0 width (empty bar)
xpBarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)  -- Green color for XP
xpBarFill.BorderSizePixel = 0  -- No border for the fill
xpBarFill.Parent = xpBarFrame

-- Add rounded corners to the XP bar fill
local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(0, 8)  -- Rounded corners for the fill
fillCorner.Parent = xpBarFill

-- Create the text label showing the current level
local levelText = Instance.new("TextLabel")
levelText.Text = "Level: 1"  -- Placeholder text, will be updated
levelText.Position = UDim2.new(0.5, 0, 0, 0)
levelText.Size = UDim2.new(0, 100, 0, 30)
levelText.BackgroundTransparency = 1  -- No background
levelText.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text
levelText.TextScaled = true  -- Scale text to fit
levelText.TextStrokeTransparency = 0.8  -- Adds a slight stroke to make text stand out
levelText.Parent = xpBarGui

-- Add shadow effect to the text
local textShadow = Instance.new("TextLabel")
textShadow.Text = "Level: 1"
textShadow.Position = UDim2.new(0.5, 1, 0, 1)
textShadow.Size = UDim2.new(0, 100, 0, 30)
textShadow.BackgroundTransparency = 1
textShadow.TextColor3 = Color3.fromRGB(0, 0, 0)  -- Black shadow
textShadow.TextScaled = true
textShadow.TextStrokeTransparency = 0.8
textShadow.Parent = xpBarGui

-- Function to update the XP bar when XP changes
local function UpdateXPBar()
	local leaderstats = player:WaitForChild("leaderstats")
	local xpStat = leaderstats:WaitForChild("XP")
	local levelStat = leaderstats:WaitForChild("Level")
	local xpRequiredStat = leaderstats:WaitForChild("XPRequired")

	local xp = xpStat.Value
	local level = levelStat.Value
	local xpRequired = xpRequiredStat.Value

	-- Calculate the fill percentage of the XP bar
	local fillPercentage = xp / xpRequired
	xpBarFill.Size = UDim2.new(fillPercentage, 0, 1, 0)  -- Adjust the width of the fill bar

	-- Update the level text
	levelText.Text = "Level: " .. level
	textShadow.Text = "Level: " .. level  -- Update the shadow text as well
end

-- Update the XP bar initially
UpdateXPBar()

-- Listen for changes in XP or level
local leaderstats = player:WaitForChild("leaderstats")
leaderstats:WaitForChild("XP").Changed:Connect(UpdateXPBar)
leaderstats:WaitForChild("Level").Changed:Connect(UpdateXPBar)
