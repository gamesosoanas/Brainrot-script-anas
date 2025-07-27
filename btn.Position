local Players = game:GetService("Players")
local Replicated = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

getgenv().AutoSteal = false
getgenv().AutoLock = false

-- Anti-Kick
local mt = getrawmetatable(game)
local namecall = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    if getnamecallmethod() == "Kick" then
        return
    end
    return namecall(self, unpack(args))
end)
setreadonly(mt, true)

-- Anti-Cheat Bypass
if Replicated:FindFirstChild("AntiCheat") then
    Replicated.AntiCheat:Destroy()
end

-- Auto Steal
local function stealBrainrot()
    if not getgenv().AutoSteal then return end
    for _, tool in ipairs(workspace:GetDescendants()) do
        if tool.Name == "Brainrot" and tool:IsA("Tool") and tool:FindFirstChild("Handle") then
            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, tool.Handle, 0)
            wait(0.1)
            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, tool.Handle, 1)
        end
    end
end

-- Auto Lock Base
local function lockBase()
    if getgenv().AutoLock and Replicated:FindFirstChild("LockBase") then
        Replicated.LockBase:FireServer()
    end
end

-- Teleport to Base
local function teleportBase()
    if workspace:FindFirstChild(LocalPlayer.Name.."'s Base") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = workspace[LocalPlayer.Name.."'s Base"].PrimaryPart.CFrame + Vector3.new(0, 5, 0)
    end
end

-- UI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "BrainrotUI"

local function createBtn(text, pos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 180, 0, 40)
    btn.Position = pos
    btn.Text = text
    btn.TextScaled = true
    btn.BackgroundColor3 = Color3.fromRGB(80, 80, 255)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BorderSizePixel = 0
    btn.Parent = ScreenGui
    btn.MouseButton1Click:Connect(callback)
end

createBtn("Auto Steal", UDim2.new(0, 20, 0, 100), function()
    getgenv().AutoSteal = not getgenv().AutoSteal
end)

createBtn("Auto Lock", UDim2.new(0, 20, 0, 150), function()
    getgenv().AutoLock = not getgenv().AutoLock
end)

createBtn("Teleport Base", UDim2.new(0, 20, 0, 200), function()
    teleportBase()
end)

RunService.RenderStepped:Connect(function()
    if getgenv().AutoSteal then stealBrainrot() end
    if getgenv().AutoLock then lockBase() end
end)
