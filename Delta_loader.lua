-- GUI
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DeltaModdedLoader"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Loading sound
local loadingSound = Instance.new("Sound")
loadingSound.SoundId = "rbxassetid://8054429595"
loadingSound.Volume = 0.5
loadingSound.Looped = true
loadingSound.Parent = screenGui
loadingSound:Play()

-- Loading screen (unchanged)
local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(1,0,1,0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(10,10,15)
loadingFrame.BackgroundTransparency = 1
loadingFrame.Parent = screenGui

local loadingText = Instance.new("TextLabel")
loadingText.Text = "Loading Delta Modded..."
loadingText.TextSize = 32
loadingText.Font = Enum.Font.SourceSansBold
loadingText.TextColor3 = Color3.fromRGB(0,255,200)
loadingText.Size = UDim2.new(0.6,0,0.1,0)
loadingText.Position = UDim2.new(0.2,0,0.45,0)
loadingText.BackgroundTransparency = 1
loadingText.TextTransparency = 1
loadingText.Parent = loadingFrame

TweenService:Create(loadingFrame, TweenInfo.new(1.2), {BackgroundTransparency = 0.1}):Play()
TweenService:Create(loadingText, TweenInfo.new(1.5), {TextTransparency = 0}):Play()

local pulse = TweenService:Create(loadingText, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {TextTransparency = 0.4})
pulse:Play()

wait(4)

pulse:Cancel()
TweenService:Create(loadingFrame, TweenInfo.new(1.2), {BackgroundTransparency = 1}):Play()
TweenService:Create(loadingText, TweenInfo.new(1.2), {TextTransparency = 1}):Play()
TweenService:Create(loadingSound, TweenInfo.new(1.2), {Volume = 0}):Play()

wait(1.2)
loadingFrame:Destroy()
loadingSound:Stop()
loadingSound:Destroy()

-- Choice frame
local choiceFrame = Instance.new("Frame")
choiceFrame.Size = UDim2.new(0,0,0,0)
choiceFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
choiceFrame.AnchorPoint = Vector2.new(0.5, 0.5)
choiceFrame.BackgroundColor3 = Color3.fromRGB(20,20,30)
choiceFrame.BackgroundTransparency = 0.15
choiceFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0,14)
uiCorner.Parent = choiceFrame

TweenService:Create(choiceFrame, TweenInfo.new(0.75, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0.50, 0, 0.52, 0)   -- compact but with good spacing
}):Play()

-- Small logo (safe size, no chance of button overlap)
local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0.26, 0, 0.32, 0)
logo.Position = UDim2.new(0.05, 0, 0.08, 0)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://132533655213092"  -- your logo
logo.ScaleType = Enum.ScaleType.Fit
logo.ResampleMode = Enum.ResamplerMode.Pixelated  -- optional sharpness
logo.Parent = choiceFrame

-- Title (positioned beside the smaller logo)
local title = Instance.new("TextLabel")
title.Text = "Delta Modded"
title.TextSize = 38
title.Font = Enum.Font.Michroma
title.TextColor3 = Color3.fromRGB(0,255,200)
title.Size = UDim2.new(0.65, 0, 0.16, 0)
title.Position = UDim2.new(0.34, 0, 0.10, 0)   -- aligned nicely next to logo
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = choiceFrame

-- Main button (lower position)
local mainBtn = Instance.new("TextButton")
mainBtn.Text = "Load Main Gui"
mainBtn.TextSize = 26
mainBtn.Font = Enum.Font.SourceSansSemibold
mainBtn.Size = UDim2.new(0.88, 0, 0.20, 0)
mainBtn.Position = UDim2.new(0.06, 0, 0.48, 0)   -- plenty of space below logo/title
mainBtn.BackgroundColor3 = Color3.fromRGB(0,180,140)
mainBtn.TextColor3 = Color3.fromRGB(255,255,255)
mainBtn.BorderSizePixel = 0
mainBtn.Parent = choiceFrame
Instance.new("UICorner", mainBtn).CornerRadius = UDim.new(0,10)

-- Utilities button (more gap between buttons)
local utilBtn = Instance.new("TextButton")
utilBtn.Text = "Load Utilities Gui (NEW / 25bullets)"
utilBtn.TextSize = 26
utilBtn.Font = Enum.Font.SourceSansSemibold
utilBtn.Size = UDim2.new(0.88, 0, 0.20, 0)
utilBtn.Position = UDim2.new(0.06, 0, 0.72, 0)
utilBtn.BackgroundColor3 = Color3.fromRGB(100,100,255)
utilBtn.TextColor3 = Color3.fromRGB(255,255,255)
utilBtn.BorderSizePixel = 0
utilBtn.Parent = choiceFrame
Instance.new("UICorner", utilBtn).CornerRadius = UDim.new(0,10)

-- Hover effect
local function hoverEffect(btn, baseColor)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.25), {
            Size = btn.Size + UDim2.new(0.04,0,0.08,0),
            BackgroundColor3 = baseColor:Lerp(Color3.new(1,1,1), 0.18)
        }):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.25), {
            Size = btn.Size - UDim2.new(0.04,0,0.08,0),
            BackgroundColor3 = baseColor
        }):Play()
    end)
end

hoverEffect(mainBtn, Color3.fromRGB(0,180,140))
hoverEffect(utilBtn, Color3.fromRGB(100,100,255))

-- Fade & load
local function fadeAndLoad(guiType)
    local fade = TweenService:Create(choiceFrame, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        BackgroundTransparency = 1,
        Size = UDim2.new(0.24,0,0.24,0)
    })
    fade:Play()

    for _, obj in choiceFrame:GetDescendants() do
        if obj:IsA("GuiObject") then
            if obj:IsA("TextLabel") or obj:IsA("TextButton") then
                TweenService:Create(obj, TweenInfo.new(1), {TextTransparency = 1}):Play()
            elseif obj:IsA("ImageLabel") then
                TweenService:Create(obj, TweenInfo.new(1), {ImageTransparency = 1}):Play()
            end
        end
    end

    fade.Completed:Wait()
    choiceFrame:Destroy()
    screenGui:Destroy()

    if guiType == "main" then
loadstring(game:HttpGet("https://raw.githubusercontent.com/GearV4isBack/25Bullets/refs/heads/main/moonveil.lua.txt"))();
        print("Main Gui loading...")
    elseif guiType == "util" then
loadstring(game:HttpGet("https://raw.githubusercontent.com/GearV4isBack/25Bullets/refs/heads/main/25Bullets_SilentSpyV2.lua"))();
        print("Utilities Gui loading...")
    end
end

mainBtn.MouseButton1Click:Connect(function() fadeAndLoad("main") end)
utilBtn.MouseButton1Click:Connect(function() fadeAndLoad("util") end)