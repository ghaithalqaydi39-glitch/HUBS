--====================================================================--
-- VARGIN SCRIPT HUB - MULTI-GAME UTILITY & MOBILE COMPATIBLE
--====================================================================--

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

-- Global Feature States
local Flags = {
    InfiniteJump = false,
    LowGravity = false,
    GravityValue = 50,
    KillAura = false,
    PlayerESP = false,
    AntiAFK = true,
    SpeedHack = false,
    WalkSpeed = 16
}

local OriginalGravity = Workspace.Gravity

------------------------------------------------------------------------
-- 1. ANTI-BOT HUMAN VERIFICATION SYSTEM (DYNAMIC QUESTIONS)
------------------------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VarginScriptHub_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")

local VerifyFrame = Instance.new("Frame")
VerifyFrame.Name = "VerifyFrame"
VerifyFrame.Size = UDim2.new(0, 360, 0, 220)
VerifyFrame.Position = UDim2.new(0.5, -180, 0.5, -110)
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
VerifyTitle.Text = "🛡️ Human Verification"
VerifyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyTitle.TextSize = 18
VerifyTitle.Font = Enum.Font.GothamBold
VerifyTitle.Parent = VerifyFrame

local VerifyQuestion = Instance.new("TextLabel")
VerifyQuestion.Size = UDim2.new(1, -40, 0, 35)
VerifyQuestion.Position = UDim2.new(0, 20, 0, 45)
VerifyQuestion.BackgroundTransparency = 1
VerifyQuestion.TextColor3 = Color3.fromRGB(160, 155, 180)
VerifyQuestion.TextSize = 14
VerifyQuestion.Font = Enum.Font.Gotham
VerifyQuestion.Parent = VerifyFrame

local AnswerInput = Instance.new("TextBox")
AnswerInput.Size = UDim2.new(1, -60, 0, 38)
AnswerInput.Position = UDim2.new(0, 30, 0, 95)
AnswerInput.BackgroundColor3 = Color3.fromRGB(26, 22, 42)
AnswerInput.TextColor3 = Color3.fromRGB(255, 255, 255)
AnswerInput.PlaceholderText = "Enter answer here..."
AnswerInput.PlaceholderColor3 = Color3.fromRGB(100, 95, 120)
AnswerInput.Text = ""
AnswerInput.Font = Enum.Font.Gotham
AnswerInput.TextSize = 14
AnswerInput.Parent = VerifyFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8)
InputCorner.Parent = AnswerInput

local VerifyBtn = Instance.new("TextButton")
VerifyBtn.Size = UDim2.new(1, -60, 0, 38)
VerifyBtn.Position = UDim2.new(0, 30, 0, 145)
VerifyBtn.BackgroundColor3 = Color3.fromRGB(118, 74, 242)
VerifyBtn.Text = "Verify & Access Hub"
VerifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.TextSize = 14
VerifyBtn.Parent = VerifyFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = VerifyBtn

-- Function to generate dynamic verification questions dynamically
local currentAnswer = 0
local function GenerateNewQuestion()
    local qType = math.random(1, 3)
    if qType == 1 then
        local a, b = math.random(10, 50), math.random(10, 50)
        currentAnswer = a + b
        VerifyQuestion.Text = string.format("What is %d + %d?", a, b)
    elseif qType == 2 then
        local a, b = math.random(20, 60), math.random(1, 19)
        currentAnswer = a - b
        VerifyQuestion.Text = string.format("What is %d - %d?", a, b)
    else
        local a, b = math.random(2, 12), math.random(2, 10)
        currentAnswer = a * b
        VerifyQuestion.Text = string.format("What is %d × %d?", a, b)
    end
end
GenerateNewQuestion()

------------------------------------------------------------------------
-- 2. DRAGGABLE MOBILE TOGGLE BUTTON (OPEN / CLOSE GUI)
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
-- 3. MAIN VARGIN SCRIPT HUB WINDOW
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

-- Left Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 220, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 14, 29)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainHub

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 14)
SidebarCorner.Parent = Sidebar

-- Logo & Title Header
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
SubtitleLabel.Text = "Universal Version | Mobile Ready"
SubtitleLabel.TextColor3 = Color3.fromRGB(120, 115, 140)
SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
SubtitleLabel.Font = Enum.Font.Gotham
SubtitleLabel.TextSize = 10
SubtitleLabel.Parent = Sidebar

-- Search Bar
local SearchBar = Instance.new("TextBox")
SearchBar.Size = UDim2.new(1, -30, 0, 32)
SearchBar.Position = UDim2.new(0, 15, 0, 52)
SearchBar.BackgroundColor3 = Color3.fromRGB(27, 22, 43)
SearchBar.PlaceholderText = "🔍 Search"
SearchBar.PlaceholderColor3 = Color3.fromRGB(110, 105, 130)
SearchBar.Text = ""
SearchBar.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBar.Font = Enum.Font.Gotham
SearchBar.TextSize = 12
SearchBar.Parent = Sidebar

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 8)
SearchCorner.Parent = SearchBar

-- Category Header
local CategoryText = Instance.new("TextLabel")
CategoryText.Position = UDim2.new(0, 15, 0, 95)
CategoryText.Size = UDim2.new(1, -30, 0, 16)
CategoryText.BackgroundTransparency = 1
CategoryText.Text = "🔥 Vargin Functions"
CategoryText.TextColor3 = Color3.fromRGB(110, 100, 135)
CategoryText.TextXAlignment = Enum.TextXAlignment.Left
CategoryText.Font = Enum.Font.GothamBold
CategoryText.TextSize = 11
CategoryText.Parent = Sidebar

-- Tab Navigation Container
local NavList = Instance.new("Frame")
NavList.Size = UDim2.new(1, -20, 0, 220)
NavList.Position = UDim2.new(0, 10, 0, 120)
NavList.BackgroundTransparency = 1
NavList.Parent = Sidebar

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 6)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = NavList

-- Profile Footer Section
local ProfileFrame = Instance.new("Frame")
ProfileFrame.Size = UDim2.new(1, -20, 0, 48)
ProfileFrame.Position = UDim2.new(0, 10, 1, -58)
ProfileFrame.BackgroundColor3 = Color3.fromRGB(24, 19, 38)
ProfileFrame.Parent = Sidebar

local ProfileCorner = Instance.new("UICorner")
ProfileCorner.CornerRadius = UDim.new(0, 10)
ProfileCorner.Parent = ProfileFrame

local AvatarImg = Instance.new("ImageLabel")
AvatarImg.Size = UDim2.new(0, 34, 0, 34)
AvatarImg.Position = UDim2.new(0, 7, 0, 7)
AvatarImg.BackgroundTransparency = 1
AvatarImg.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
AvatarImg.Parent = ProfileFrame

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0)
AvatarCorner.Parent = AvatarImg

local ProfileName = Instance.new("TextLabel")
ProfileName.Position = UDim2.new(0, 48, 0, 8)
ProfileName.Size = UDim2.new(0, 130, 0, 16)
ProfileName.BackgroundTransparency = 1
ProfileName.Text = LocalPlayer.DisplayName
ProfileName.TextColor3 = Color3.fromRGB(255, 255, 255)
ProfileName.Font = Enum.Font.GothamBold
ProfileName.TextXAlignment = Enum.TextXAlignment.Left
ProfileName.TextSize = 12
ProfileName.Parent = ProfileFrame

local ProfileUser = Instance.new("TextLabel")
ProfileUser.Position = UDim2.new(0, 48, 0, 24)
ProfileUser.Size = UDim2.new(0, 130, 0, 14)
ProfileUser.BackgroundTransparency = 1
ProfileUser.Text = "@" .. LocalPlayer.Name
ProfileUser.TextColor3 = Color3.fromRGB(120, 115, 140)
ProfileUser.Font = Enum.Font.Gotham
ProfileUser.TextXAlignment = Enum.TextXAlignment.Left
ProfileUser.TextSize = 11
ProfileUser.Parent = ProfileFrame

-- Main Content Container
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -230, 1, -20)
ContentArea.Position = UDim2.new(0, 225, 0, 10)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainHub

local Tabs = {}
local function CreateTab(name, icon, order)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, 0, 0, 36)
    TabBtn.BackgroundColor3 = (order == 1) and Color3.fromRGB(34, 27, 58) or Color3.fromRGB(22, 18, 35)
    TabBtn.Text = "    " .. icon .. "  " .. name
    TabBtn.TextColor3 = (order == 1) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 145, 170)
    TabBtn.Font = Enum.Font.GothamMedium
    TabBtn.TextSize = 13
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
    PageList.Padding = UDim.new(0, 10)
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

-- Pages
local MainPage = CreateTab("Movement", "🏃", 1)
local CombatPage = CreateTab("Combat", "⚔️", 2)
local TeleportPage = CreateTab("Teleport", "📍", 3)
local UtilsPage = CreateTab("Utils", "🛡️", 4)
local SettingsPage = CreateTab("Settings", "⚙️", 5)

------------------------------------------------------------------------
-- COMPONENT HELPERS (Toggles & Sliders)
------------------------------------------------------------------------
local function CreateToggle(parent, title, desc, flagName, callback)
    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(1, -10, 0, 65)
    Card.BackgroundColor3 = Color3.fromRGB(23, 19, 37)
    Card.Parent = parent

    local CardCorner = Instance.new("UICorner")
    CardCorner.CornerRadius = UDim.new(0, 10)
    CardCorner.Parent = Card

    local Title = Instance.new("TextLabel")
    Title.Position = UDim2.new(0, 15, 0, 12)
    Title.Size = UDim2.new(0, 300, 0, 18)
    Title.BackgroundTransparency = 1
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextSize = 14
    Title.Parent = Card

    local Desc = Instance.new("TextLabel")
    Desc.Position = UDim2.new(0, 15, 0, 34)
    Desc.Size = UDim2.new(0, 320, 0, 16)
    Desc.BackgroundTransparency = 1
    Desc.Text = desc
    Desc.TextColor3 = Color3.fromRGB(130, 125, 150)
    Desc.Font = Enum.Font.Gotham
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextSize = 11
    Desc.Parent = Card

    local ToggleBG = Instance.new("Frame")
    ToggleBG.Size = UDim2.new(0, 48, 0, 24)
    ToggleBG.Position = UDim2.new(1, -63, 0.5, -12)
    ToggleBG.BackgroundColor3 = Flags[flagName] and Color3.fromRGB(118, 74, 242) or Color3.fromRGB(40, 34, 60)
    ToggleBG.Parent = Card

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(1, 0)
    ToggleCorner.Parent = ToggleBG

    local ToggleCircle = Instance.new("Frame")
    ToggleCircle.Size = UDim2.new(0, 18, 0, 18)
    ToggleCircle.Position = Flags[flagName] and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
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
        local targetPos = Flags[flagName] and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
        local targetColor = Flags[flagName] and Color3.fromRGB(118, 74, 242) or Color3.fromRGB(40, 34, 60)

        TweenService:Create(ToggleCircle, TweenInfo.new(0.2), {Position = targetPos}):Play()
        TweenService:Create(ToggleBG, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()

        if callback then callback(Flags[flagName]) end
    end)
end

local function CreateSlider(parent, title, desc, min, max, default, flagName, callback)
    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(1, -10, 0, 75)
    Card.BackgroundColor3 = Color3.fromRGB(23, 19, 37)
    Card.Parent = parent

    local CardCorner = Instance.new("UICorner")
    CardCorner.CornerRadius = UDim.new(0, 10)
    CardCorner.Parent = Card

    local Title = Instance.new("TextLabel")
    Title.Position = UDim2.new(0, 15, 0, 12)
    Title.Size = UDim2.new(0, 200, 0, 18)
    Title.BackgroundTransparency = 1
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextSize = 14
    Title.Parent = Card

    local Desc = Instance.new("TextLabel")
    Desc.Position = UDim2.new(0, 15, 0, 34)
    Desc.Size = UDim2.new(0, 260, 0, 16)
    Desc.BackgroundTransparency = 1
    Desc.Text = desc
    Desc.TextColor3 = Color3.fromRGB(130, 125, 150)
    Desc.Font = Enum.Font.Gotham
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextSize = 11
    Desc.Parent = Card

    local ValLabel = Instance.new("TextLabel")
    ValLabel.Position = UDim2.new(1, -180, 0, 12)
    ValLabel.Size = UDim2.new(0, 40, 0, 18)
    ValLabel.BackgroundTransparency = 1
    ValLabel.Text = tostring(default)
    ValLabel.TextColor3 = Color3.fromRGB(180, 175, 200)
    ValLabel.Font = Enum.Font.GothamBold
    ValLabel.TextSize = 13
    ValLabel.Parent = Card

    local SliderBar = Instance.new("Frame")
    SliderBar.Size = UDim2.new(0, 110, 0, 6)
    SliderBar.Position = UDim2.new(1, -130, 0, 38)
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
-- FEATURE LOGIC (INFINITE JUMP & LOW GRAVITY)
------------------------------------------------------------------------

-- Infinite Jump Hook
UserInputService.JumpRequest:Connect(function()
    if Flags.InfiniteJump then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)

-- Universal Features Setup
CreateToggle(MainPage, "Infinite Jump", "Allows continuous mid-air jumping", "InfiniteJump")
CreateToggle(MainPage, "Low Gravity", "Reduces world gravity force", "LowGravity", function(state)
    Workspace.Gravity = state and Flags.GravityValue or OriginalGravity
end)
CreateSlider(MainPage, "Gravity Level", "Adjust custom gravity value", 0, 196, 50, "GravityValue", function(val)
    if Flags.LowGravity then
        Workspace.Gravity = val
    end
end)

CreateToggle(CombatPage, "Kill Aura", "Attacks targets in close proximity", "KillAura")
CreateToggle(CombatPage, "Player ESP", "Highlights player silhouettes across walls", "PlayerESP")
CreateToggle(UtilsPage, "Anti-AFK", "Prevents idle kicks automatically", "AntiAFK")

------------------------------------------------------------------------
-- VERIFICATION & UI TOGGLE EVENTS
------------------------------------------------------------------------
VerifyBtn.MouseButton1Click:Connect(function()
    if tonumber(AnswerInput.Text) == currentAnswer then
        VerifyFrame:Destroy()
        MainHub.Visible = true
        OpenToggleBtn.Visible = true
    else
        AnswerInput.Text = ""
        AnswerInput.PlaceholderText = "❌ Incorrect! Try new question."
        AnswerInput.PlaceholderColor3 = Color3.fromRGB(255, 80, 80)
        GenerateNewQuestion()
    end
end)

-- Mobile Open/Close Button Click
OpenToggleBtn.MouseButton1Click:Connect(function()
    MainHub.Visible = not MainHub.Visible
end)

------------------------------------------------------------------------
-- UNIVERSAL DRAGGABLE IMPLEMENTATION (MOBILE & PC SAFE)
------------------------------------------------------------------------
local function EnableDragging(frame)
    local dragging = false
    local dragInput, dragStart, startPos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
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

-- Make GUI and Mobile Button draggable
EnableDragging(MainHub)
EnableDragging(OpenToggleBtn)
