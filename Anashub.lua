local Players = game:GetService("Players")
local Replicated = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Anti-Kick
local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    if tostring(self) == "Kick" then
        return nil
    end
    return old(self, unpack(args))
end)

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.ResetOnSpawn = false

local autoSteal, autoLock = false, false

local function button(name, pos, func)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 130, 0, 35)
    b.Position = pos
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 14
    b.Text = name
    b.Parent = gui
    b.MouseButton1Click:Connect(func)
end

local function trySteal()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Tool") and v.Name == "Brainrot" and v:FindFirstChild("Handle") then
            firetouchinterest(char.HumanoidRootPart, v.Handle, 0)
            task.wait(0.1)
            firetouchinterest(char.HumanoidRootPart, v.Handle, 1)
        end
    end
end

local function teleportBase()
    local base = workspace:FindFirstChild(LocalPlayer.Name .. "'s Base")
    if base and base:FindFirstChild("Baseplate") then
        LocalPlayer.Character:MoveTo(base.Baseplate.Position + Vector3.new(0, 3, 0))
    end
end

local function lockBase()
    local r = Replicated:FindFirstChild("LockBase")
    if r then r:FireServer() end
end

RunService.RenderStepped:Connect(function()
    if autoSteal then trySteal() end
    if autoLock then lockBase() end
end)

button("Toggle Auto Steal", UDim2.new(0, 10, 0, 300), function()
    autoSteal = not autoSteal
end)

button("Teleport to Base", UDim2.new(0, 10, 0, 350), function()
    teleportBase()
end)

button("Toggle Auto Lock Base", UDim2.new(0, 10, 0, 400), function()
    autoLock = not autoLock
end)
