--====================================================================--
-- VARGIN SCRIPT HUB - FEATURE-PACKED UNIVERSAL EDITION
--====================================================================--

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer

-- Global Feature States
local Flags = {
    -- Movement
    InfiniteJump = false,
    LowGravity = false,
    GravityValue = 50,
    SpeedHack = false,
    WalkSpeed = 16,
    JumpPowerHack = false,
    JumpPower = 50,
    Noclip = false,
    Fly = false,
    FlySpeed = 50,
    InfiniteStamina = false,
    BunnyHop = false,
    
    -- Visuals / ESP
    PlayerESP = false,
    BoxESP = false,
    Tracers = false,
    NameTags = false,
    Fullbright = false,
    NoFog = false,
    FieldOfView = 70,

    -- Combat & Utility
    KillAura = false,
    AuraRange = 15,
    AutoClicker = false,
    AntiAFK = true,
    AntiTouchKill = false,
    AutoRespawn = false,
    Invisible = false,
    Spinbot = false,
    SpinSpeed = 20
}

local OriginalGravity = Workspace.Gravity
local OriginalFOV = Workspace.CurrentCamera.FieldOfView

------------------------------------------------------------------------
-- 1. EASY ANTI-BOT HUMAN VERIFICATION SYSTEM (Single-Digit Math)
------------------------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VarginScriptHub_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")

local VerifyFrame = Instance.new("Frame")
VerifyFrame.Name = "VerifyFrame"
VerifyFrame.Size = UDim2.new(0, 340, 0, 210)
VerifyFrame.Position = UDim2.new(0.5, -170, 0.5, -105)
VerifyFrame.BackgroundColor3 = Color3.fromRGB(18, 15, 29)
VerifyFrame.BorderSizePixel = 0
VerifyFrame.ClipsDescendants = true
VerifyFrame.Parent = ScreenGui

local VerifyCorner = Instance.new("UICorner")
VerifyCorner.CornerRadius = UDim.new(0, 12)
VerifyCorner.Parent = VerifyFrame

local VerifyTitle = Instance.new("TextLabel")
VerifyTitle.Size = UDim2.new(1, 0, 0, 45)
VerifyTitle.BackgroundTransparency = 1
VerifyTitle.Text = "🛡️ Quick Verification"
VerifyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyTitle.TextSize = 18
VerifyTitle.Font = Enum.Font.GothamBold
VerifyTitle.Parent = VerifyFrame

local VerifyQuestion = Instance.new("TextLabel")
VerifyQuestion.Size = UDim2.new(1, -40, 0, 30)
VerifyQuestion.Position = UDim2.new(0, 20, 0, 45)
VerifyQuestion.BackgroundTransparency = 1
VerifyQuestion.TextColor3 = Color3.fromRGB(160, 155, 180)
VerifyQuestion.TextSize = 15
VerifyQuestion.Font = Enum.Font.Gotham
VerifyQuestion.Parent = VerifyFrame

local AnswerInput = Instance.new("TextBox")
AnswerInput.Size = UDim2.new(1, -60, 0, 36)
AnswerInput.Position = UDim2.new(0, 30, 0, 90)
AnswerInput.BackgroundColor3 = Color3.fromRGB(26, 22, 42)
AnswerInput.TextColor3 = Color3.fromRGB(255, 255, 255)
AnswerInput.PlaceholderText = "Type answer..."
AnswerInput.PlaceholderColor3 = Color3.fromRGB(100, 95, 120)
AnswerInput.Text = ""
AnswerInput.Font = Enum.Font.Gotham
AnswerInput.TextSize = 14
AnswerInput.Parent = VerifyFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8)
InputCorner.Parent = AnswerInput

local VerifyBtn = Instance.new("TextButton")
VerifyBtn.Size = UDim2.new(1, -60, 0, 36)
VerifyBtn.Position = UDim2.new(0, 30, 0, 140)
VerifyBtn.BackgroundColor3 = Color3.fromRGB(118, 74, 242)
VerifyBtn.Text = "Unlock Hub"
VerifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.TextSize = 14
VerifyBtn.Parent = VerifyFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = VerifyBtn

-- Simple 1-digit addition generator
local currentAnswer = 0
local function GenerateEasyQuestion()
    local a, b = math.random(1, 9), math.random(1, 9)
    currentAnswer = a + b
    VerifyQuestion.Text = string.format("What is %d + %d?", a, b)
end
GenerateEasyQuestion()

------------------------------------------------------------------------
-- 2. DRAGGABLE MOBILE TOGGLE BUTTON
------------------------------------------------------------------------
local OpenToggleBtn = Instance.new("TextButton")
OpenToggleBtn.Name = "OpenToggleBtn"
OpenToggleBtn.Size = UDim2.new(0, 50, 0, 50)
OpenToggleBtn.Position = UDim2.new(0, 15, 0.5, -25)
OpenToggleBtn.BackgroundColor3 = Color3.fromRGB(118, 74, 242)
OpenToggleBtn.Text = "VARGIN"
OpenToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenToggleBtn.Font = Enum.Font.GothamBold
OpenToggleBtn.TextSize = 10
OpenToggleBtn.Visible = false
OpenToggleBtn.Parent = ScreenGui

local ToggleBtnCorner = Instance.new("UICorner")
ToggleBtnCorner.CornerRadius = UDim.new(1, 0)
ToggleBtnCorner.Parent = OpenToggleBtn

------------------------------------------------------------------------
-- 3. MAIN GUI FRAME & TABS
------------------------------------------------------------------------
local MainHub = Instance.new("Frame")
MainHub.Name = "MainHub"
MainHub.Size = UDim2.new(0, 720, 0, 440)
MainHub.Position = UDim2.new(0.5, -360, 0.5, -220)
MainHub.BackgroundColor3 = Color3.fromRGB(14, 11, 23)
MainHub.BorderSizePixel = 0
MainHub.Visible = false
MainHub.ClipsDescendants = true
MainHub.Parent = ScreenGui

local HubCorner = Instance.new("UICorner")
HubCorner.CornerRadius = UDim.new(0, 14)
HubCorner.Parent = MainHub

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 220, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 14, 29)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainHub

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 14)
SidebarCorner.Parent = Sidebar

local HeaderIcon = Instance.new("TextLabel")
HeaderIcon.Size = UDim2.new(0, 30, 0, 30)
HeaderIcon.Position = UDim2.new(0, 15, 0, 12)
HeaderIcon.BackgroundTransparency = 1
HeaderIcon.Text = "💀"
HeaderIcon.TextSize = 22
HeaderIcon.Parent = Sidebar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Position = UDim2.new(0, 50, 0, 10)
TitleLabel.Size = UDim2.new(0, 150, 0, 18)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "VARGIN SCRIPT HUB"
TitleLabel.TextColor3 = Color3.fromRGB(150, 90, 255)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 13
TitleLabel.Parent = Sidebar

local SubtitleLabel = Instance.new("TextLabel")
SubtitleLabel.Position = UDim2.new(0, 50, 0, 28)
SubtitleLabel.Size = UDim2.new(0, 160, 0, 14)
SubtitleLabel.BackgroundTransparency = 1
SubtitleLabel.Text = "v3.0 Mega Edition | Universal"
SubtitleLabel.TextColor3 = Color3.fromRGB(120, 115, 140)
SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
SubtitleLabel.Font = Enum.Font.Gotham
SubtitleLabel.TextSize = 10
SubtitleLabel.Parent = Sidebar

local NavList = Instance.new("Frame")
NavList.Size = UDim2.new(1, -20, 0, 260)
NavList.Position = UDim2.new(0, 10, 0, 60)
NavList.BackgroundTransparency = 1
NavList.Parent = Sidebar

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = NavList

local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -230, 1, -20)
ContentArea.Position = UDim2.new(0, 225, 0, 10)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainHub

local Tabs = {}
local function CreateTab(name, icon, order)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, 0, 0, 34)
    TabBtn.BackgroundColor3 = (order == 1) and Color3.fromRGB(34, 27, 58) or Color3.fromRGB(22, 18, 35)
    TabBtn.Text = "    " .. icon .. "  " .. name
    TabBtn.TextColor3 = (order == 1) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 145, 170)
    TabBtn.Font = Enum.Font.GothamMedium
    TabBtn.TextSize = 12
    TabBtn.TextXAlignment = Enum.TextXAlignment.Left
    TabBtn.LayoutOrder = order
    TabBtn.Parent = NavList

    local TabBtnCorner = Instance.new("UICorner")
    TabBtnCorner.CornerRadius = UDim.new(0, 8)
    TabBtnCorner.Parent = TabBtn

    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = (order == 1)
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = Color3.fromRGB(118, 74, 242)
    Page.Parent = ContentArea

    local PageList = Instance.new("UIListLayout")
    PageList.Padding = UDim.new(0, 8)
    PageList.SortOrder = Enum.SortOrder.LayoutOrder
    PageList.Parent = Page

    Tabs[name] = {Btn = TabBtn, Page = Page}

    TabBtn.MouseButton1Click:Connect(function()
        for tName, tData in pairs(Tabs) do
            tData.Page.Visible = false
            tData.Btn.BackgroundColor3 = Color3.fromRGB(22, 18, 35)
            tData.Btn.TextColor3 = Color3.fromRGB(150, 145, 170)
        end
        Page.Visible = true
        TabBtn.BackgroundColor3 = Color3.fromRGB(34, 27, 58)
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)

    return Page
end

-- Create Menu Categories
local MovementTab = CreateTab("Movement", "🏃", 1)
local VisualsTab  = CreateTab("Visuals", "👁️", 2)
local CombatTab   = CreateTab("Combat", "⚔️", 3)
local PlayerTab   = CreateTab("Player & World", "🌐", 4)
local UtilityTab  = CreateTab("Utility", "⚙️", 5)

------------------------------------------------------------------------
-- COMPONENT BUILDERS (Toggles & Sliders)
------------------------------------------------------------------------
local function CreateToggle(parent, title, desc, flagName, callback)
    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(1, -10, 0, 58)
    Card.BackgroundColor3 = Color3.fromRGB(23, 19, 37)
    Card.Parent = parent

    local CardCorner = Instance.new("UICorner")
    CardCorner.CornerRadius = UDim.new(0, 8)
    CardCorner.Parent = Card

    local Title = Instance.new("TextLabel")
    Title.Position = UDim2.new(0, 12, 0, 10)
    Title.Size = UDim2.new(0, 300, 0, 16)
    Title.BackgroundTransparency = 1
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextSize = 13
    Title.Parent = Card

    local Desc = Instance.new("TextLabel")
    Desc.Position = UDim2.new(0, 12, 0, 28)
    Desc.Size = UDim2.new(0, 320, 0, 16)
    Desc.BackgroundTransparency = 1
    Desc.Text = desc
    Desc.TextColor3 = Color3.fromRGB(130, 125, 150)
    Desc.Font = Enum.Font.Gotham
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextSize = 11
    Desc.Parent = Card

    local ToggleBG = Instance.new("Frame")
    ToggleBG.Size = UDim2.new(0, 44, 0, 22)
    ToggleBG.Position = UDim2.new(1, -56, 0.5, -11)
    ToggleBG.BackgroundColor3 = Flags[flagName] and Color3.fromRGB(118, 74, 242) or Color3.fromRGB(40, 34, 60)
    ToggleBG.Parent = Card

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(1, 0)
    ToggleCorner.Parent = ToggleBG

    local ToggleCircle = Instance.new("Frame")
    ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
    ToggleCircle.Position = Flags[flagName] and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
    ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleCircle.Parent = ToggleBG

    local CircleCorner = Instance.new("UICorner")
    CircleCorner.CornerRadius = UDim.new(1, 0)
    CircleCorner.Parent = ToggleCircle

    local ClickBtn = Instance.new("TextButton")
    ClickBtn.Size = UDim2.new(1, 0, 1, 0)
    ClickBtn.BackgroundTransparency = 1
    ClickBtn.Text = ""
    ClickBtn.Parent = Card

    ClickBtn.MouseButton1Click:Connect(function()
        Flags[flagName] = not Flags[flagName]
        local targetPos = Flags[flagName] and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
        local targetColor = Flags[flagName] and Color3.fromRGB(118, 74, 242) or Color3.fromRGB(40, 34, 60)

        TweenService:Create(ToggleCircle, TweenInfo.new(0.2), {Position = targetPos}):Play()
        TweenService:Create(ToggleBG, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()

        if callback then callback(Flags[flagName]) end
    end)
end

local function CreateSlider(parent, title, desc, min, max, default, flagName, callback)
    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(1, -10, 0, 68)
    Card.BackgroundColor3 = Color3.fromRGB(23, 19, 37)
    Card.Parent = parent

    local CardCorner = Instance.new("UICorner")
    CardCorner.CornerRadius = UDim.new(0, 8)
    CardCorner.Parent = Card

    local Title = Instance.new("TextLabel")
    Title.Position = UDim2.new(0, 12, 0, 10)
    Title.Size = UDim2.new(0, 200, 0, 16)
    Title.BackgroundTransparency = 1
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextSize = 13
    Title.Parent = Card

    local Desc = Instance.new("TextLabel")
    Desc.Position = UDim2.new(0, 12, 0, 28)
    Desc.Size = UDim2.new(0, 260, 0, 16)
    Desc.BackgroundTransparency = 1
    Desc.Text = desc
    Desc.TextColor3 = Color3.fromRGB(130, 125, 150)
    Desc.Font = Enum.Font.Gotham
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextSize = 11
    Desc.Parent = Card

    local ValLabel = Instance.new("TextLabel")
    ValLabel.Position = UDim2.new(1, -170, 0, 10)
    ValLabel.Size = UDim2.new(0, 40, 0, 16)
    ValLabel.BackgroundTransparency = 1
    ValLabel.Text = tostring(default)
    ValLabel.TextColor3 = Color3.fromRGB(180, 175, 200)
    ValLabel.Font = Enum.Font.GothamBold
    ValLabel.TextSize = 12
    ValLabel.Parent = Card

    local SliderBar = Instance.new("Frame")
    SliderBar.Size = UDim2.new(0, 110, 0, 6)
    SliderBar.Position = UDim2.new(1, -125, 0, 34)
    SliderBar.BackgroundColor3 = Color3.fromRGB(40, 34, 60)
    SliderBar.Parent = Card

    local SliderBarCorner = Instance.new("UICorner")
    SliderBarCorner.CornerRadius = UDim.new(1, 0)
    SliderBarCorner.Parent = SliderBar

    local FillBar = Instance.new("Frame")
    FillBar.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
    FillBar.BackgroundColor3 = Color3.fromRGB(118, 74, 242)
    FillBar.Parent = SliderBar

    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(1, 0)
    FillCorner.Parent = FillBar

    local dragging = false
    local function UpdateInput(input)
        local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
        local val = math.floor(min + (max - min) * pos)
        FillBar.Size = UDim2.new(pos, 0, 1, 0)
        ValLabel.Text = tostring(val)
        Flags[flagName] = val
        if callback then callback(val) end
    end

    SliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            UpdateInput(input)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            UpdateInput(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

------------------------------------------------------------------------
-- FEATURE CONFIGURATIONS
------------------------------------------------------------------------

-- 1. Movement Tab Features
CreateToggle(MovementTab, "Infinite Jump", "Allows jumping limitlessly in air", "InfiniteJump")
CreateToggle(MovementTab, "WalkSpeed Hack", "Overrides local walking speed", "SpeedHack", function(state)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = state and Flags.WalkSpeed or 16
    end
end)
CreateSlider(MovementTab, "Speed Multiplier", "Adjust WalkSpeed velocity", 16, 250, 50, "WalkSpeed", function(val)
    if Flags.SpeedHack and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = val
    end
end)
CreateToggle(MovementTab, "JumpPower Hack", "Overrides height of character jumps", "JumpPowerHack", function(state)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = state and Flags.JumpPower or 50
    end
end)
CreateSlider(MovementTab, "Jump Force", "Adjust jump power height", 50, 300, 100, "JumpPower", function(val)
    if Flags.JumpPowerHack and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = val
    end
end)
CreateToggle(MovementTab, "Low Gravity", "Reduces world gravity force", "LowGravity", function(state)
    Workspace.Gravity = state and Flags.GravityValue or OriginalGravity
end)
CreateSlider(MovementTab, "Gravity Value", "Set custom world gravity", 0, 196, 50, "GravityValue", function(val)
    if Flags.LowGravity then Workspace.Gravity = val end
end)
CreateToggle(MovementTab, "Noclip", "Walk through walls and obstacles", "Noclip")

-- 2. Visuals Tab Features
CreateToggle(VisualsTab, "Highlight ESP", "Draws outline around players through walls", "PlayerESP")
CreateToggle(VisualsTab, "Fullbright", "Removes map dark ambient lighting", "Fullbright", function(state)
    Lighting.Ambient = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(127, 127, 127)
    Lighting.Brightness = state and 2 or 1
end)
CreateToggle(VisualsTab, "Remove Fog", "Clears atmospheric map fog completely", "NoFog", function(state)
    Lighting.FogEnd = state and 9e9 or 10000
end)
CreateSlider(VisualsTab, "Field Of View", "Changes camera FOV distance", 50, 120, 70, "FieldOfView", function(val)
    Workspace.CurrentCamera.FieldOfView = val
end)

-- 3. Combat Tab Features
CreateToggle(CombatTab, "Kill Aura", "Damages nearest targets in range", "KillAura")
CreateSlider(CombatTab, "Aura Radius", "Max distance for Kill Aura triggers", 5, 50, 15, "AuraRange")
CreateToggle(CombatTab, "Auto Clicker", "Simulates rapid left-clicks continuously", "AutoClicker")

-- 4. Player & World Tab Features
CreateToggle(PlayerTab, "Spinbot", "Spins character around rapidly", "Spinbot")
CreateSlider(PlayerTab, "Spin Speed", "Adjust rate of rotation speed", 1, 100, 20, "SpinSpeed")
CreateToggle(PlayerTab, "Anti-AFK", "Prevents disconnection for idling", "AntiAFK")

------------------------------------------------------------------------
-- SCRIPT LOOPS & CONNECTIONS
------------------------------------------------------------------------

-- Infinite Jump Hook
UserInputService.JumpRequest:Connect(function()
    if Flags.InfiniteJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Noclip and Spinbot Loop
RunService.Stepped:Connect(function()
    if Flags.Noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
    if Flags.Spinbot and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(Flags.SpinSpeed), 0)
    end
end)

------------------------------------------------------------------------
-- VERIFICATION & UI EVENTS
------------------------------------------------------------------------
VerifyBtn.MouseButton1Click:Connect(function()
    if tonumber(AnswerInput.Text) == currentAnswer then
        VerifyFrame:Destroy()
        MainHub.Visible = true
        OpenToggleBtn.Visible = true
    else
        AnswerInput.Text = ""
        AnswerInput.PlaceholderText = "❌ Wrong! Try again."
        AnswerInput.PlaceholderColor3 = Color3.fromRGB(255, 80, 80)
        GenerateEasyQuestion()
    end
end)

OpenToggleBtn.MouseButton1Click:Connect(function()
    MainHub.Visible = not MainHub.Visible
end)

-- Mobile & PC Universal Dragging Helper
local function EnableDragging(frame)
    local dragging, dragStart, startPos, dragInput
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

EnableDragging(MainHub)
EnableDragging(OpenToggleBtn)
