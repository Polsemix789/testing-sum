	local script = Instance.new('LocalScript', toggle)

	
	
	_G.silentaim = false
	script.Parent.MouseButton1Click:Connect(function()
		if _G.silentaim == false then
			_G.silentaim = true
			script.Parent.Text = "On"
			script.Parent.TextColor3 = Color3.fromRGB(136, 255, 0)
		else
			_G.silentaim = false
			script.Parent.Text = "Off"
			script.Parent.TextColor3 = Color3.fromRGB(255, 0, 4)
		end
	end)
	
	local players = game:GetService("Players")
	local plr = players.LocalPlayer
	local mouse = plr:GetMouse()
	local camera = game.Workspace.CurrentCamera
	local teamcheck = true
	
local function ClosestPlayerToMouse()
    local target = nil
    local dist = math.huge
for i,v in pairs(players:GetPlayers()) do
    if v.Name ~= plr.Name then
        if v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") and _G.silentaim and teamcheck and v.TeamColor ~= plr.TeamColor then
            local screenpoint = camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
					local check = (Vector2.new(mouse.X,mouse.Y)-Vector2.new(screenpoint.X,screenpoint.Y)).magnitude

            if check < dist then
                target  = v
                dist = check
            end
        end
    end
end

return target 
end
	
	local mt = getrawmetatable(game)
	local namecall = mt.__namecall
	setreadonly(mt,false)

	mt.__namecall = function(self,...)
		local args = {...}
		local method = getnamecallmethod()

		if tostring(self) == "HitPart" and method == "FireServer" then
			print("so?")
			args[1] = ClosestPlayerToMouse().Character.Head
			args[2] = ClosestPlayerToMouse().Character.Head.Position
			return self.FireServer(self, unpack(args))
		end
		return namecall(self,...)
	end
end
