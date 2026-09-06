-- [[==================================================================]]
-- [[                      VARGIN HUB                      ]]
-- [[          Next-Gen Cyber Glassmorphism WindUI Script Hub         ]]
-- [[          Creators: Fentys & HiddenPulse                         ]]
-- [[==================================================================]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Configuration & Constants
local DISCORD_INVITE = "https://discord.gg/pHuxGjqsc8"
local PLATOBOOST_SERVICE_ID = 31205 -- Your exact Platoboost Project ID from dashboard!
local PLATOBOOST_SECRET = "your-platoboost-secret"

-- Clipboard helper across executors
local function copyToClipboard(text)
    if setclipboard then
        setclipboard(text)
        return true
    elseif toclipboard then
        toclipboard(text)
        return true
    elseif syn and syn.write_clipboard then
        syn.write_clipboard(text)
        return true
    end
    return false
end

-- Auto-copy Discord link on launch
pcall(function()
    copyToClipboard(DISCORD_INVITE)
end)

-- Load WindUI Library
local WindUISuccess, WindUI = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
end)

if not WindUISuccess or not WindUI then
    warn("[HiddenPulse] Critical: Failed to load WindUI.")
    return
end

-- Register Custom "CyberPulse" Ultra-Aesthetic Theme
WindUI:AddTheme({
    Name = "CyberPulse",

    Accent = WindUI:Gradient({
        ["0"]   = { Color = Color3.fromHex("#00f2fe"), Transparency = 0 },
        ["100"] = { Color = Color3.fromHex("#4facfe"), Transparency = 0 },
    }, { Rotation = 45 }),

    Dialog = WindUI:Gradient({
        ["0"]   = { Color = Color3.fromHex("#0a0e17"), Transparency = 0.05 },
        ["100"] = { Color = Color3.fromHex("#121824"), Transparency = 0.05 },
    }, { Rotation = 90 }),

    Outline    = Color3.fromHex("#00f2fe"),
    Text       = Color3.fromHex("#f0f6fc"),
    Placeholder = Color3.fromHex("#5865f2"),
    Background = Color3.fromHex("#07090e"),
    Button     = WindUI:Gradient({
        ["0"]   = { Color = Color3.fromHex("#0f172a"), Transparency = 0 },
        ["100"] = { Color = Color3.fromHex("#1e293b"), Transparency = 0 },
    }, { Rotation = 90 }),
    Icon       = Color3.fromHex("#00f2fe"),
    Toggle     = Color3.fromHex("#00f2fe"),
    Slider     = Color3.fromHex("#00f2fe"),
    Checkbox   = Color3.fromHex("#00f2fe"),

    PanelBackground            = Color3.fromHex("#0d1117"),
    PanelBackgroundTransparency = 0.4,
})

WindUI:SetTheme("CyberPulse")

-- Hub State
local HubState = {
    UserTier = "Verified User",
    WalkSpeed = 16,
    JumpPower = 50,
    InfJump = false,
    Noclip = false,
    Fly = false,
    FlySpeed = 50,
    ESP = false,
    Fullbright = false,
    Spinbot = false,
    SpinSpeed = 30,
    OrbitTarget = nil,
    OrbitAngle = 0,
    OrbitDistance = 8,
    OrbitSpeed = 5,
    SpamChat = false,
    SpamMessage = "HiddenPulse Hub ON TOP! discord.gg/pHuxGjqsc8",
    OriginalLighting = {
        Brightness = Lighting.Brightness,
        ClockTime = Lighting.ClockTime,
        FogEnd = Lighting.FogEnd,
        GlobalShadows = Lighting.GlobalShadows,
        Ambient = Lighting.Ambient
    }
}

-- All Authorized Working Keys for WindUI
local ALL_WORKING_KEYS = {
    -- Owner Admin Keys (Forever)
    "HP-OWNER-FOREVER-9999",
    "HP-FENTYS-ADMIN-KEY",
    "HP-HIDDENPULSE-ADMIN",

    -- 24-Hour Keys (Day Passes & Platoboost Gifts)
    "KEY_24h-key-232908", -- From your Platoboost Gifts dashboard!
    "HP-24HR-9A2F-88C1-7B04",
    "HP-24HR-3D1E-5F9A-4C82",
    "HP-24HR-7C4B-1E2D-9A5F",
    "HP-24HR-6F8A-9C3E-2B1D",
    "HP-24HR-5E7D-4A2B-8C1F",

    -- Monthly Keys (1,000 Robux Tier - 30 Days)
    "HP-MNTH-4B7E-9F1A-2C5D",
    "HP-MNTH-8A3D-6C2E-1F9B",
    "HP-MNTH-2F5C-7E4A-9D1B",
    "HP-MNTH-1D9B-3A8F-5C7E",
    "HP-MNTH-6E2A-8D4C-3F1B",

    -- Lifetime Keys (2,500 Robux Tier - Permanent)
    "HP-LIFE-9F2B-7D4A-1E8C",
    "HP-LIFE-3C8A-5E1D-7B4F",
    "HP-LIFE-8E1F-4B7A-2D9C",
    "HP-LIFE-5A7D-2C9E-8F1B",
    "HP-LIFE-1B4F-8D2A-6E9C"
}

-- Window Definition with Cyber Glassmorphism
local WindowConfig = {
    Title = "HiddenPulse",
    Author = "by Fentys & HiddenPulse",
    Folder = "HiddenPulseHub",
    Icon = "solar:bolt-bold",
    Theme = "CyberPulse",
    Size = UDim2.fromOffset(680, 500),
    MinSize = Vector2.new(580, 400),
    MaxSize = Vector2.new(900, 650),
    Resizable = true,
    AutoScale = true,
    NewElements = true,
    Acrylic = true,
    Transparent = true,
    SideBarWidth = 210,
    ToggleKey = Enum.KeyCode.G, -- Press G to Open/Close

    Background = WindUI:Gradient({
        ["0"]   = { Color = Color3.fromHex("#07090e"), Transparency = 0.15 },
        ["100"] = { Color = Color3.fromHex("#0d1527"), Transparency = 0.15 },
    }, { Rotation = 135 }),

    Topbar = {
        Height = 48,
        ButtonsType = "Mac"
    },

    OpenButton = {
        Title = "⚡ HiddenPulse (G)",
        Enabled = true,
        Draggable = true,
        Scale = 0.75,
        StrokeThickness = 2,
        CornerRadius = UDim.new(1, 0),
        Color = ColorSequence.new(
            Color3.fromHex("#00f2fe"),
            Color3.fromHex("#4facfe")
        ),
    },

    User = {
        Enabled = true,
        Anonymous = false
    },

    -- NATIVE WINDUI KEY SYSTEM
    KeySystem = {
        Title = "⚡ HiddenPulse — Key System",
        Note = "Click 'Get key' to complete Platoboost for a free 24-hour key!\nOr enter your VIP Lifetime/Monthly key.",
        URL = "https://discord.gg/pHuxGjqsc8",
        SaveKey = false,

        API = {
            {
                Title = "Get Platoboost Key (Free 24H)",
                Desc = "Click to copy Platoboost checkpoint link.",
                Type = "platoboost",
                ServiceId = PLATOBOOST_SERVICE_ID,
                Secret = PLATOBOOST_SECRET
            }
        },

        Key = ALL_WORKING_KEYS
    }
}

local Window = WindUI:CreateWindow(WindowConfig)

-- Topbar Tags & Badges
pcall(function()
    Window:Tag({
        Title = "⚡ CYBERPULSE",
        Icon = "solar:shield-check-bold",
        Color = Color3.fromHex("#00f2fe"),
        Border = true,
    })
    Window:Tag({
        Title = "[G] TOGGLE",
        Icon = "solar:keyboard-bold",
        Color = Color3.fromHex("#5865F2"),
        Border = true,
    })
end)

-- [[ ================================================================ ]]
-- [[                          TAB 1: PLAYER                           ]]
-- [[ ================================================================ ]]
local PlayerTab = Window:Tab({
    Title = "Player",
    Icon = "solar:user-bold"
})

PlayerTab:Section({ Title = "Locomotion Engine" })

PlayerTab:Slider({
    Title = "Speed Multiplier (WalkSpeed)",
    Step = 1,
    Value = { Min = 16, Max = 250, Default = 16 },
    Callback = function(val)
        HubState.WalkSpeed = val
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = val
        end
    end
})

PlayerTab:Slider({
    Title = "Jump Force (JumpPower)",
    Step = 1,
    Value = { Min = 50, Max = 350, Default = 50 },
    Callback = function(val)
        HubState.JumpPower = val
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.UseJumpPower = true
            LocalPlayer.Character.Humanoid.JumpPower = val
        end
    end
})

PlayerTab:Toggle({
    Title = "Infinite Air Jump",
    Value = false,
    Callback = function(state)
        HubState.InfJump = state
    end
})

UserInputService.JumpRequest:Connect(function()
    if HubState.InfJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

PlayerTab:Section({ Title = "Flight & Collision" })

PlayerTab:Toggle({
    Title = "Phase Through Walls (Noclip)",
    Value = false,
    Callback = function(state)
        HubState.Noclip = state
    end
})

RunService.Stepped:Connect(function()
    if HubState.Noclip and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

PlayerTab:Toggle({
    Title = "CFrame True Flight",
    Value = false,
    Callback = function(state)
        HubState.Fly = state
    end
})

PlayerTab:Slider({
    Title = "Flight Velocity",
    Step = 5,
    Value = { Min = 10, Max = 200, Default = 60 },
    Callback = function(val)
        HubState.FlySpeed = val
    end
})

RunService.RenderStepped:Connect(function(dt)
    if HubState.Fly and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        local moveDir = Vector3.new()

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + (Camera.CFrame.LookVector) end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - (Camera.CFrame.LookVector) end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - (Camera.CFrame.RightVector) end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + (Camera.CFrame.RightVector) end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end

        if moveDir.Magnitude > 0 then
            hrp.CFrame = hrp.CFrame + (moveDir.Unit * HubState.FlySpeed * dt)
            hrp.Velocity = Vector3.new(0, 0, 0)
        end
    end
end)

PlayerTab:Button({
    Title = "Instant Character Respawn",
    Icon = "solar:trash-bin-trash-bold",
    Callback = function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.Health = 0
        end
    end
})

-- [[ ================================================================ ]]
-- [[                        TAB 2: TROLL MENU                         ]]
-- [[ ================================================================ ]]
local TrollTab = Window:Tab({
    Title = "Troll Hub",
    Icon = "solar:ghost-bold"
})

TrollTab:Section({ Title = "Target Selector" })

local function GetTargetNames()
    local names = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then table.insert(names, p.Name) end
    end
    if #names == 0 then table.insert(names, "No Victims Online") end
    return names
end

local trollVictim = nil
local victimDropdown = TrollTab:Dropdown({
    Title = "Select Target Victim",
    Values = GetTargetNames(),
    Value = 1,
    Callback = function(name)
        trollVictim = Players:FindFirstChild(name)
    end
})

TrollTab:Button({
    Title = "Scan Active Players",
    Icon = "solar:refresh-bold",
    Callback = function()
        victimDropdown:SetValues(GetTargetNames())
    end
})

TrollTab:Section({ Title = "Aggressive Trolls" })

-- Fling Player
TrollTab:Button({
    Title = "💥 Orbit Fling Victim (Launch to Space)",
    Icon = "solar:fire-bold",
    Callback = function()
        if not trollVictim or not trollVictim.Character or not trollVictim.Character:FindFirstChild("HumanoidRootPart") then
            WindUI:Notify({ Title = "Error", Content = "Victim not found!", Duration = 3 })
            return
        end
        if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end

        local targetHRP = trollVictim.Character.HumanoidRootPart
        local myHRP = LocalPlayer.Character.HumanoidRootPart
        local oldCFrame = myHRP.CFrame

        WindUI:Notify({ Title = "Flinging", Content = "Obliterating " .. trollVictim.Name .. "...", Duration = 3 })

        task.spawn(function()
            local bvel = Instance.new("BodyAngularVelocity")
            bvel.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            bvel.AngularVelocity = Vector3.new(99999, 99999, 99999)
            bvel.Parent = myHRP

            local startTick = tick()
            while tick() - startTick < 2.5 and trollVictim.Character and trollVictim.Character:FindFirstChild("HumanoidRootPart") do
                myHRP.CFrame = targetHRP.CFrame
                RunService.RenderStepped:Wait()
            end

            bvel:Destroy()
            task.wait(0.1)
            myHRP.CFrame = oldCFrame
        end)
    end
})

-- Spinbot
TrollTab:Toggle({
    Title = "🌀 Hyper Spinbot (Beyblade)",
    Value = false,
    Callback = function(state)
        HubState.Spinbot = state
    end
})

TrollTab:Slider({
    Title = "Spinbot Angular Velocity",
    Step = 5,
    Value = { Min = 10, Max = 150, Default = 40 },
    Callback = function(val)
        HubState.SpinSpeed = val
    end
})

RunService.RenderStepped:Connect(function()
    if HubState.Spinbot and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(HubState.SpinSpeed), 0)
    end
end)

-- Orbit Target
TrollTab:Toggle({
    Title = "🪐 Planetary Orbit Around Victim",
    Value = false,
    Callback = function(state)
        HubState.OrbitTarget = state and trollVictim or nil
    end
})

RunService.RenderStepped:Connect(function(dt)
    if HubState.OrbitTarget and HubState.OrbitTarget.Character and HubState.OrbitTarget.Character:FindFirstChild("HumanoidRootPart") then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local targetHRP = HubState.OrbitTarget.Character.HumanoidRootPart
            HubState.OrbitAngle = HubState.OrbitAngle + (HubState.OrbitSpeed * dt)
            local offset = Vector3.new(math.cos(HubState.OrbitAngle) * HubState.OrbitDistance, 2, math.sin(HubState.OrbitAngle) * HubState.OrbitDistance)
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetHRP.Position + offset, targetHRP.Position)
        end
    end
end)

-- Piggyback
TrollTab:Button({
    Title = "👑 Piggyback / Sit On Victim's Head",
    Icon = "solar:user-hand-up-bold",
    Callback = function()
        if trollVictim and trollVictim.Character and trollVictim.Character:FindFirstChild("Head") then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = trollVictim.Character.Head.CFrame + Vector3.new(0, 2.5, 0)
                if LocalPlayer.Character:FindFirstChild("Humanoid") then
                    LocalPlayer.Character.Humanoid.Sit = true
                end
            end
        end
    end
})

-- Chat Spammer
TrollTab:Section({ Title = "Chat Broadcast Spammer" })

TrollTab:Input({
    Title = "Custom Troll Broadcast",
    Placeholder = "HiddenPulse Hub ON TOP! discord.gg/pHuxGjqsc8",
    Callback = function(val)
        if val and val ~= "" then HubState.SpamMessage = val end
    end
})

TrollTab:Toggle({
    Title = "📢 Toggle Automated Spammer",
    Value = false,
    Callback = function(state)
        HubState.SpamChat = state
        task.spawn(function()
            while HubState.SpamChat do
                pcall(function()
                    if TextChatService and TextChatService.ChatInputBarConfiguration then
                        local channel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
                        if channel then channel:SendAsync(HubState.SpamMessage) end
                    else
                        ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(HubState.SpamMessage, "All")
                    end
                end)
                task.wait(2.5)
            end
        end)
    end
})

-- [[ ================================================================ ]]
-- [[                         TAB 3: VISUALS                           ]]
-- [[ ================================================================ ]]
local VisualsTab = Window:Tab({
    Title = "Visuals",
    Icon = "solar:eye-bold"
})

local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "HiddenPulse_Chams"
pcall(function() ESPFolder.Parent = game:GetService("CoreGui") end)

local function ApplyHighlight(character, player)
    if player == LocalPlayer then return end
    if not character:FindFirstChild("HP_Chams") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "HP_Chams"
        highlight.FillColor = Color3.fromHex("#00f2fe")
        highlight.OutlineColor = Color3.fromHex("#ffffff")
        highlight.FillTransparency = 0.4
        highlight.OutlineTransparency = 0
        highlight.Parent = character
    end
end

local function RemoveHighlight(character)
    local h = character:FindFirstChild("HP_Chams")
    if h then h:Destroy() end
end

VisualsTab:Toggle({
    Title = "Neon Player Chams (Wallhack ESP)",
    Value = false,
    Callback = function(state)
        HubState.ESP = state
        if state then
            for _, p in ipairs(Players:GetPlayers()) do
                if p.Character then ApplyHighlight(p.Character, p) end
                p.CharacterAdded:Connect(function(c)
                    if HubState.ESP then
                        task.wait(0.5)
                        ApplyHighlight(c, p)
                    end
                end)
            end
        else
            for _, p in ipairs(Players:GetPlayers()) do
                if p.Character then RemoveHighlight(p.Character) end
            end
        end
    end
})

VisualsTab:Toggle({
    Title = "Luminescent Fullbright (Max Daylight)",
    Value = false,
    Callback = function(state)
        HubState.Fullbright = state
        if state then
            Lighting.Brightness = 2.5
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        else
            Lighting.Brightness = HubState.OriginalLighting.Brightness
            Lighting.ClockTime = HubState.OriginalLighting.ClockTime
            Lighting.FogEnd = HubState.OriginalLighting.FogEnd
            Lighting.GlobalShadows = HubState.OriginalLighting.GlobalShadows
            Lighting.Ambient = HubState.OriginalLighting.Ambient
        end
    end
})

VisualsTab:Slider({
    Title = "Dynamic Field of View (FOV)",
    Step = 1,
    Value = { Min = 70, Max = 120, Default = 70 },
    Callback = function(val)
        Camera.FieldOfView = val
    end
})

-- [[ ================================================================ ]]
-- [[                         TAB 4: TELEPORT                          ]]
-- [[ ================================================================ ]]
local TeleportTab = Window:Tab({
    Title = "Teleport",
    Icon = "solar:map-point-bold"
})

local teleDest = nil
local teleDropdown = TeleportTab:Dropdown({
    Title = "Select Warp Destination",
    Values = GetTargetNames(),
    Value = 1,
    Callback = function(name)
        teleDest = Players:FindFirstChild(name)
    end
})

TeleportTab:Button({
    Title = "Refresh Players List",
    Icon = "solar:refresh-bold",
    Callback = function()
        teleDropdown:SetValues(GetTargetNames())
    end
})

TeleportTab:Button({
    Title = "⚡ Instant Warp to Player",
    Icon = "solar:transfer-horizontal-bold",
    Callback = function()
        if teleDest and teleDest.Character and teleDest.Character:FindFirstChild("HumanoidRootPart") then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = teleDest.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                WindUI:Notify({ Title = "Warped", Content = "Arrived at " .. teleDest.Name, Duration = 3 })
            end
        end
    end
})

TeleportTab:Section({ Title = "Server Actions" })

TeleportTab:Button({
    Title = "Rejoin Server Instance",
    Icon = "solar:restart-bold",
    Callback = function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
})

TeleportTab:Button({
    Title = "Server Hop (Low Ping Finder)",
    Icon = "solar:plain-bold",
    Callback = function()
        pcall(function()
            local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
            for _, s in ipairs(servers.data) do
                if s.playing < s.maxPlayers and s.id ~= game.JobId then
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id, LocalPlayer)
                    break
                end
            end
        end)
    end
})

-- [[ ================================================================ ]]
-- [[                         TAB 5: SETTINGS                          ]]
-- [[ ================================================================ ]]
local SettingsTab = Window:Tab({
    Title = "Settings",
    Icon = "solar:tuning-bold"
})

SettingsTab:Section({ Title = "License Credentials" })

SettingsTab:Button({
    Title = "Status: " .. HubState.UserTier,
    Icon = "solar:user-check-bold",
    Callback = function() end
})

SettingsTab:Section({ Title = "Aesthetics & Themes" })

SettingsTab:Dropdown({
    Title = "Palette Preset",
    Values = { "CyberPulse", "Dark", "Rose", "Plant", "Red", "Terminal", "Midnight" },
    Value = 1,
    Callback = function(theme)
        WindUI:SetTheme(theme)
    end
})

SettingsTab:Button({
    Title = "Copy Official Discord",
    Icon = "solar:link-bold",
    Callback = function()
        copyToClipboard(DISCORD_INVITE)
        WindUI:Notify({ Title = "Copied", Content = "discord.gg/pHuxGjqsc8 copied!", Duration = 4 })
    end
})

SettingsTab:Button({
    Title = "Safely Terminate Hub",
    Icon = "solar:power-bold",
    Callback = function()
        if ESPFolder then ESPFolder:Destroy() end
        Window:Destroy()
    end
})

WindUI:Notify({
    Title = "HiddenPulse ⚡ CyberPulse",
    Content = "Activated! Press [G] to toggle window.",
    Icon = "solar:check-circle-bold",
    Duration = 5
})
