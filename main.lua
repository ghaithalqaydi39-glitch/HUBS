--====================================================================--
-- VARGIN SCRIPT HUB - WORKING FUNCTIONAL EDITION
--====================================================================--

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Friend Request Style Notification
pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "Vargin Script Hub",
        Text = "WELCOME TO VARGIN PLS VERIFY TO USE THE HUB",
        Duration = 8,
        Icon = "rbxassetid://6023426923"
    })
end)

local Flags = {}

------------------------------------------------------------------------
-- VERIFICATION UI
------------------------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VarginScriptHub_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")

local VerifyFrame = Instance.new("Frame")
VerifyFrame.Size = UDim2.new(0, 340, 0, 210)
VerifyFrame.Position = UDim2.new(0.5, -170, 0.5, -105)
VerifyFrame.BackgroundColor3 = Color3.fromRGB(18, 15, 29)
VerifyFrame.Parent = ScreenGui

local VerifyCorner = Instance.new("UICorner")
VerifyCorner.CornerRadius = UDim.new(0, 12)
VerifyCorner.Parent = VerifyFrame

local VerifyTitle = Instance.new("TextLabel")
VerifyTitle.Size = UDim2.new(1, 0, 0, 45)
VerifyTitle.BackgroundTransparency = 1
VerifyTitle.Text = "🛡️ Quick Verification"
VerifyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyTitle.Font = Enum.Font.GothamBold
VerifyTitle.TextSize = 18
VerifyTitle.Parent = VerifyFrame

local VerifyQuestion = Instance.new("TextLabel")
VerifyQuestion.Size = UDim2.new(1, -40, 0, 30)
VerifyQuestion.Position = UDim2.new(0, 20, 0, 45)
VerifyQuestion.BackgroundTransparency = 1
VerifyQuestion.TextColor3 = Color3.fromRGB(160, 155, 180)
VerifyQuestion.Font = Enum.Font.Gotham
VerifyQuestion.TextSize = 15
VerifyQuestion.Parent = VerifyFrame

local AnswerInput = Instance.new("TextBox")
AnswerInput.Size = UDim2.new(1, -60, 0, 36)
AnswerInput.Position = UDim2.new(0, 30, 0, 90)
AnswerInput.BackgroundColor3 = Color3.fromRGB(26, 22, 42)
AnswerInput.TextColor3 = Color3.fromRGB(255, 255, 255)
AnswerInput.PlaceholderText = "Type answer..."
AnswerInput.Parent = VerifyFrame

local VerifyBtn = Instance.new("TextButton")
VerifyBtn.Size = UDim2.new(1, -60, 0, 36)
VerifyBtn.Position = UDim2.new(0, 30, 0, 140)
VerifyBtn.BackgroundColor3 = Color3.fromRGB(118, 74, 242)
VerifyBtn.Text = "Unlock Hub"
VerifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.Parent = VerifyFrame

local currentAnswer = 0
local function GenerateEasyQuestion()
    local a, b = math.random(1, 9), math.random(1, 9)
    currentAnswer = a + b
    VerifyQuestion.Text = string.format("What is %d + %d?", a, b)
end
GenerateEasyQuestion()

------------------------------------------------------------------------
-- MAIN HUB
------------------------------------------------------------------------
local MainHub = Instance.new("Frame")
MainHub.Size = UDim2.new(0, 600, 0, 380)
MainHub.Position = UDim2.new(0.5, -300, 0.5, -190)
MainHub.BackgroundColor3 = Color3.fromRGB(14, 11, 23)
MainHub.Visible = false
MainHub.Parent = ScreenGui

local HubCorner = Instance.new("UICorner")
HubCorner.CornerRadius = UDim.new(0, 12)
HubCorner.Parent = MainHub

local ContentArea = Instance.new("ScrollingFrame")
ContentArea.Size = UDim2.new(1, -20, 1, -20)
ContentArea.Position = UDim2.new(0, 10, 0, 10)
ContentArea.BackgroundTransparency = 1
ContentArea.ScrollBarThickness = 4
ContentArea.Parent = MainHub

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 8)
ListLayout.Parent = ContentArea

ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ContentArea.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 20)
end)

local function CreateToggle(title, flagName, callback)
    Flags[flagName] = false
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -10, 0, 40)
    Btn.BackgroundColor3 = Color3.fromRGB(23, 19, 37)
    Btn.Text = title .. " [OFF]"
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 13
    Btn.Parent = ContentArea

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = Btn

    Btn.MouseButton1Click:Connect(function()
        Flags[flagName] = not Flags[flagName]
        Btn.Text = title .. (Flags[flagName] and " [ON]" or " [OFF]")
        Btn.BackgroundColor3 = Flags[flagName] and Color3.fromRGB(118, 74, 242) or Color3.fromRGB(23, 19, 37)
        if callback then callback(Flags[flagName]) end
    end)
end

------------------------------------------------------------------------
-- WORKING FEATURE IMPLEMENTATIONS
------------------------------------------------------------------------

-- 1. Working Velocity Speed Hack
CreateToggle("Working Speed Hack", "SpeedHack")
RunService.Heartbeat:Connect(function(dt)
    if Flags.SpeedHack and LocalPlayer.Character then
        local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hrp and hum and hum.MoveDirection.Magnitude > 0 then
            hrp.CFrame = hrp.CFrame + (hum.MoveDirection * (45 * dt))
        end
    end
end)

-- 2. Functional CFrame Noclip
CreateToggle("Working Noclip", "Noclip")
RunService.Stepped:Connect(function()
    if Flags.Noclip and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

-- 3. Functional Infinite Jump
CreateToggle("Working Infinite Jump", "InfJump")
UserInputService.JumpRequest:Connect(function()
    if Flags.InfJump and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- 4. Functional Player ESP Highlights
local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "VarginESP"
ESPFolder.Parent = ScreenGui

local function AttachHighlight(targetPlayer)
    if targetPlayer == LocalPlayer then return end
    
    local function Apply(char)
        if not char then return end
        local old = ESPFolder:FindFirstChild(targetPlayer.Name)
        if old then old:Destroy() end

        local Highlight = Instance.new("Highlight")
        Highlight.Name = targetPlayer.Name
        Highlight.FillColor = Color3.fromRGB(150, 90, 255)
        Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        Highlight.Adornee = char
        Highlight.Parent = ESPFolder
    end

    if targetPlayer.Character then Apply(targetPlayer.Character) end
    targetPlayer.CharacterAdded:Connect(Apply)
end

CreateToggle("Working Player ESP", "ESP", function(state)
    ESPFolder:ClearAllChildren()
    if state then
        for _, p in pairs(Players:GetPlayers()) do
            AttachHighlight(p)
        end
    end
end)

Players.PlayerAdded:Connect(function(p)
    if Flags.ESP then AttachHighlight(p) end
end)

Players.PlayerRemoving:Connect(function(p)
    local old = ESPFolder:FindFirstChild(p.Name)
    if old then old:Destroy() end
end)

-- 5. Fullbright
CreateToggle("Fullbright Lighting", "Fullbright", function(state)
    if state then
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.Brightness = 2
        Lighting.GlobalShadows = false
    else
        Lighting.Ambient = Color3.fromRGB(127, 127, 127)
        Lighting.Brightness = 1
        Lighting.GlobalShadows = true
    end
end)

------------------------------------------------------------------------
-- UNLOCK
------------------------------------------------------------------------
VerifyBtn.MouseButton1Click:Connect(function()
    if tonumber(AnswerInput.Text) == currentAnswer then
        VerifyFrame:Destroy()
        MainHub.Visible = true
    else
        AnswerInput.Text = ""
        AnswerInput.PlaceholderText = "Bro get out robot 😭😭"
        GenerateEasyQuestion()
    end
end)
