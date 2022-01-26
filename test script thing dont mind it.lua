local localPlayer = game:GetService("Players").LocalPlayer
local mouse = localPlayer:GetMouse()
local camera = game.Workspace.CurrentCamera
local team = true

local function closestplayer()
    local target = nil
    local dist = math.huge
for i,v in pairs(game:GetService("Players"):GetPlayers()) do
    if v.Name ~= localPlayer.Name then
        if v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") and team and v.TeamColor ~= localPlayer.TeamColor then
            local magnitude = camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
            local check = (Vector2.new(mouse.X,mouse.Y)-Vector2.new(magnitude.X,magnitude.Y)).magnitude

            if check < dist then
                target  = v
                dist = check
            end
        elseif v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Head") and team == false then
            local magnitude = camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
            local check = (Vector2.new(mouse.X,mouse.Y)-Vector2.new(magnitude.X,magnitude.Y)).magnitude

            if check < dist then
                target  = v
                dist = check
            end
        end
    end
end

return target 
end


local camera = game.Workspace.CurrentCamera
local UIS = game:GetService("UserInputService")
local aim = false

game:GetService("RunService").RenderStepped:Connect(function()
    if aim then
        camera.CFrame = CFrame.new(camera.CFrame.Position,closestplayer().Character.Head.Position)
    end
end)

UIS.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton2 then
        aim = true
    end
end)

UIS.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton2 then
        aim = false
    end
end)
