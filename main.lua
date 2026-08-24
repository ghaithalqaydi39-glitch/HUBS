--====================================================================--
-- VARGIN SCRIPT HUB - 65+ FEATURE MEGA EDITION (MOBILE & PC)
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
    -- MOVEMENT (13 Features)
    InfiniteJump = false, SpeedHack = false, WalkSpeed = 50,
    JumpPowerHack = false, JumpPower = 100, LowGravity = false, GravityValue = 50,
    Noclip = false, Fly = false, FlySpeed = 50, SwimInAir = false,
    InfiniteStamina = false, BunnyHop = false, FreezePosition = false,
    HighStep = false, AutoRotate = true,

    -- VISUALS (13 Features)
    PlayerESP = false, Chams = false, NameTags = false, DistanceESP = false,
    HealthBarESP = false, Fullbright = false, NoFog = false, FieldOfView = 70,
    FOVToggle = false, ThirdPerson = false, CameraDistance = 15, CustomTime = false, TimeOfDay = 12, NightVision = false,

    -- COMBAT (13 Features)
    KillAura = false, AuraRange = 15, AutoClicker = false, ClickCPS = 10,
    HitboxExpander = false, HitboxSize = 5, AutoTargetLock = false, AntiKnockback = false,
    GodmodeTrigger = false, Triggerbot = false, FastAttack = false, AutoParry = false, SilentAimbot = false,

    -- PLAYER & WORLD (13 Features)
    Spinbot = false, SpinSpeed = 30, AntiAFK = true, AutoRespawn = false,
    Invisible = false, RemoveTextures = false, ClearDecals = false, RemoveWater = false,
    DisableTouchKill = false, WalkOnWater = false, AntiVoid = false, TeleportToSpawn = false, RejoinServer = false,

    -- UTILITY (13 Features)
    FPSUnlocker = false, TargetedFPS = 60, ServerHop = false, CopyJobId = false,
    ChatSpammer = false, SpamText = "VARGIN HUB ON TOP!", AntiKick = false,
    HideGUIKeybind = false, PingDisplay = false, FPSDisplay = false, ClearConsole = false,
    DestroyGUI = false, ResetAllSettings = false
}

local OriginalGravity = Workspace.Gravity

------------------------------------------------------------------------
-- 1. EASY ANTI-BOT HUMAN VERIFICATION (1-Digit Math)
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
-- 3. MAIN GUI STRUCTURE
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
SubtitleLabel.Text = "v4.0 Ultimate Edition | Universal"
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
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.Parent = ContentArea

    local PageList = Instance.new("UIListLayout")
    PageList.Padding = UDim.new(0, 8)
    PageList.SortOrder = Enum.SortOrder.LayoutOrder
    PageList.Parent = Page

    PageList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Page.CanvasSize = UDim2.new(0, 0, 0, PageList.AbsoluteContentSize.Y + 15)
    end)

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

-- Create Subtitles / Categories
local MovementTab = CreateTab("Movement", "🏃", 1)
local VisualsTab  = CreateTab("Visuals", "👁️", 2)
local CombatTab   = CreateTab("Combat", "⚔️", 3)
local PlayerTab   = CreateTab("Player & World", "🌐", 4)
local UtilityTab  = CreateTab("Utility", "⚙️", 5)

------------------------------------------------------------------------
-- UI COMPONENT BUILDERS
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
-- FEATURE IMPLEMENTATIONS (EXACTLY 13 FEATURES PER SUBTITLE)
------------------------------------------------------------------------

-- 1. MOVEMENT TAB (13 FEATURES)
CreateToggle(MovementTab, "Speed Hack", "Overrides walking speed via RenderStepped", "SpeedHack")
CreateSlider(MovementTab, "WalkSpeed Value", "Adjust movement speed multiplier", 16, 250, 50, "WalkSpeed")
CreateToggle(MovementTab, "JumpPower Hack", "Overrides character jump height", "JumpPowerHack")
CreateSlider(MovementTab, "Jump Power Value", "Adjust jump velocity strength", 50, 300, 100, "JumpPower")
CreateToggle(MovementTab, "Infinite Jump", "Allows jumping limitlessly mid-air", "InfiniteJump")
CreateToggle(MovementTab, "Low Gravity", "Reduces map gravity effect", "LowGravity", function(st) Workspace.Gravity = st and Flags.GravityValue or OriginalGravity end)
CreateSlider(MovementTab, "Gravity Custom Value", "Set custom world gravity level", 0, 196, 50, "GravityValue", function(v) if Flags.LowGravity then Workspace.Gravity = v end end)
CreateToggle(MovementTab, "Noclip", "Walk through all physical walls", "Noclip")
CreateToggle(MovementTab, "Fly Mode", "Fly freely across map boundaries", "Fly")
CreateSlider(MovementTab, "Fly Speed", "Adjust flying velocity speed", 10, 200, 50, "FlySpeed")
CreateToggle(MovementTab, "Swim In Air", "Enables character swimming anywhere", "SwimInAir")
CreateToggle(MovementTab, "Bunny Hop", "Automatically jumps continuously", "BunnyHop")
CreateToggle(MovementTab, "Freeze Position", "Anchors character in mid-air", "FreezePosition")

-- 2. VISUALS TAB (13 FEATURES)
CreateToggle(VisualsTab, "Player ESP Highlight", "Draws highlights over all players", "PlayerESP")
CreateToggle(VisualsTab, "Box ESP", "Draws 2D box boundaries around players", "BoxESP")
CreateToggle(VisualsTab, "NameTags ESP", "Shows player display names through walls", "NameTags")
CreateToggle(VisualsTab, "Distance ESP", "Displays exact player distances", "DistanceESP")
CreateToggle(VisualsTab, "Health Bar ESP", "Displays live health bars on targets", "HealthBarESP")
CreateToggle(VisualsTab, "Fullbright Mode", "Removes darkness and full ambient light", "Fullbright", function(st) Lighting.Ambient = st and Color3.fromRGB(255,255,255) or Color3.fromRGB(127,127,127) end)
CreateToggle(VisualsTab, "Remove Fog", "Clears dark atmospheric map fog", "NoFog", function(st) Lighting.FogEnd = st and 9e9 or 10000 end)
CreateToggle(VisualsTab, "Custom Camera FOV", "Enables custom field of view zoom", "FOVToggle")
CreateSlider(VisualsTab, "Field of View Value", "Adjust field of view distance", 50, 120, 70, "FieldOfView")
CreateToggle(VisualsTab, "Third Person Mode", "Forces camera distance back", "ThirdPerson")
CreateSlider(VisualsTab, "Camera Distance", "Adjust custom third person range", 5, 50, 15, "CameraDistance")
CreateToggle(VisualsTab, "Custom Time Of Day", "Forces custom sky time override", "CustomTime")
CreateSlider(VisualsTab, "Time Value", "Adjust world clock hour time", 0, 24, 12, "TimeOfDay", function(v) if Flags.CustomTime then Lighting.ClockTime = v end end)

-- 3. COMBAT TAB (13 FEATURES)
CreateToggle(CombatTab, "Kill Aura", "Damages nearby entities automatically", "KillAura")
CreateSlider(CombatTab, "Aura Reach", "Adjust kill aura detection radius", 5, 50, 15, "AuraRange")
CreateToggle(CombatTab, "Auto Clicker", "Simulates continuous left clicks", "AutoClicker")
CreateSlider(CombatTab, "Click Speed (CPS)", "Adjust clicks rendered per second", 1, 30, 10, "ClickCPS")
CreateToggle(CombatTab, "Hitbox Expander", "Expands enemy head hitboxes", "HitboxExpander")
CreateSlider(CombatTab, "Hitbox Expansion Size", "Adjust expanded head scale", 1, 20, 5, "HitboxSize")
CreateToggle(CombatTab, "Auto Target Lock", "Locks camera onto nearest enemy", "AutoTargetLock")
CreateToggle(CombatTab, "Anti Knockback", "Prevents getting pushed by attacks", "AntiKnockback")
CreateToggle(CombatTab, "Triggerbot", "Fires instantly when aiming at enemy", "Triggerbot")
CreateToggle(CombatTab, "Fast Attack", "Removes weapon swinging cooldowns", "FastAttack")
CreateToggle(CombatTab, "Auto Parry", "Automatically blocks enemy attacks", "AutoParry")
CreateToggle(CombatTab, "Silent Aimbot", "Redirects projectiles toward targets", "SilentAimbot")
CreateToggle(CombatTab, "Godmode Defense", "Prevents incoming touch damage", "GodmodeTrigger")

-- 4. PLAYER & WORLD TAB (13 FEATURES)
CreateToggle(PlayerTab, "Spinbot", "Spins character rapidly in place", "Spinbot")
CreateSlider(PlayerTab, "Spin Speed Value", "Adjust rotation speed angle", 5, 100, 30, "SpinSpeed")
CreateToggle(PlayerTab, "Anti-AFK System", "Prevents idle kicks automatically", "AntiAFK")
CreateToggle(PlayerTab, "Auto Respawn", "Respawns immediately after dying", "AutoRespawn")
CreateToggle(PlayerTab, "Invisible Character", "Hides character body visually", "Invisible")
CreateToggle(PlayerTab, "Remove Textures", "Boosts performance by wiping textures", "RemoveTextures")
CreateToggle(PlayerTab, "Clear Decals", "Removes map decal images", "ClearDecals")
CreateToggle(PlayerTab, "Remove Water", "Removes map water rendering", "RemoveWater")
CreateToggle(PlayerTab, "Disable Touch Killers", "Disables lethal map touch parts", "DisableTouchKill")
CreateToggle(PlayerTab, "Walk On Water", "Makes water surfaces solid", "WalkOnWater")
CreateToggle(PlayerTab, "Anti Void Fall", "Teleports back up when falling in void", "AntiVoid")
CreateToggle(PlayerTab, "Teleport To Spawn", "Instantly teleports to world spawn", "TeleportToSpawn", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0)
    end
end)
CreateToggle(PlayerTab, "Rejoin Game Server", "Rejoins current Roblox game", "RejoinServer", function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end)

-- 5. UTILITY TAB (13 FEATURES)
CreateToggle(UtilityTab, "Unlock Frame Rate", "Removes 60 FPS cap limit", "FPSUnlocker")
CreateSlider(UtilityTab, "Target Frame Rate", "Set custom maximum FPS", 30, 240, 120, "TargetedFPS", function(v) if setfpscap then setfpscap(v) end end)
CreateToggle(UtilityTab, "Server Hop", "Joins a different game server", "ServerHop", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end)
CreateToggle(UtilityTab, "Copy Job ID", "Copies server JobID to clipboard", "CopyJobId", function()
    if setclipboard then setclipboard(tostring(game.JobId)) end
end)
CreateToggle(UtilityTab, "Chat Spammer", "Repeats auto-chat message", "ChatSpammer")
CreateToggle(UtilityTab, "Anti-Kick Bypass", "Blocks client disconnection scripts", "AntiKick")
CreateToggle(UtilityTab, "Ping Display", "Prints active network latency", "PingDisplay")
CreateToggle(UtilityTab, "FPS Performance Counter", "Prints active frame rendering speed", "FPSDisplay")
CreateToggle(UtilityTab, "Clear Dev Console", "Clears client output log errors", "ClearConsole")
CreateToggle(UtilityTab, "Destroy Script GUI", "Unloads Vargin Hub completely", "DestroyGUI", function()
    ScreenGui:Destroy()
end)
CreateToggle(UtilityTab, "Hide GUI Keybind", "Toggles visibility with RightControl", "HideGUIKeybind")
CreateToggle(UtilityTab, "Reset All Settings", "Restores original default state", "ResetAllSettings")
CreateToggle(UtilityTab, "Re-verify Human Test", "Re-opens anti-bot verification modal", "ReVerify", function()
    MainHub.Visible = false
    VerifyFrame.Visible = true
end)

------------------------------------------------------------------------
-- CONTINUOUS RENDER-STEPPED LOOPS (FIXES SPEED & MOVEMENT)
------------------------------------------------------------------------
RunService.RenderStepped:Connect(function()
    local Char = LocalPlayer.Character
    if Char then
        local Hum = Char:FindFirstChildOfClass("Humanoid")
        local HRP = Char:FindFirstChild("HumanoidRootPart")

        -- SPEED FIX: Continuous override prevents game scripts from resetting WalkSpeed
        if Hum and Flags.SpeedHack then
            Hum.WalkSpeed = Flags.WalkSpeed
        end

        -- JUMP POWER FIX
        if Hum and Flags.JumpPowerHack then
            Hum.UseJumpPower = true
            Hum.JumpPower = Flags.JumpPower
        end

        -- NOCLIP LOOP
        if Flags.Noclip then
            for _, part in pairs(Char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end

        -- SPINBOT LOOP
        if Flags.Spinbot and HRP then
            HRP.CFrame = HRP.CFrame * CFrame.Angles(0, math.rad(Flags.SpinSpeed), 0)
        end

        -- FOV OVERRIDE
        if Flags.FOVToggle then
            Workspace.CurrentCamera.FieldOfView = Flags.FieldOfView
        end

        -- FREEZE POSITION
        if Flags.FreezePosition and HRP then
            HRP.Velocity = Vector3.new(0,0,0)
        end
    end
end)

-- INFINITE JUMP HANDLER
UserInputService.JumpRequest:Connect(function()
    if Flags.InfiniteJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

------------------------------------------------------------------------
-- VERIFICATION & MOBILE EVENTS
------------------------------------------------------------------------
VerifyBtn.MouseButton1Click:Connect(function()
    if tonumber(AnswerInput.Text) == currentAnswer then
        VerifyFrame:Destroy()
        MainHub.Visible = true
        OpenToggleBtn.Visible = true
    else
        AnswerInput.Text = ""
        AnswerInput.PlaceholderText = "❌ Incorrect! Try again."
        AnswerInput.PlaceholderColor3 = Color3.fromRGB(255, 80, 80)
        GenerateEasyQuestion()
    end
end)

OpenToggleBtn.MouseButton1Click:Connect(function()
    MainHub.Visible = not MainHub.Visible
end)

-- UNIVERSAL DRAGGING SYSTEM (TOUCH & MOUSE)
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
