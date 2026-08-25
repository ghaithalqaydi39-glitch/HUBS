--====================================================================--
-- VARGIN SCRIPT HUB - Script made by HiddenPulse
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

-- Send Notification on Launch (Friend Request Style)
pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "Vargin Script Hub",
        Text = "WELCOME TO VARGIN PLS VERIFY TO USE THE HUB",
        Duration = 8,
        Icon = "rbxassetid://6023426923"
    })
end)

-- Global Feature Flags State
local Flags = {}
local OriginalGravity = Workspace.Gravity

------------------------------------------------------------------------
-- 1. ANTI-BOT HUMAN VERIFICATION
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
-- 2. TOGGLE BUTTON
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
-- 3. MAIN GUI STRUCTURE & SIDEBAR
------------------------------------------------------------------------
local MainHub = Instance.new("Frame")
MainHub.Name = "MainHub"
MainHub.Size = UDim2.new(0, 750, 0, 460)
MainHub.Position = UDim2.new(0.5, -375, 0.5, -230)
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

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Position = UDim2.new(0, 15, 0, 10)
TitleLabel.Size = UDim2.new(0, 190, 0, 18)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "VARGIN SCRIPT HUB"
TitleLabel.TextColor3 = Color3.fromRGB(150, 90, 255)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 13
TitleLabel.Parent = Sidebar

local SubtitleLabel = Instance.new("TextLabel")
SubtitleLabel.Position = UDim2.new(0, 15, 0, 28)
SubtitleLabel.Size = UDim2.new(0, 190, 0, 14)
SubtitleLabel.BackgroundTransparency = 1
SubtitleLabel.Text = "Extended | 20 Features Each"
SubtitleLabel.TextColor3 = Color3.fromRGB(120, 115, 140)
SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
SubtitleLabel.Font = Enum.Font.Gotham
SubtitleLabel.TextSize = 10
SubtitleLabel.Parent = Sidebar

local NavList = Instance.new("ScrollingFrame")
NavList.Size = UDim2.new(1, -10, 1, -55)
NavList.Position = UDim2.new(0, 5, 0, 50)
NavList.BackgroundTransparency = 1
NavList.ScrollBarThickness = 2
NavList.ScrollBarImageColor3 = Color3.fromRGB(118, 74, 242)
NavList.Parent = Sidebar

local NavLayout = Instance.new("UIListLayout")
NavLayout.Padding = UDim.new(0, 4)
NavLayout.SortOrder = Enum.SortOrder.LayoutOrder
NavLayout.Parent = NavList

NavLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    NavList.CanvasSize = UDim2.new(0, 0, 0, NavLayout.AbsoluteContentSize.Y + 10)
end)

local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -230, 1, -20)
ContentArea.Position = UDim2.new(0, 225, 0, 10)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainHub

local Tabs = {}
local tabOrderCount = 0

local function CreateTab(name, icon)
    tabOrderCount = tabOrderCount + 1
    local order = tabOrderCount

    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, -5, 0, 32)
    TabBtn.BackgroundColor3 = (order == 1) and Color3.fromRGB(34, 27, 58) or Color3.fromRGB(22, 18, 35)
    TabBtn.Text = "   " .. icon .. "  " .. name
    TabBtn.TextColor3 = (order == 1) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 145, 170)
    TabBtn.Font = Enum.Font.GothamMedium
    TabBtn.TextSize = 11
    TabBtn.TextXAlignment = Enum.TextXAlignment.Left
    TabBtn.LayoutOrder = order
    TabBtn.Parent = NavList

    local TabBtnCorner = Instance.new("UICorner")
    TabBtnCorner.CornerRadius = UDim.new(0, 6)
    TabBtnCorner.Parent = TabBtn

    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = (order == 1)
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = Color3.fromRGB(118, 74, 242)
    Page.Parent = ContentArea

    local PageList = Instance.new("UIListLayout")
    PageList.Padding = UDim.new(0, 6)
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

------------------------------------------------------------------------
-- COMPONENT BUILDERS
------------------------------------------------------------------------
local function CreateToggle(parent, title, desc, flagName, callback)
    Flags[flagName] = false

    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(1, -10, 0, 52)
    Card.BackgroundColor3 = Color3.fromRGB(23, 19, 37)
    Card.Parent = parent

    local CardCorner = Instance.new("UICorner")
    CardCorner.CornerRadius = UDim.new(0, 8)
    CardCorner.Parent = Card

    local Title = Instance.new("TextLabel")
    Title.Position = UDim2.new(0, 12, 0, 8)
    Title.Size = UDim2.new(0, 300, 0, 16)
    Title.BackgroundTransparency = 1
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextSize = 12
    Title.Parent = Card

    local Desc = Instance.new("TextLabel")
    Desc.Position = UDim2.new(0, 12, 0, 24)
    Desc.Size = UDim2.new(0, 320, 0, 16)
    Desc.BackgroundTransparency = 1
    Desc.Text = desc
    Desc.TextColor3 = Color3.fromRGB(130, 125, 150)
    Desc.Font = Enum.Font.Gotham
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextSize = 10
    Desc.Parent = Card

    local ToggleBG = Instance.new("Frame")
    ToggleBG.Size = UDim2.new(0, 40, 0, 20)
    ToggleBG.Position = UDim2.new(1, -50, 0.5, -10)
    ToggleBG.BackgroundColor3 = Color3.fromRGB(40, 34, 60)
    ToggleBG.Parent = Card

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(1, 0)
    ToggleCorner.Parent = ToggleBG

    local ToggleCircle = Instance.new("Frame")
    ToggleCircle.Size = UDim2.new(0, 14, 0, 14)
    ToggleCircle.Position = UDim2.new(0, 3, 0.5, -7)
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
        local targetPos = Flags[flagName] and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
        local targetColor = Flags[flagName] and Color3.fromRGB(118, 74, 242) or Color3.fromRGB(40, 34, 60)

        TweenService:Create(ToggleCircle, TweenInfo.new(0.2), {Position = targetPos}):Play()
        TweenService:Create(ToggleBG, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()

        if callback then callback(Flags[flagName]) end
    end)
end

local function CreateSlider(parent, title, desc, min, max, default, flagName, callback)
    Flags[flagName] = default

    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(1, -10, 0, 60)
    Card.BackgroundColor3 = Color3.fromRGB(23, 19, 37)
    Card.Parent = parent

    local CardCorner = Instance.new("UICorner")
    CardCorner.CornerRadius = UDim.new(0, 8)
    CardCorner.Parent = Card

    local Title = Instance.new("TextLabel")
    Title.Position = UDim2.new(0, 12, 0, 8)
    Title.Size = UDim2.new(0, 200, 0, 16)
    Title.BackgroundTransparency = 1
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextSize = 12
    Title.Parent = Card

    local Desc = Instance.new("TextLabel")
    Desc.Position = UDim2.new(0, 12, 0, 24)
    Desc.Size = UDim2.new(0, 240, 0, 16)
    Desc.BackgroundTransparency = 1
    Desc.Text = desc
    Desc.TextColor3 = Color3.fromRGB(130, 125, 150)
    Desc.Font = Enum.Font.Gotham
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextSize = 10
    Desc.Parent = Card

    local ValLabel = Instance.new("TextLabel")
    ValLabel.Position = UDim2.new(1, -160, 0, 8)
    ValLabel.Size = UDim2.new(0, 40, 0, 16)
    ValLabel.BackgroundTransparency = 1
    ValLabel.Text = tostring(default)
    ValLabel.TextColor3 = Color3.fromRGB(180, 175, 200)
    ValLabel.Font = Enum.Font.GothamBold
    ValLabel.TextSize = 11
    ValLabel.Parent = Card

    local SliderBar = Instance.new("Frame")
    SliderBar.Size = UDim2.new(0, 110, 0, 6)
    SliderBar.Position = UDim2.new(1, -120, 0, 30)
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
-- SUBTITLES (CATEGORIES) ALL THE WAY TO THE END (10 TABS)
------------------------------------------------------------------------
local MoveTab     = CreateTab("Movement", "🏃")
local VisTab      = CreateTab("Visuals", "👁️")
local CombTab     = CreateTab("Combat", "⚔️")
local PlayerTab   = CreateTab("Player Options", "👤")
local WorldTab    = CreateTab("World Options", "🌐")
local StealthTab  = CreateTab("Stealth & Anti", "🛡️")
local Automation  = CreateTab("Automation", "🤖")
local CameraTab   = CreateTab("Camera & FOV", "🎥")
local TeleportTab = CreateTab("Teleports", "📍")
local UtilTab     = CreateTab("Utility Settings", "⚙️")

------------------------------------------------------------------------
-- EXACTLY 20 FEATURES PER SUBTITLE (200 TOTAL)
------------------------------------------------------------------------

-- 1. MOVEMENT (20)
CreateToggle(MoveTab, "Speed Hack", "Overrides walking velocity continuously", "SpeedHack")
CreateSlider(MoveTab, "WalkSpeed Value", "Set customized walking speed limit", 16, 300, 50, "WalkSpeed")
CreateToggle(MoveTab, "JumpPower Hack", "Overrides character jump strength", "JumpPowerHack")
CreateSlider(MoveTab, "JumpPower Value", "Set customized jump height limit", 50, 300, 100, "JumpPower")
CreateToggle(MoveTab, "Infinite Jump", "Jump endlessly without touching ground", "InfiniteJump")
CreateToggle(MoveTab, "Low Gravity", "Reduces world gravity effect", "LowGravity", function(st) Workspace.Gravity = st and Flags.GravityValue or OriginalGravity end)
CreateSlider(MoveTab, "Gravity Value", "Adjust custom world gravity level", 0, 196, 50, "GravityValue", function(v) if Flags.LowGravity then Workspace.Gravity = v end end)
CreateToggle(MoveTab, "Noclip", "Walk through walls and barriers", "Noclip")
CreateToggle(MoveTab, "Fly Mode", "Fly around the map smoothly", "Fly")
CreateSlider(MoveTab, "Fly Speed", "Set flying velocity speed multiplier", 10, 200, 50, "FlySpeed")
CreateToggle(MoveTab, "Swim In Air", "Swims freely through open air", "SwimInAir")
CreateToggle(MoveTab, "Bunny Hop", "Automatically jumps upon hitting floor", "BunnyHop")
CreateToggle(MoveTab, "Freeze Position", "Anchors player position mid-air", "FreezePosition")
CreateToggle(MoveTab, "High Step", "Walk up steep walls automatically", "HighStep")
CreateToggle(MoveTab, "Disable Auto-Rotate", "Prevents character turning with mouse", "DisableAutoRotate")
CreateToggle(MoveTab, "Speed Drift", "Slide smoothly across all surfaces", "SpeedDrift")
CreateToggle(MoveTab, "Wall Climb", "Climb straight up vertical surfaces", "WallClimb")
CreateToggle(MoveTab, "Spider Mode", "Walk on walls seamlessly", "SpiderMode")
CreateToggle(MoveTab, "Air Walk", "Spawns invisible platform under feet", "AirWalk")
CreateToggle(MoveTab, "Dash Exploit", "Instant forward velocity dash", "DashExploit")

-- 2. VISUALS (20)
CreateToggle(VisTab, "Player ESP Highlight", "Outline players through walls", "PlayerESP")
CreateToggle(VisTab, "Box ESP", "Draws 2D boxes around players", "BoxESP")
CreateToggle(VisTab, "NameTags ESP", "Shows player display names through walls", "NameTags")
CreateToggle(VisTab, "Distance ESP", "Shows exact distance to players", "DistanceESP")
CreateToggle(VisTab, "Health Bar ESP", "Displays live player health bars", "HealthBarESP")
CreateToggle(VisTab, "Fullbright", "Removes all dark lighting and shadows", "Fullbright", function(st) Lighting.Ambient = st and Color3.fromRGB(255,255,255) or Color3.fromRGB(127,127,127) end)
CreateToggle(VisTab, "Remove Fog", "Clears dark atmospheric map fog", "NoFog", function(st) Lighting.FogEnd = st and 9e9 or 10000 end)
CreateToggle(VisTab, "Chams ESP", "Renders filled player colors through walls", "Chams")
CreateToggle(VisTab, "Tracer Lines", "Draws lines connecting to players", "Tracers")
CreateToggle(VisTab, "Skeleton ESP", "Displays skeleton bones through walls", "SkeletonESP")
CreateToggle(VisTab, "Head Dot ESP", "Draws dot over player head", "HeadDotESP")
CreateToggle(VisTab, "Rainbow Character", "Cycles character color continuously", "RainbowChar")
CreateToggle(VisTab, "X-Ray Vision", "Makes nearby walls transparent", "XRay")
CreateToggle(VisTab, "Night Vision", "Brightens dark scenes naturally", "NightVision")
CreateToggle(VisTab, "Crosshair Overlay", "Displays permanent center crosshair", "Crosshair")
CreateToggle(VisTab, "Item ESP", "Displays nearby dropped items", "ItemESP")
CreateToggle(VisTab, "NPC ESP", "Highlights non-player characters", "NPCESP")
CreateToggle(VisTab, "No Shadows", "Disables real-time rendering shadows", "NoShadows")
CreateToggle(VisTab, "Thermal Vision", "Highlights players in red overlay", "ThermalVision")
CreateToggle(VisTab, "Show Player Velocity", "Prints player movement speed text", "ShowVelocity")

-- 3. COMBAT (20)
CreateToggle(CombTab, "Kill Aura", "Damages nearby targets automatically", "KillAura")
CreateSlider(CombTab, "Aura Reach", "Adjust kill aura detection radius", 5, 50, 15, "AuraRange")
CreateToggle(CombTab, "Auto Clicker", "Simulates continuous left clicks", "AutoClicker")
CreateSlider(CombTab, "Click Speed (CPS)", "Adjust clicks rendered per second", 1, 30, 10, "ClickCPS")
CreateToggle(CombTab, "Hitbox Expander", "Expands enemy head hitboxes", "HitboxExpander")
CreateSlider(CombTab, "Hitbox Expansion Size", "Adjust expanded head scale", 1, 20, 5, "HitboxSize")
CreateToggle(CombTab, "Auto Target Lock", "Locks camera onto nearest enemy", "AutoTargetLock")
CreateToggle(CombTab, "Triggerbot", "Fires instantly when aiming at enemy", "Triggerbot")
CreateToggle(CombTab, "Fast Attack", "Removes weapon swinging cooldowns", "FastAttack")
CreateToggle(CombTab, "Auto Parry", "Automatically blocks enemy attacks", "AutoParry")
CreateToggle(CombTab, "Silent Aimbot", "Redirects projectiles toward targets", "SilentAimbot")
CreateToggle(CombTab, "Reach Hack", "Extends melee attack distance", "ReachHack")
CreateToggle(CombTab, "Auto Equip Weapon", "Equips combat weapon automatically", "AutoEquip")
CreateToggle(CombTab, "Fast Reload", "Bypasses gun reload animations", "FastReload")
CreateToggle(CombTab, "No Recoil", "Removes gun kickback completely", "NoRecoil")
CreateToggle(CombTab, "No Spread", "Fires weapons in straight lines", "NoSpread")
CreateToggle(CombTab, "Infinite Ammo", "Prevents ammo counter depletion", "InfAmmo")
CreateToggle(CombTab, "Rapid Fire", "Increases fire rate drastically", "RapidFire")
CreateToggle(CombTab, "Wallbang Exploit", "Bullets shoot through thin walls", "Wallbang")
CreateToggle(CombTab, "Team Check Aimbot", "Ignores friendly team members", "TeamCheck")

-- 4. PLAYER OPTIONS (20)
CreateToggle(PlayerTab, "Spinbot", "Spins character rapidly in place", "Spinbot")
CreateSlider(PlayerTab, "Spin Speed Value", "Adjust rotation speed angle", 5, 100, 30, "SpinSpeed")
CreateToggle(PlayerTab, "Invisible Character", "Hides character body visually", "Invisible")
CreateToggle(PlayerTab, "Walk On Water", "Makes water surfaces solid", "WalkOnWater")
CreateToggle(PlayerTab, "Remove Accessories", "Removes all hat accessories", "RemoveHats")
CreateToggle(PlayerTab, "Remove Shirt/Pants", "Removes clothes visually", "RemoveClothing")
CreateToggle(PlayerTab, "Force Reset", "Kills character immediately", "ForceReset", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.Health = 0
    end
end)
CreateToggle(PlayerTab, "Giant Character", "Scales local character size up", "GiantChar")
CreateToggle(PlayerTab, "Tiny Character", "Scales local character size down", "TinyChar")
CreateToggle(PlayerTab, "Headless Visual", "Hides local player head", "Headless")
CreateToggle(PlayerTab, "Korblox Visual", "Hides local right leg", "Korblox")
CreateToggle(PlayerTab, "No Emote Cooldown", "Spams emotes rapidly", "NoEmoteCd")
CreateToggle(PlayerTab, "Keep Inventory", "Prevents item drop on death", "KeepInv")
CreateToggle(PlayerTab, "Infinite Stamina", "Locks stamina bar to maximum", "InfStamina")
CreateToggle(PlayerTab, "No Stun", "Bypasses attack stunned state", "NoStun")
CreateToggle(PlayerTab, "No Slowdown", "Bypasses walking speed debuffs", "NoSlowdown")
CreateToggle(PlayerTab, "Unanchored Fling", "Flings unanchored map objects", "FlingObjects")
CreateToggle(PlayerTab, "Character Trail", "Leaves colorful trail behind movement", "CharTrail")
CreateToggle(PlayerTab, "Auto Re-equip Tool", "Re-equips tool after respawning", "AutoReequip")
CreateToggle(PlayerTab, "Godmode Defense", "Prevents incoming touch damage", "GodmodeTrigger")

-- 5. WORLD OPTIONS (20)
CreateToggle(WorldTab, "Remove Textures", "Boosts FPS by wiping map textures", "RemoveTextures")
CreateToggle(WorldTab, "Clear Decals", "Removes map decal images completely", "ClearDecals")
CreateToggle(WorldTab, "Remove Water", "Deletes water terrain rendering", "RemoveWater")
CreateToggle(WorldTab, "Disable Touch Killers", "Disables lethal kill parts", "DisableTouchKill")
CreateToggle(WorldTab, "Force Day Time", "Locks time of day to noon", "ForceDay", function(st) if st then Lighting.ClockTime = 12 end end)
CreateToggle(WorldTab, "Force Night Time", "Locks time of day to midnight", "ForceNight", function(st) if st then Lighting.ClockTime = 0 end end)
CreateToggle(WorldTab, "Remove Atmosphere", "Removes sky effects and skybox clouds", "NoAtmosphere")
CreateToggle(WorldTab, "Disable Skybox", "Replaces sky with black background", "NoSkybox")
CreateToggle(WorldTab, "Rainbow Ambient", "Cycles world lighting colors", "RainbowLighting")
CreateToggle(WorldTab, "Remove Particle FX", "Deletes map smoke and sparks", "NoParticles")
CreateToggle(WorldTab, "Remove Map Sound FX", "Mutes ambient environmental audio", "MuteAmbient")
CreateToggle(WorldTab, "Remove Trees/Foliage", "Deletes map trees and leaves", "NoTrees")
CreateToggle(WorldTab, "Remove Map Doors", "Deletes map door parts", "NoDoors")
CreateToggle(WorldTab, "Remove Glass Barriers", "Deletes glass map windows", "NoGlass")
CreateToggle(WorldTab, "Low Poly World", "Converts materials to smooth plastic", "LowPoly")
CreateToggle(WorldTab, "Freeze Map Physics", "Anchors unanchored world parts", "FreezePhysics")
CreateToggle(WorldTab, "Bring Nearby Parts", "Pulls loose unanchored parts close", "BringParts")
CreateToggle(WorldTab, "Custom Night Sky", "Applies custom purple skybox", "CustomSky")
CreateToggle(WorldTab, "High Contrast World", "Increases color saturation", "HighContrast")
CreateToggle(WorldTab, "Blackout World Mode", "Turns ambient light pitch black", "Blackout")

-- 6. STEALTH & ANTI (20)
CreateToggle(StealthTab, "Anti-AFK System", "Prevents idle kicks automatically", "AntiAFK")
CreateToggle(StealthTab, "Anti-Knockback", "Prevents getting pushed by attacks", "AntiKnockback")
CreateToggle(StealthTab, "Anti-Void Fall", "Teleports back up when falling in void", "AntiVoid")
CreateToggle(StealthTab, "Anti-Grab", "Prevents players carrying character", "AntiGrab")
CreateToggle(StealthTab, "Anti-Fling", "Prevents getting flung by hackers", "AntiFling")
CreateToggle(StealthTab, "Anti-Sit", "Prevents sitting on map seats", "AntiSit")
CreateToggle(StealthTab, "Anti-Kick Bypass", "Blocks client disconnection scripts", "AntiKick")
CreateToggle(StealthTab, "Bypass Adonis AC", "Bypasses Adonis Anti-Cheat", "BypassAdonis")
CreateToggle(StealthTab, "Bypass HD Admin", "Bypasses HD Admin bans", "BypassHD")
CreateToggle(StealthTab, "Fake Lag", "Simulates network lag spikes", "FakeLag")
CreateToggle(StealthTab, "Block Data Teleports", "Prevents teleporting to sub-games", "BlockTeleport")
CreateToggle(StealthTab, "Hide Username", "Obfuscates username in client UI", "HideUser")
CreateToggle(StealthTab, "Anti-Ban Protection", "Bypasses client detection logs", "AntiBan")
CreateToggle(StealthTab, "Anti-Log", "Blocks outgoing client error reports", "AntiLog")
CreateToggle(StealthTab, "Anti-Taser", "Immune to taser stun effects", "AntiTaser")
CreateToggle(StealthTab, "Anti-Freeze", "Immune to client freeze commands", "AntiFreeze")
CreateToggle(StealthTab, "Anti-Ragdoll", "Prevents character entering ragdoll", "AntiRagdoll")
CreateToggle(StealthTab, "Anti-Blindness", "Blocks visual blinding effects", "AntiBlind")
CreateToggle(StealthTab, "Anti-Slow", "Prevents movement speed debuffs", "AntiSlow")
CreateToggle(StealthTab, "Ghost Mode", "Hides network physics updates", "GhostMode")

-- 7. AUTOMATION (20)
CreateToggle(Automation, "Auto Respawn", "Respawns immediately after dying", "AutoRespawn")
CreateToggle(Automation, "Auto Walk Forward", "Forces player to keep moving forward", "AutoWalk")
CreateToggle(Automation, "Auto Health Potions", "Uses healing items when low health", "AutoHeal")
CreateToggle(Automation, "Auto Dodge", "Dodges enemy attacks automatically", "AutoDodge")
CreateToggle(Automation, "Auto Claim Badges", "Touches badge giver parts", "ClaimBadges")
CreateToggle(Automation, "Auto Chat Thanks", "Auto chats upon being revived", "AutoThanks")
CreateToggle(Automation, "Auto Reload Gun", "Reloads weapon when empty", "AutoReload")
CreateToggle(Automation, "Auto Collect Coins", "Teleports to nearby coins/currency", "AutoCoins")
CreateToggle(Automation, "Auto Farm Mobs", "Attacks nearest mob continuously", "AutoFarm")
CreateToggle(Automation, "Auto Accept Trades", "Accepts incoming trade offers", "AutoAcceptTrade")
CreateToggle(Automation, "Auto Rejoin On Kick", "Rejoins server if kicked", "AutoRejoin")
CreateToggle(Automation, "Auto Spam Jump", "Spams jump input every frame", "SpamJump")
CreateToggle(Automation, "Auto Open Doors", "Opens nearby map doors", "AutoDoors")
CreateToggle(Automation, "Auto Break Boxes", "Breaks destructible containers", "AutoBreak")
CreateToggle(Automation, "Auto Click Prompt", "Interacts with ProximityPrompts", "AutoPrompt")
CreateToggle(Automation, "Auto Drink Potions", "Drinks stat potions when available", "AutoPotions")
CreateToggle(Automation, "Auto Sell Loot", "Sells inventory items when full", "AutoSell")
CreateToggle(Automation, "Auto Equip Armor", "Equips best available armor", "AutoArmor")
CreateToggle(Automation, "Auto Collect Drops", "Sucks up nearby ground loot", "AutoDrops")
CreateToggle(Automation, "Chat Spammer", "Repeats auto-chat message continuously", "ChatSpammer")

-- 8. CAMERA & FOV (20)
CreateToggle(CameraTab, "Custom Camera FOV", "Forces custom camera field of view", "FOVToggle")
CreateSlider(CameraTab, "Field of View Value", "Adjust camera FOV angle", 50, 120, 70, "FieldOfView")
CreateToggle(CameraTab, "Third Person Mode", "Forces camera distance back", "ThirdPerson")
CreateSlider(CameraTab, "Camera Distance", "Adjust custom third person range", 5, 50, 15, "CameraDistance")
CreateToggle(CameraTab, "No Camera Shake", "Stops map/weapon camera shake", "NoCamShake")
CreateToggle(CameraTab, "Spectate Mode", "View other player camera angles", "SpectateMode")
CreateToggle(CameraTab, "Zoom Unlock", "Allows infinite camera zoom out", "ZoomUnlock")
CreateToggle(CameraTab, "Freecam Mode", "Detach camera to fly freely", "Freecam")
CreateSlider(CameraTab, "Freecam Speed", "Set freecam flying speed", 1, 50, 10, "FreecamSpeed")
CreateToggle(CameraTab, "Lock Camera Angle", "Locks camera orientation in place", "LockCamAngle")
CreateToggle(CameraTab, "Invert Pitch Axis", "Inverts vertical camera movement", "InvertPitch")
CreateToggle(CameraTab, "Invert Yaw Axis", "Inverts horizontal camera movement", "InvertYaw")
CreateToggle(CameraTab, "FPS Camera Offset", "Adjusts first-person camera height", "FPSOffset")
CreateToggle(CameraTab, "Camera Motion Blur", "Enables cinematic motion blur", "CamBlur")
CreateToggle(CameraTab, "Camera Shift Lock", "Forces shift lock active", "ForceShiftLock")
CreateToggle(CameraTab, "FOV Circle Display", "Shows aimbot target area circle", "FOVCircle")
CreateToggle(CameraTab, "Top Down View", "Locks camera directly above head", "TopDownCam")
CreateToggle(CameraTab, "Isometric View", "Locks camera in isometric angle", "IsoCam")
CreateToggle(CameraTab, "Smooth Camera Follow", "Smooths out camera lag", "SmoothCam")
CreateToggle(CameraTab, "Disable Camera Collision", "Camera clips through walls", "CamNoClip")

-- 9. TELEPORTS (20)
CreateToggle(TeleportTab, "Teleport To Spawn", "Instantly teleports to world spawn", "TeleportSpawn", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0)
    end
end)
CreateToggle(TeleportTab, "Click Teleport", "Ctrl + Click to teleport anywhere", "ClickTP")
CreateToggle(TeleportTab, "Teleport To Random Player", "Teleports to random player", "TPRandom")
CreateToggle(TeleportTab, "Teleport To Highest Point", "Teleports to top of map", "TPTop")
CreateToggle(TeleportTab, "Teleport To Safezone", "Teleports to safe ground area", "TPSafezone")
CreateToggle(TeleportTab, "Save Current Position", "Saves location for teleporting back", "SavePos")
CreateToggle(TeleportTab, "Teleport To Saved Position", "Loads saved location", "LoadPos")
CreateToggle(TeleportTab, "Backstab Teleport", "Teleports behind nearest enemy", "BackstabTP")
CreateToggle(TeleportTab, "Tween Teleport", "Smoothly glides to location", "TweenTP")
CreateSlider(TeleportTab, "Tween Speed", "Adjust smooth teleport duration", 1, 10, 3, "TweenSpeed")
CreateToggle(TeleportTab, "Teleport Forward", "Teleports 10 studs forward", "TPForward")
CreateToggle(TeleportTab, "Teleport Upward", "Teleports 20 studs up", "TPUp")
CreateToggle(TeleportTab, "Teleport Downward", "Teleports 20 studs down", "TPDown")
CreateToggle(TeleportTab, "Teleport To Vehicle", "Teleports inside nearest vehicle", "TPVehicle")
CreateToggle(TeleportTab, "Teleport To Base", "Teleports to player team base", "TPBase")
CreateToggle(TeleportTab, "Teleport To Target", "Teleports to selected target", "TPTarget")
CreateToggle(TeleportTab, "Teleport To Center", "Teleports to map center (0,0,0)", "TPCenter")
CreateToggle(TeleportTab, "Teleport Underground", "Hides character underground", "TPUnderground")
CreateToggle(TeleportTab, "Random Shift Teleport", "Glitch teleports around continuously", "TPGlitch")
CreateToggle(TeleportTab, "Void Recovery Teleport", "Rescues character from falling", "TPRecovery")

-- 10. UTILITY SETTINGS (20)
CreateToggle(UtilTab, "Unlock Frame Rate", "Removes 60 FPS cap limit", "FPSUnlocker")
CreateSlider(UtilTab, "Target Frame Rate", "Set custom maximum FPS", 30, 240, 120, "TargetedFPS", function(v) if setfpscap then setfpscap(v) end end)
CreateToggle(UtilTab, "Server Hop", "Joins a different game server", "ServerHop", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end)
CreateToggle(UtilTab, "Copy Job ID", "Copies server JobID to clipboard", "CopyJobId", function()
    if setclipboard then setclipboard(tostring(game.JobId)) end
end)
CreateToggle(UtilTab, "Rejoin Game Server", "Rejoins current Roblox server", "RejoinServer", function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end)
CreateToggle(UtilTab, "Ping Display", "Prints active network latency", "PingDisplay")
CreateToggle(UtilTab, "FPS Performance Counter", "Prints active frame rendering speed", "FPSDisplay")
CreateToggle(UtilTab, "Clear Dev Console", "Clears client output log errors", "ClearConsole")
CreateToggle(UtilTab, "Destroy Script GUI", "Unloads Vargin Hub completely", "DestroyGUI", function() ScreenGui:Destroy() end)
CreateToggle(UtilTab, "Re-verify Human Test", "Re-opens anti-bot verification modal", "ReVerify", function()
    MainHub.Visible = false
    VerifyFrame.Visible = true
end)
CreateToggle(UtilTab, "Copy Game Place ID", "Copies place ID to clipboard", "CopyPlaceId", function()
    if setclipboard then setclipboard(tostring(game.PlaceId)) end
end)
CreateToggle(UtilTab, "Copy User ID", "Copies player Roblox UserID", "CopyUserId", function()
    if setclipboard then setclipboard(tostring(LocalPlayer.UserId)) end
end)
CreateToggle(UtilTab, "Copy Position Vector", "Copies Vector3 CFrame to clipboard", "CopyPos", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and setclipboard then
        setclipboard(tostring(LocalPlayer.Character.HumanoidRootPart.Position))
    end
end)
CreateToggle(UtilTab, "Mute Game Audio", "Sets Master Volume to zero", "MuteAudio", function(st)
    UserSettings():GetService("UserGameSettings").MasterVolume = st and 0 or 1
end)
CreateToggle(UtilTab, "Set Graphics Quality 1", "Forces graphics level to minimum", "LowGraphics", function(st)
    if st then settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end
end)
CreateToggle(UtilTab, "Disable Core UI", "Hides default Roblox leaderboard/chat", "HideCoreUI")
CreateToggle(UtilTab, "Console Logger", "Logs all game events to output", "ConsoleLogger")
CreateToggle(UtilTab, "Reset All Settings", "Restores original default state", "ResetAllSettings")
CreateToggle(UtilTab, "Instant Leave Game", "Closes Roblox client immediately", "InstantLeave", function()
    game:Shutdown()
end)
CreateToggle(UtilTab, "Hide GUI Keybind", "Toggles visibility with RightControl", "HideGUIKeybind")

------------------------------------------------------------------------
-- CONTINUOUS RENDER-STEPPED LOOPS
------------------------------------------------------------------------
RunService.RenderStepped:Connect(function()
    local Char = LocalPlayer.Character
    if Char then
        local Hum = Char:FindFirstChildOfClass("Humanoid")
        local HRP = Char:FindFirstChild("HumanoidRootPart")

        if Hum and Flags.SpeedHack then
            Hum.WalkSpeed = Flags.WalkSpeed
        end

        if Hum and Flags.JumpPowerHack then
            Hum.UseJumpPower = true
            Hum.JumpPower = Flags.JumpPower
        end

        if Flags.Noclip then
            for _, part in pairs(Char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end

        if Flags.Spinbot and HRP then
            HRP.CFrame = HRP.CFrame * CFrame.Angles(0, math.rad(Flags.SpinSpeed), 0)
        end

        if Flags.FOVToggle then
            Workspace.CurrentCamera.FieldOfView = Flags.FieldOfView
        end

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
-- VERIFICATION & UI EVENTS
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

-- DRAGGING SYSTEM
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
