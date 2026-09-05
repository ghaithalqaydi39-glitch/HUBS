--====================================================================--
-- VARGIN SCRIPT HUB - PRO WINDUI EDITION (ULTRA KEY UI)
-- Author: made by Fentys • “Join discord for lifetime/monthly keys!”
-- Discord: https://discord.gg/pHuxGjqsc8
--====================================================================--

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera or Workspace:WaitForChild("Camera")
local DefaultGravity = Workspace.Gravity > 0 and Workspace.Gravity or 196.2

local DiscordLink = "https://discord.gg/pHuxGjqsc8"

-- Master & Standard Keys
local MasterAdminKeys = {
    ["FENTYS-ADMIN-MASTER-9999"] = true,
    ["LO-DEV-OVERRIDE-2026"]     = true
}

local StandardKeys = {
    ["VARGIN-FREE-KEY-2026"]     = true,
    ["COMMUNITY-ACCESS-8831"]    = true
}

local CurrentSessionKey = "Not Verified"

------------------------------------------------------------------------
-- 1. PREMIUM WINDUI-STYLED BEGIN MODAL
------------------------------------------------------------------------
local KeyScreenGui = Instance.new("ScreenGui")
KeyScreenGui.Name = "VarginHub_BeginUI"
KeyScreenGui.ResetOnSpawn = false

pcall(function()
    if gethui then
        KeyScreenGui.Parent = gethui()
    elseif CoreGui:FindFirstChild("RobloxGui") then
        KeyScreenGui.Parent = CoreGui
    else
        KeyScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end
end)

local Modal = Instance.new("Frame")
Modal.Name = "WindUI_KeyModal"
Modal.Size = UDim2.new(0, 440, 0, 320)
Modal.Position = UDim2.new(0.5, -220, 0.5, -160)
Modal.BackgroundColor3 = Color3.fromRGB(13, 10, 22)
Modal.BorderSizePixel = 0
Modal.ClipsDescendants = true
Modal.Parent = KeyScreenGui

local ModalCorner = Instance.new("UICorner")
ModalCorner.CornerRadius = UDim.new(0, 14)
ModalCorner.Parent = Modal

local ModalStroke = Instance.new("UIStroke")
ModalStroke.Color = Color3.fromRGB(139, 92, 246)
ModalStroke.Thickness = 1.6
ModalStroke.Parent = Modal

-- Topbar
local Topbar = Instance.new("Frame")
Topbar.Size = UDim2.new(1, 0, 0, 44)
Topbar.BackgroundColor3 = Color3.fromRGB(18, 14, 30)
Topbar.BorderSizePixel = 0
Topbar.Parent = Modal

local TopbarCorner = Instance.new("UICorner")
TopbarCorner.CornerRadius = UDim.new(0, 14)
TopbarCorner.Parent = Topbar

local TopTitle = Instance.new("TextLabel")
TopTitle.Position = UDim2.new(0, 16, 0, 0)
TopTitle.Size = UDim2.new(1, -32, 1, 0)
TopTitle.BackgroundTransparency = 1
TopTitle.Text = "🛡️ VARGIN HUB <font color='#a78bfa'>• License Gateway</font>"
TopTitle.RichText = true
TopTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
TopTitle.Font = Enum.Font.GothamBold
TopTitle.TextSize = 14
TopTitle.TextXAlignment = Enum.TextXAlignment.Left
TopTitle.Parent = Topbar

-- Callout Banner
local CalloutBanner = Instance.new("Frame")
CalloutBanner.Size = UDim2.new(1, -32, 0, 56)
CalloutBanner.Position = UDim2.new(0, 16, 0, 56)
CalloutBanner.BackgroundColor3 = Color3.fromRGB(22, 17, 38)
CalloutBanner.BorderSizePixel = 0
CalloutBanner.Parent = Modal

local BannerCorner = Instance.new("UICorner")
BannerCorner.CornerRadius = UDim.new(0, 8)
BannerCorner.Parent = CalloutBanner

local BannerStroke = Instance.new("UIStroke")
BannerStroke.Color = Color3.fromRGB(80, 50, 150)
BannerStroke.Thickness = 1
BannerStroke.Parent = CalloutBanner

local BannerHeader = Instance.new("TextLabel")
BannerHeader.Position = UDim2.new(0, 12, 0, 8)
BannerHeader.Size = UDim2.new(1, -24, 0, 18)
BannerHeader.BackgroundTransparency = 1
BannerHeader.Text = "🎟️ Join discord for lifetime/monthly keys!"
BannerHeader.TextColor3 = Color3.fromRGB(245, 158, 11)
BannerHeader.Font = Enum.Font.GothamBold
BannerHeader.TextSize = 13
BannerHeader.TextXAlignment = Enum.TextXAlignment.Left
BannerHeader.Parent = CalloutBanner

local BannerDesc = Instance.new("TextLabel")
BannerDesc.Position = UDim2.new(0, 12, 0, 28)
BannerDesc.Size = UDim2.new(1, -24, 0, 18)
BannerDesc.BackgroundTransparency = 1
BannerDesc.Text = "Open a ticket in the server to purchase from Fentys directly."
BannerDesc.TextColor3 = Color3.fromRGB(170, 160, 200)
BannerDesc.Font = Enum.Font.Gotham
BannerDesc.TextSize = 11
BannerDesc.TextXAlignment = Enum.TextXAlignment.Left
BannerDesc.Parent = CalloutBanner

-- Key Input
local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(1, -32, 0, 42)
KeyBox.Position = UDim2.new(0, 16, 0, 124)
KeyBox.BackgroundColor3 = Color3.fromRGB(20, 16, 34)
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.PlaceholderText = "Paste your license key here..."
KeyBox.PlaceholderColor3 = Color3.fromRGB(110, 100, 140)
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 13
KeyBox.ClearTextOnFocus = false
KeyBox.Parent = Modal

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8)
InputCorner.Parent = KeyBox

local InputStroke = Instance.new("UIStroke")
InputStroke.Color = Color3.fromRGB(60, 48, 90)
InputStroke.Thickness = 1
InputStroke.Parent = KeyBox

KeyBox.Focused:Connect(function()
    TweenService:Create(InputStroke, TweenInfo.new(0.2), { Color = Color3.fromRGB(139, 92, 246) }):Play()
end)

KeyBox.FocusLost:Connect(function()
    TweenService:Create(InputStroke, TweenInfo.new(0.2), { Color = Color3.fromRGB(60, 48, 90) }):Play()
end)

-- Action Buttons
local UnlockBtn = Instance.new("TextButton")
UnlockBtn.Size = UDim2.new(0.48, -20, 0, 40)
UnlockBtn.Position = UDim2.new(0, 16, 0, 180)
UnlockBtn.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
UnlockBtn.Text = "⚡ Unlock Hub"
UnlockBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
UnlockBtn.Font = Enum.Font.GothamBold
UnlockBtn.TextSize = 13
UnlockBtn.Parent = Modal

local UnlockCorner = Instance.new("UICorner")
UnlockCorner.CornerRadius = UDim.new(0, 8)
UnlockCorner.Parent = UnlockBtn

local DiscordBtn = Instance.new("TextButton")
DiscordBtn.Size = UDim2.new(0.52, -12, 0, 40)
DiscordBtn.Position = UDim2.new(0.48, 4, 0, 180)
DiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
DiscordBtn.Text = "📩 Open Discord Ticket"
DiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordBtn.Font = Enum.Font.GothamBold
DiscordBtn.TextSize = 12
DiscordBtn.Parent = Modal

local DiscCorner = Instance.new("UICorner")
DiscCorner.CornerRadius = UDim.new(0, 8)
DiscCorner.Parent = DiscordBtn

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -32, 0, 30)
StatusLabel.Position = UDim2.new(0, 16, 0, 235)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Awaiting license verification..."
StatusLabel.TextColor3 = Color3.fromRGB(140, 130, 170)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 11
StatusLabel.Parent = Modal

local FooterLabel = Instance.new("TextLabel")
FooterLabel.Size = UDim2.new(1, 0, 0, 20)
FooterLabel.Position = UDim2.new(0, 0, 0, 290)
FooterLabel.BackgroundTransparency = 1
FooterLabel.Text = "Vargin Hub • made by Fentys"
FooterLabel.TextColor3 = Color3.fromRGB(90, 80, 120)
FooterLabel.Font = Enum.Font.GothamMedium
FooterLabel.TextSize = 10
FooterLabel.Parent = Modal

DiscordBtn.MouseButton1Click:Connect(function()
    if setclipboard then setclipboard(DiscordLink) end
    StatusLabel.Text = "✅ Discord invite copied! Open a ticket for Lifetime/Monthly."
    StatusLabel.TextColor3 = Color3.fromRGB(120, 255, 150)
end)

------------------------------------------------------------------------
-- 2. MAIN WINDUI SCRIPT HUB
------------------------------------------------------------------------
local function LaunchHub(isAdmin)
    KeyScreenGui:Destroy()

    local WindUI
    local cdnList = {
        "https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua",
        "https://github.com/Footagesus/WindUI/raw/main/dist/main.lua",
        "https://cdn.jsdelivr.net/gh/Footagesus/WindUI@main/dist/main.lua"
    }

    for _, url in ipairs(cdnList) do
        local success, res = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if success and res then
            WindUI = res
            break
        end
    end

    if not WindUI then
        warn("[Vargin Hub Error] All CDN mirrors failed.")
        return
    end

    local State = {
        SpeedHack = false,
        WalkSpeed = 50,
        JumpPowerHack = false,
        JumpPower = 100,
        InfiniteJump = false,
        LowGravity = false,
        GravityValue = 50,
        Noclip = false,
        FreezePosition = false,
        PlayerESP = false,
        HeadDotESP = false,
        Fullbright = false,
        NoFog = false,
        AutoClicker = false,
        ClickCPS = 10,
        HitboxExpander = false,
        HitboxSize = 5,
        Spinbot = false,
        SpinSpeed = 30,
        FOVToggle = false,
        FieldOfView = 70,
        AntiAFK = false,
        SavedCFrame = nil
    }

    local function GetHumanoid()
        local char = LocalPlayer.Character
        return char and char:FindFirstChildOfClass("Humanoid")
    end

    local function GetHRP()
        local char = LocalPlayer.Character
        return char and char:FindFirstChild("HumanoidRootPart")
    end

    local function ApplySpeed()
        local hum = GetHumanoid()
        if hum then
            hum.WalkSpeed = State.SpeedHack and State.WalkSpeed or 16
        end
    end

    local function ApplyJump()
        local hum = GetHumanoid()
        if hum then
            if State.JumpPowerHack then
                hum.UseJumpPower = true
                hum.JumpPower = State.JumpPower
                hum.JumpHeight = (State.JumpPower / 100) * 7.2
            else
                hum.JumpPower = 50
                hum.JumpHeight = 7.2
            end
        end
    end

    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.5)
        ApplySpeed()
        ApplyJump()
    end)

    local Window = WindUI:CreateWindow({
        Title = "VARGIN SCRIPT HUB",
        Icon = "shield-alert",
        Author = isAdmin and "ADMIN MASTER • made by Fentys" or "made by Fentys",
        Folder = "VarginHubConfig",
        Size = UDim2.fromOffset(600, 420),
        Transparent = true,
        Theme = "Dark"
    })

    WindUI:Notify({
        Title = isAdmin and "👑 Admin Master Access" or "Vargin Hub Loaded",
        Content = isAdmin and "Welcome back, Boss! All features unlocked." or "Session active • made by Fentys",
        Duration = 4,
        Icon = "check"
    })

    -- Hub Tabs
    local KeyTab      = Window:Tab({ Title = "Key & Support", Icon = "key" })
    local MovementTab = Window:Tab({ Title = "Movement", Icon = "zap" })
    local VisualsTab  = Window:Tab({ Title = "Visuals", Icon = "eye" })
    local CombatTab   = Window:Tab({ Title = "Combat", Icon = "swords" })
    local PlayerTab   = Window:Tab({ Title = "Player", Icon = "user" })
    local WorldTab    = Window:Tab({ Title = "World", Icon = "globe" })
    local StealthTab  = Window:Tab({ Title = "Stealth", Icon = "shield" })
    local TeleportTab = Window:Tab({ Title = "Teleports", Icon = "map-pin" })
    local UtilityTab  = Window:Tab({ Title = "Utility", Icon = "settings" })

    -- Key & Support Tab
    KeyTab:Button({
        Title = "Open Ticket / Join Discord",
        Desc = "Copies discord.gg/pHuxGjqsc8 to purchase keys",
        Callback = function()
            if setclipboard then
                setclipboard(DiscordLink)
                WindUI:Notify({ Title = "Discord Copied", Content = "discord.gg/pHuxGjqsc8", Duration = 3 })
            end
        end
    })

    KeyTab:Button({
        Title = "Copy Active Session Key",
        Desc = "Copies key: " .. CurrentSessionKey,
        Callback = function()
            if setclipboard then
                setclipboard(CurrentSessionKey)
                WindUI:Notify({ Title = "Key Copied", Content = CurrentSessionKey, Duration = 3 })
            end
        end
    })

    -- Movement Tab
    MovementTab:Toggle({
        Title = "Speed Hack",
        Desc = "Force walk velocity state",
        Value = false,
        Callback = function(v)
            State.SpeedHack = v
            ApplySpeed()
        end
    })

    MovementTab:Slider({
        Title = "WalkSpeed Target",
        Desc = "Adjust target movement rate",
        Step = 1,
        Value = { Min = 16, Max = 350, Default = 50 },
        Callback = function(val)
            State.WalkSpeed = val
            if State.SpeedHack then ApplySpeed() end
        end
    })

    MovementTab:Toggle({
        Title = "JumpPower Hack",
        Desc = "Force vertical jump height",
        Value = false,
        Callback = function(v)
            State.JumpPowerHack = v
            ApplyJump()
        end
    })

    MovementTab:Slider({
        Title = "JumpPower Target",
        Desc = "Adjust vertical jump height",
        Step = 1,
        Value = { Min = 50, Max = 400, Default = 100 },
        Callback = function(val)
            State.JumpPower = val
            if State.JumpPowerHack then ApplyJump() end
        end
    })

    MovementTab:Toggle({
        Title = "Infinite Air Jump",
        Desc = "Jump continuously in the air",
        Value = false,
        Callback = function(v) State.InfiniteJump = v end
    })

    MovementTab:Toggle({
        Title = "Noclip",
        Desc = "Walk through walls and obstacles",
        Value = false,
        Callback = function(v) State.Noclip = v end
    })

    MovementTab:Toggle({
        Title = "Custom Gravity",
        Desc = "Override Workspace environment gravity",
        Value = false,
        Callback = function(v)
            State.LowGravity = v
            if not v then
                Workspace.Gravity = DefaultGravity
            else
                Workspace.Gravity = State.GravityValue
            end
        end
    })

    MovementTab:Slider({
        Title = "Gravity Level",
        Desc = "Target gravity coefficient",
        Step = 1,
        Value = { Min = 1, Max = 196, Default = 50 },
        Callback = function(val)
            State.GravityValue = val
            if State.LowGravity then
                Workspace.Gravity = val
            end
        end
    })

    MovementTab:Toggle({
        Title = "Freeze Position",
        Desc = "Lock physical velocity to zero",
        Value = false,
        Callback = function(v) State.FreezePosition = v end
    })

    -- Visuals Tab
    local ESPFolder = Instance.new("Folder")
    ESPFolder.Name = "VarginHub_ESP"
    pcall(function() ESPFolder.Parent = CoreGui end)

    local function UpdateESP()
        ESPFolder:ClearAllChildren()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                if State.PlayerESP then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "Highlight_" .. p.Name
                    highlight.Adornee = p.Character
                    highlight.FillColor = Color3.fromRGB(150, 90, 255)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    highlight.Parent = ESPFolder
                end

                if State.HeadDotESP and p.Character:FindFirstChild("Head") then
                    local bb = Instance.new("BillboardGui")
                    bb.Name = "Dot_" .. p.Name
                    bb.Adornee = p.Character.Head
                    bb.Size = UDim2.new(0, 10, 0, 10)
                    bb.AlwaysOnTop = true
                    bb.Parent = ESPFolder

                    local dot = Instance.new("Frame")
                    dot.Size = UDim2.new(1, 0, 1, 0)
                    dot.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
                    dot.BorderSizePixel = 0
                    dot.Parent = bb

                    local corner = Instance.new("UICorner")
                    corner.CornerRadius = UDim.new(1, 0)
                    corner.Parent = dot
                end
            end
        end
    end

    VisualsTab:Toggle({
        Title = "Player Highlights (ESP)",
        Desc = "Renders silhouettes through walls",
        Value = false,
        Callback = function(v)
            State.PlayerESP = v
            UpdateESP()
        end
    })

    VisualsTab:Toggle({
        Title = "Head Dot ESP",
        Desc = "Draws red tracking dot over enemy heads",
        Value = false,
        Callback = function(v)
            State.HeadDotESP = v
            UpdateESP()
        end
    })

    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function()
            task.wait(0.5)
            UpdateESP()
        end)
    end)

    Players.PlayerRemoving:Connect(function()
        task.wait(0.2)
        UpdateESP()
    end)

    VisualsTab:Toggle({
        Title = "Fullbright Mode",
        Desc = "Eliminate dark lighting and shadows",
        Value = false,
        Callback = function(v)
            State.Fullbright = v
            Lighting.Ambient = v and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(127, 127, 127)
        end
    })

    VisualsTab:Toggle({
        Title = "Disable Atmosphere Fog",
        Desc = "Extends fog rendering bounds infinitely",
        Value = false,
        Callback = function(v)
            State.NoFog = v
            Lighting.FogEnd = v and 9e9 or 10000
        end
    })

    -- Combat Tab
    CombatTab:Toggle({
        Title = "Auto Clicker",
        Desc = "Executes rapid virtual mouse clicks",
        Value = false,
        Callback = function(v) State.AutoClicker = v end
    })

    CombatTab:Slider({
        Title = "Click Speed (CPS)",
        Desc = "Clicks triggered per second",
        Step = 1,
        Value = { Min = 1, Max = 35, Default = 10 },
        Callback = function(val) State.ClickCPS = val end
    })

    CombatTab:Toggle({
        Title = "Head Hitbox Expander",
        Desc = "Scales enemy head hitboxes",
        Value = false,
        Callback = function(v)
            State.HitboxExpander = v
            if not v then
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                        p.Character.Head.Size = Vector3.new(2, 1, 1)
                        p.Character.Head.Transparency = 0
                    end
                end
            end
        end
    })

    CombatTab:Slider({
        Title = "Hitbox Multiplier",
        Desc = "Scale size for head hitboxes",
        Step = 1,
        Value = { Min = 2, Max = 25, Default = 5 },
        Callback = function(val) State.HitboxSize = val end
    })

    -- Player Tab
    PlayerTab:Toggle({
        Title = "Spinbot",
        Desc = "Spins character rapidly in place",
        Value = false,
        Callback = function(v) State.Spinbot = v end
    })

    PlayerTab:Slider({
        Title = "Spin Speed",
        Desc = "Rotation speed angle rate",
        Step = 1,
        Value = { Min = 5, Max = 120, Default = 30 },
        Callback = function(val) State.SpinSpeed = val end
    })

    PlayerTab:Toggle({
        Title = "Custom Camera FOV",
        Desc = "Overrides field of view angle",
        Value = false,
        Callback = function(v)
            State.FOVToggle = v
            if Camera then Camera.FieldOfView = v and State.FieldOfView or 70 end
        end
    })

    PlayerTab:Slider({
        Title = "FOV Angle",
        Desc = "Adjust camera view angle",
        Step = 1,
        Value = { Min = 40, Max = 125, Default = 70 },
        Callback = function(val)
            State.FieldOfView = val
            if State.FOVToggle and Camera then Camera.FieldOfView = val end
        end
    })

    PlayerTab:Button({
        Title = "Instant Force Reset",
        Desc = "Forces character Humanoid health to 0",
        Callback = function()
            local hum = GetHumanoid()
            if hum then hum.Health = 0 end
        end
    })

    -- World Tab
    WorldTab:Button({
        Title = "Set Midday (12:00)",
        Desc = "Locks lighting cycle to noon",
        Callback = function() Lighting.ClockTime = 12 end
    })

    WorldTab:Button({
        Title = "Set Midnight (00:00)",
        Desc = "Locks lighting cycle to midnight",
        Callback = function() Lighting.ClockTime = 0 end
    })

    -- Stealth Tab
    StealthTab:Toggle({
        Title = "Anti-AFK Protection",
        Desc = "Prevents 20-minute idle kicks",
        Value = false,
        Callback = function(v) State.AntiAFK = v end
    })

    LocalPlayer.Idled:Connect(function()
        if State.AntiAFK then
            local VirtualUser = game:GetService("VirtualUser")
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.zero)
            end)
        end
    end)

    -- Teleports Tab
    TeleportTab:Button({
        Title = "Save Current Coordinates",
        Desc = "Saves your active location",
        Callback = function()
            local hrp = GetHRP()
            if hrp then
                State.SavedCFrame = hrp.CFrame
                WindUI:Notify({ Title = "Saved", Content = "Current position saved!", Duration = 2 })
            end
        end
    })

    TeleportTab:Button({
        Title = "Teleport to Saved Coordinates",
        Desc = "Restores saved character position",
        Callback = function()
            local hrp = GetHRP()
            if State.SavedCFrame and hrp then
                hrp.CFrame = State.SavedCFrame
            else
                WindUI:Notify({ Title = "Error", Content = "No position saved yet.", Duration = 2 })
            end
        end
    })

    TeleportTab:Button({
        Title = "Teleport to World Spawn (0, 50, 0)",
        Desc = "Warps to coordinates 0, 50, 0",
        Callback = function()
            local hrp = GetHRP()
            if hrp then
                hrp.CFrame = CFrame.new(0, 50, 0)
            end
        end
    })

    -- Utility Tab
    UtilityTab:Button({
        Title = "Copy Place ID",
        Desc = "Copies current Game PlaceId to clipboard",
        Callback = function()
            if setclipboard then
                setclipboard(tostring(game.PlaceId))
                WindUI:Notify({ Title = "Copied", Content = "PlaceId copied.", Duration = 2 })
            end
        end
    })

    UtilityTab:Button({
        Title = "Copy Job ID",
        Desc = "Copies current Server JobId to clipboard",
        Callback = function()
            if setclipboard then
                setclipboard(tostring(game.JobId))
                WindUI:Notify({ Title = "Copied", Content = "JobId copied.", Duration = 2 })
            end
        end
    })

    UtilityTab:Button({
        Title = "Rejoin Current Server",
        Desc = "Reconnect to this server instance",
        Callback = function()
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
        end
    })

    -- Runtime Engine Loops
    RunService.Stepped:Connect(function()
        if State.LowGravity then
            Workspace.Gravity = State.GravityValue
        end

        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            local hrp = char:FindFirstChild("HumanoidRootPart")

            if hum and State.SpeedHack then
                hum.WalkSpeed = State.WalkSpeed
            end

            if hum and State.JumpPowerHack then
                hum.UseJumpPower = true
                hum.JumpPower = State.JumpPower
            end

            if State.Noclip then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end

            if State.Spinbot and hrp then
                hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(State.SpinSpeed), 0)
            end

            if State.FreezePosition and hrp then
                hrp.AssemblyLinearVelocity = Vector3.zero
            end

            if State.HitboxExpander then
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character then
                        local head = p.Character:FindFirstChild("Head")
                        if head and head:IsA("BasePart") then
                            head.Size = Vector3.new(State.HitboxSize, State.HitboxSize, State.HitboxSize)
                            head.Transparency = 0.6
                            head.CanCollide = false
                        end
                    end
                end
            end
        end
    end)

    UserInputService.JumpRequest:Connect(function()
        if State.InfiniteJump then
            local hum = GetHumanoid()
            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
    end)

    task.spawn(function()
        while true do
            if State.AutoClicker then
                local VirtualUser = game:GetService("VirtualUser")
                pcall(function()
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton1(Vector2.zero)
                end)
                task.wait(1 / math.clamp(State.ClickCPS, 1, 35))
            else
                task.wait(0.1)
            end
        end
    end)
end

------------------------------------------------------------------------
-- 3. KEY VERIFICATION EVENT
------------------------------------------------------------------------
UnlockBtn.MouseButton1Click:Connect(function()
    local enteredKey = KeyBox.Text:gsub("%s+", "")

    if MasterAdminKeys[enteredKey] then
        CurrentSessionKey = enteredKey
        StatusLabel.Text = "👑 Master Admin Key Verified! Launching WindUI..."
        StatusLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
        task.wait(0.5)
        LaunchHub(true)
    elseif StandardKeys[enteredKey] then
        CurrentSessionKey = enteredKey
        StatusLabel.Text = "✅ License Key Verified! Launching WindUI..."
        StatusLabel.TextColor3 = Color3.fromRGB(120, 255, 150)
        task.wait(0.5)
        LaunchHub(false)
    else
        StatusLabel.Text = "❌ Invalid Key! Join discord for lifetime/monthly keys!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        KeyBox.Text = ""
    end
end)
