local Gui = Instance.new("ScreenGui", game.CoreGui)
local FB = Instance.new("TextButton", Gui)
local SB = Instance.new("TextBox", FB)
local LP = game.Players.LocalPlayer
local CH = LP.Character
local On = false

FB.BackgroundColor3 = Color3.new(0,90,0)
FB.BorderColor3 = Color3.new(0,0,0)
FB.Position = UDim2.new(0.9,0,0,0)
FB.Size = UDim2.new(0,40,0,40)
FB.Font = "SourceSans"
FB.Text = "Fly"
FB.TextColor3 = Color3.new(0,0,0)
FB.TextSize = 14
FB.TextStrokeColor3 = Color3.new(1, 1, 1)
FB.TextWrapped = true
FB.Transparency = 0.2
FB.Active = true
FB.Draggable = true

SB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SB.Position = UDim2.new(-1.7, 0, 0, 0)
SB.Size = UDim2.new(0, 65, 0, 40)
SB.Font = "SourceSans"
SB.PlaceholderText = "50"
SB.Text = ""
SB.TextColor3 = Color3.fromRGB(0, 0, 0)
SB.TextScaled = true
SB.TextSize = 14
SB.TextWrapped = true

local HR = CH.HumanoidRootPart

local bv = Instance.new("BodyVelocity")
bv.Name = "VelocityHandler"
bv.Parent = HR
bv.MaxForce = Vector3.new(0,0,0)
bv.Velocity = Vector3.new(0,0,0)

local bg = Instance.new("BodyGyro")
bg.Name = "GyroHandler"
bg.Parent = HR
bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
bg.P = 1000
bg.D = 50

local Signal1
Signal1 = CHAdded:Connect(function(NewChar)
local bv = Instance.new("BodyVelocity")
bv.Name = "VelocityHandler"
bv.Parent = NewChar:WaitForChild("Humanoid").RootPart
bv.MaxForce = Vector3.new(0,0,0)
bv.Velocity = Vector3.new(0,0,0)

local bg = Instance.new("BodyGyro")
bg.Name = "GyroHandler"
bg.Parent = NewChar:WaitForChild("Humanoid").RootPart
bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
bg.P = 1000
bg.D = 50
end)

local cam = game.Workspace.CurrentCamera
local speed = 50

local Signal2
Signal2 = game:GetService("RunService").RenderStepped:Connect(function()
if CH and CH:FindFirstChildOfClass("Humanoid") and CH.Humanoid.RootPart and HR:FindFirstChild("VelocityHandler") and HR:FindFirstChild("GyroHandler") then

if On then
FB.Text = "Fly: On"
FB.BackgroundColor3 = Color3.new(0,255,0)
HR.VelocityHandler.MaxForce = Vector3.new(9e9,9e9,9e9)
HR.GyroHandler.MaxTorque = Vector3.new(9e9,9e9,9e9)
CH.Humanoid.PlatformStand = true
elseif On == false then
FB.Text = "Fly: Off"
FB.BackgroundColor3 = Color3.new(255,0,0)
HR.VelocityHandler.MaxForce = Vector3.new(0,0,0)
HR.GyroHandler.MaxTorque = Vector3.new(0,0,0)
CH.Humanoid.PlatformStand = false
return
end

local controlModule = require(LP.PlayerScripts:WaitForChild('PlayerModule'):WaitForChild("ControlModule"))

HR.GyroHandler.CFrame = camera.CoordinateFrame
local direction = controlModule:GetMoveVector()
HR.VelocityHandler.Velocity = Vector3.new()
if direction.X > 0 then
HR.VelocityHandler.Velocity = HR.VelocityHandler.Velocity + cam.CFrame.RightVector*(direction.X*speed)
end
if direction.X < 0 then
HR.VelocityHandler.Velocity = HR.VelocityHandler.Velocity + cam.CFrame.RightVector*(direction.X*speed)
end
if direction.Z > 0 then
HR.VelocityHandler.Velocity = HR.VelocityHandler.Velocity - cam.CFrame.LookVector*(direction.Z*speed)
end
if direction.Z < 0 then
HR.VelocityHandler.Velocity = HR.VelocityHandler.Velocity - cam.CFrame.LookVector*(direction.Z*speed)
end
end
end)

FB.TouchTap:Connect(function()
On = not On
end)

local Sbox
Sbox = SB:GetPropertyChangedSignal("Text"):Connect(function()
if tonumber(SB.Text) then
speed = tonumber(SB.Text)
end
end)
