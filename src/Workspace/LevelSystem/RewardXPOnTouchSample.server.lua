local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Reference the XPEvent, create if it doesn't exist
local xpEvent = ReplicatedStorage:FindFirstChild("XPEvent")
if not xpEvent then
	xpEvent = Instance.new("RemoteEvent")  -- Create new RemoteEvent
	xpEvent.Name = "XPEvent"  -- Name it properly
	xpEvent.Parent = ReplicatedStorage  -- Parent it to ReplicatedStorage
end

-- Reference the part that the player will touch
local partToTouch = workspace:WaitForChild("Part")  -- Change "Part" to the name of your part

-- Function to give XP to the player
local function giveXP(player, amount)
	if amount > 0 then
		print("Firing XPEvent with amount:", amount)  -- Debug print
		-- Update the player's XP on the server
		local leaderstats = player:FindFirstChild("leaderstats")
		if leaderstats then
			local xpStat = leaderstats:FindFirstChild("XP")
			if xpStat then
				xpStat.Value = xpStat.Value + amount  -- Update XP
				print("Player's new XP:", xpStat.Value)  -- Debug print for updated XP
			end
		end
	else
		print("Invalid XP amount")  -- Debug print if the amount is zero or less
	end
end

-- Touch event for the part
partToTouch.Touched:Connect(function(hit)
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	if player then
		print(player.Name .. " touched the part!")
		giveXP(player, 100)  -- Give 100 XP when the part is touched
		-- Fire the XPEvent after giving XP
		xpEvent:FireClient(player, 100)  -- Send XP amount to client
	end
end)
