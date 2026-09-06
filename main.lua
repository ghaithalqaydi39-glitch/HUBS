-- [[==================================================================]]
-- [[                      VARGIN SCRIPT HUB                           ]]
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
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Configuration & Links
local DISCORD_INVITE = "https://discord.gg/pHuxGjqsc8"
local WEBSITE_URL = "https://expenditures-segments-accepts-corp.trycloudflare.com/#admin"
local KEY_FILE = "VarginHub_AuthKey.txt"

-- Owner Usernames (Instant Bypass)
local OWNER_USERNAMES = {
    ["fentys"] = true,
    ["hiddenpulse"] = true,
}

-- All Pre-Approved Authorized Keys (24H, Monthly, Lifetime, Owner)
local ALL_WORKING_KEYS = {
    -- Owner Admin Keys
    "HP-OWNER-FOREVER-9999",
    "HP-FENTYS-ADMIN-KEY",
    "HP-HIDDENPULSE-ADMIN",

    -- 24-Hour Keys
    "KEY_24h-key-232908",
    "KEY_24h-pulse-981240",
    "KEY_24h-pulse-349812",
    "KEY_24h-pulse-772109",
    "KEY_24h-pulse-518293",
    "KEY_24h-pulse-663810",
    "KEY_24h-pulse-109482",
    "KEY_24h-pulse-884920",
    "KEY_24h-pulse-294817",
    "KEY_24h-pulse-492018",
    "HP-24HR-9A2F-88C1-7B04",
    "HP-24HR-3D1E-5F9A-4C82",
    "HP-24HR-7C4B-1E2D-9A5F",
    "HP-24HR-6F8A-9C3E-2B1D",
    "HP-24HR-5E7D-4A2B-8C1F",
    "HP-24HR-B4E1-9D2C-8A7F",
    "HP-24HR-3F8C-1A4E-7D2B",
    "HP-24HR-7E2A-5D8F-9C1B",
    "HP-24HR-6C9D-2B7A-4E1F",
    "HP-24HR-1A8F-4D2B-7E9C",
    "HP-24HR-8D3B-6E1F-2A9C",
    "HP-24HR-5C1E-7A9D-3F8B",
    "HP-24HR-2F7A-4B8C-1D6E",
    "HP-24HR-9E4B-8C2A-5F1D",
    "HP-24HR-4D8F-1E7B-9A2C",

    -- Monthly Keys (30 Days)
    "HP-MNTH-4B7E-9F1A-2C5D",
    "HP-MNTH-8A3D-6C2E-1F9B",
    "HP-MNTH-2F5C-7E4A-9D1B",
    "HP-MNTH-1D9B-3A8F-5C7E",
    "HP-MNTH-6E2A-8D4C-3F1B",

    -- Lifetime Keys (Never Expire)
    "HP-LIFE-9F2B-7D4A-1E8C",
    "HP-LIFE-3C8A-5E1D-7B4F",
    "HP-LIFE-8E1F-4B7A-2D9C",
    "HP-LIFE-5A7D-2C9E-8F1B",
    "HP-LIFE-1B4F-8D2A-6E9C"
}

-- Clipboard helper
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

-- Key validation logic
local function isKeyAuthorized(key)
    if not key or key == "" then return false end
    key = string.gsub(key, "^%s*(.-)%s*$", "%1")

    if OWNER_USERNAMES[string.lower(LocalPlayer.Name)] then
        return true, "Owner Bypass"
    end

    for _, valid in ipairs(ALL_WORKING_KEYS) do
        if key == valid then
            if string.find(key, "^HP%-LIFE") then return true, "Lifetime VIP" end
            if string.find(key, "^HP%-MNTH") then return true, "Monthly Access" end
            if string.find(key, "^HP%-OWNER") or string.find(key, "^HP%-FENTYS") then return true, "Owner Master" end
            return true, "24-Hour Access"
        end
    end

    if string.find(key, "^HP%-24HR%-") or string.find(key, "^KEY_24h%-") then
        return true, "24-Hour Pass"
    end
    if string.find(key, "^HP%-LIFE%-") then
        return true, "Lifetime VIP"
    end
    if string.find(key, "^HP%-MNTH%-") then
        return true, "Monthly Pass"
    end

    return false, nil
end

-- ====================================================================
-- MAIN HUB LAUNCHER (WindUI Execution)
-- ====================================================================
local function LaunchMainHub(tierName)
    local WindUISuccess, WindUI = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
    end)

    if not WindUISuccess or not WindUI then
        warn("[Vargin Hub] Failed to load WindUI.")
        return
    end

    -- Custom "LimitDark" Aesthetic Theme (LimitHub Style)
    WindUI:AddTheme({
        Name = "LimitDark",

        Accent = Color3.fromHex("#5d62d6"),
        Dialog = Color3.fromHex("#181a2e"),
        Outline = Color3.fromHex("#2a2d4a"),
        Text = Color3.fromHex("#e6e8f4"),
        Placeholder = Color3.fromHex("#787c9e"),
        Background = Color3.fromHex("#111320"),
        Button = Color3.fromHex("#20243d"),
        Icon = Color3.fromHex("#7b80ea"),
        Toggle = Color3.fromHex("#5d62d6"),
        Slider = Color3.fromHex("#5d62d6"),
        Checkbox = Color3.fromHex("#5d62d6"),

        PanelBackground = Color3.fromHex("#16182a"),
        PanelBackgroundTransparency = 0.15,
    })

    WindUI:SetTheme("LimitDark")

    local HubState = {
        UserTier = tierName or "24-Hour Pass",
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
        SpamMessage = "Vargin Hub ON TOP! discord.gg/pHuxGjqsc8",
        OriginalLighting = {
            Brightness = Lighting.Brightness,
            ClockTime = Lighting.ClockTime,
            FogEnd = Lighting.FogEnd,
            GlobalShadows = Lighting.GlobalShadows,
            Ambient = Lighting.Ambient
        }
    }

    local Window = WindUI:CreateWindow({
        Title = "Vargin Hub",
        Author = "Universal Suite V3.5",
        Folder = "VarginHubConfig",
        Icon = "solar:box-minimalistic-bold",
        Theme = "LimitDark",
        Size = UDim2.fromOffset(590, 420),
        MinSize = Vector2.new(500, 360),
        MaxSize = Vector2.new(850, 600),
        Resizable = true,
        AutoScale = false,
        NewElements = true,
        Acrylic = true,
        Transparent = true,
        SideBarWidth = 175,
        ToggleKey = Enum.KeyCode.G,

        Topbar = {
            Height = 44,
            ButtonsType = "Mac"
        },

        OpenButton = {
            Title = "⚡ Vargin Hub [G]",
            Enabled = true,
            Draggable = true,
            Scale = 0.8,
            StrokeThickness = 2,
            CornerRadius = UDim.new(1, 0),
            Color = ColorSequence.new(
                Color3.fromHex("#5d62d6"),
                Color3.fromHex("#7b80ea")
            ),
        },

        User = {
            Enabled = true,
            Anonymous = false
        }
    })

    pcall(function()
        Window:Tag({
            Title = "⚡ VARGIN ACTIVE",
            Icon = "solar:shield-check-bold",
            Color = Color3.fromHex("#5d62d6"),
            Border = true,
        })
        Window:Tag({
            Title = "[G] TOGGLE",
            Icon = "solar:keyboard-bold",
            Color = Color3.fromHex("#5865F2"),
            Border = true,
        })
    end)

    -- TAB 1: PLAYER
    local PlayerTab = Window:Tab({ Title = "Player", Icon = "solar:user-bold" })
    PlayerTab:Section({ Title = "Locomotion Engine" })

    -- Persistent WalkSpeed & Jump Enforcement
    local function ApplyLocomotion(character)
        if not character then return end
        local hum = character:WaitForChild("Humanoid", 3)
        if hum then
            hum.WalkSpeed = HubState.WalkSpeed
            hum.UseJumpPower = true
            hum.JumpPower = HubState.JumpPower

            hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                if hum.WalkSpeed ~= HubState.WalkSpeed and HubState.WalkSpeed ~= 16 then
                    hum.WalkSpeed = HubState.WalkSpeed
                end
            end)

            hum:GetPropertyChangedSignal("JumpPower"):Connect(function()
                if hum.JumpPower ~= HubState.JumpPower and HubState.JumpPower ~= 50 then
                    hum.UseJumpPower = true
                    hum.JumpPower = HubState.JumpPower
                end
            end)
        end
    end

    if LocalPlayer.Character then
        ApplyLocomotion(LocalPlayer.Character)
    end
    LocalPlayer.CharacterAdded:Connect(ApplyLocomotion)

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
        Callback = function(state) HubState.InfJump = state end
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
        Callback = function(state) HubState.Noclip = state end
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
        Callback = function(state) HubState.Fly = state end
    })

    PlayerTab:Slider({
        Title = "Flight Velocity",
        Step = 5,
        Value = { Min = 10, Max = 200, Default = 60 },
        Callback = function(val) HubState.FlySpeed = val end
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

    -- TAB 2: TROLL HUB
    local TrollTab = Window:Tab({ Title = "Troll Hub", Icon = "solar:ghost-bold" })
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
        Callback = function(name) trollVictim = Players:FindFirstChild(name) end
    })

    TrollTab:Button({
        Title = "Scan Active Players",
        Icon = "solar:refresh-bold",
        Callback = function() victimDropdown:SetValues(GetTargetNames()) end
    })

    TrollTab:Section({ Title = "Aggressive Trolls" })

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

    TrollTab:Toggle({
        Title = "🌀 Hyper Spinbot",
        Value = false,
        Callback = function(state) HubState.Spinbot = state end
    })

    RunService.RenderStepped:Connect(function()
        if HubState.Spinbot and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(HubState.SpinSpeed), 0)
        end
    end)

    -- TAB 3: VISUALS
    local VisualsTab = Window:Tab({ Title = "Visuals", Icon = "solar:eye-bold" })
    local ESPFolder = Instance.new("Folder")
    ESPFolder.Name = "Vargin_Chams"
    pcall(function() ESPFolder.Parent = CoreGui end)

    local function ApplyHighlight(character, player)
        if player == LocalPlayer then return end
        if not character:FindFirstChild("Vargin_Chams") then
            local highlight = Instance.new("Highlight")
            highlight.Name = "Vargin_Chams"
            highlight.FillColor = Color3.fromHex("#5d62d6")
            highlight.OutlineColor = Color3.fromHex("#ffffff")
            highlight.FillTransparency = 0.35
            highlight.OutlineTransparency = 0
            highlight.Parent = character
        end
    end

    VisualsTab:Toggle({
        Title = "Neon Player Chams (Wallhack ESP)",
        Value = false,
        Callback = function(state)
            HubState.ESP = state
            if state then
                for _, p in ipairs(Players:GetPlayers()) do
                    if p.Character then ApplyHighlight(p.Character, p) end
                end
            else
                for _, p in ipairs(Players:GetPlayers()) do
                    if p.Character and p.Character:FindFirstChild("Vargin_Chams") then
                        p.Character.Vargin_Chams:Destroy()
                    end
                end
            end
        end
    })

    VisualsTab:Toggle({
        Title = "Luminescent Fullbright (Max Light)",
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

    -- TAB 4: SETTINGS
    local SettingsTab = Window:Tab({ Title = "Settings", Icon = "solar:tuning-bold" })
    SettingsTab:Section({ Title = "License & Credentials" })
    SettingsTab:Button({
        Title = "License Tier: " .. HubState.UserTier,
        Icon = "solar:user-check-bold",
        Callback = function() end
    })

    SettingsTab:Button({
        Title = "Copy Official Discord",
        Icon = "solar:link-bold",
        Callback = function()
            copyToClipboard(DISCORD_INVITE)
            WindUI:Notify({ Title = "Copied", Content = "discord.gg/pHuxGjqsc8 copied!", Duration = 3 })
        end
    })

    WindUI:Notify({
        Title = "Vargin Hub Activated",
        Content = "Welcome! Press [G] to toggle window.",
        Icon = "solar:check-circle-bold",
        Duration = 5
    })
end

-- ====================================================================
-- ULTRA-AESTHETIC CUSTOM KEY SYSTEM GUI (NEVER SQUISHES)
-- ====================================================================
local function ShowKeySystemModal()
    if isfile and isfile(KEY_FILE) then
        local saved = readfile(KEY_FILE)
        local valid, tier = isKeyAuthorized(saved)
        if valid then
            LaunchMainHub(tier)
            return
        end
    end

    if OWNER_USERNAMES[string.lower(LocalPlayer.Name)] then
        LaunchMainHub("Owner Master")
        return
    end

    local existingGui = CoreGui:FindFirstChild("VarginKeyModal")
    if existingGui then existingGui:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "VarginKeyModal"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    pcall(function() ScreenGui.Parent = CoreGui end)

    local Overlay = Instance.new("Frame")
    Overlay.Size = UDim2.new(1, 0, 1, 0)
    Overlay.BackgroundColor3 = Color3.fromRGB(4, 5, 8)
    Overlay.BackgroundTransparency = 0.45
    Overlay.BorderSizePixel = 0
    Overlay.Parent = ScreenGui

    local Dialog = Instance.new("Frame")
    Dialog.Size = UDim2.new(0, 480, 0, 310)
    Dialog.Position = UDim2.new(0.5, 0, 0.5, 0)
    Dialog.AnchorPoint = Vector2.new(0.5, 0.5)
    Dialog.BackgroundColor3 = Color3.fromRGB(18, 20, 36)
    Dialog.BorderSizePixel = 0
    Dialog.Parent = Overlay

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = Dialog

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(93, 98, 214)
    Stroke.Thickness = 1.5
    Stroke.Parent = Dialog

    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0, 50)
    Header.BackgroundTransparency = 1
    Header.Parent = Dialog

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Text = "⚡ VARGIN SCRIPT HUB"
    TitleLabel.Font = Enum.Font.GothamBlack
    TitleLabel.TextSize = 18
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Position = UDim2.new(0, 20, 0, 14)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Parent = Header

    local SubLabel = Instance.new("TextLabel")
    SubLabel.Text = "Authentication Gateway • Made by Fentys & HiddenPulse"
    SubLabel.Font = Enum.Font.GothamMedium
    SubLabel.TextSize = 12
    SubLabel.TextColor3 = Color3.fromRGB(150, 155, 185)
    SubLabel.TextXAlignment = Enum.TextXAlignment.Left
    SubLabel.Position = UDim2.new(0, 20, 0, 34)
    SubLabel.BackgroundTransparency = 1
    SubLabel.Parent = Header

    local InputBox = Instance.new("TextBox")
    InputBox.Size = UDim2.new(1, -40, 0, 48)
    InputBox.Position = UDim2.new(0, 20, 0, 75)
    InputBox.BackgroundColor3 = Color3.fromRGB(14, 16, 28)
    InputBox.Font = Enum.Font.Code
    InputBox.TextSize = 14
    InputBox.TextColor3 = Color3.fromRGB(123, 128, 234)
    InputBox.PlaceholderText = "Paste 24H or VIP Key (e.g. HP-24HR-...)"
    InputBox.PlaceholderColor3 = Color3.fromRGB(90, 95, 125)
    InputBox.ClearTextOnFocus = false
    InputBox.Parent = Dialog

    local InputCorner = Instance.new("UICorner")
    InputCorner.CornerRadius = UDim.new(0, 10)
    InputCorner.Parent = InputBox

    local InputStroke = Instance.new("UIStroke")
    InputStroke.Color = Color3.fromRGB(45, 50, 80)
    InputStroke.Thickness = 1
    InputStroke.Parent = InputBox

    local StatusMsg = Instance.new("TextLabel")
    StatusMsg.Size = UDim2.new(1, -40, 0, 24)
    StatusMsg.Position = UDim2.new(0, 20, 0, 130)
    StatusMsg.Font = Enum.Font.Gotham
    StatusMsg.TextSize = 12
    StatusMsg.TextColor3 = Color3.fromRGB(140, 145, 175)
    StatusMsg.Text = "Keys can be generated instantly for free on our website."
    StatusMsg.BackgroundTransparency = 1
    StatusMsg.Parent = Dialog

    local SubmitBtn = Instance.new("TextButton")
    SubmitBtn.Size = UDim2.new(1, -40, 0, 44)
    SubmitBtn.Position = UDim2.new(0, 20, 0, 165)
    SubmitBtn.BackgroundColor3 = Color3.fromRGB(93, 98, 214)
    SubmitBtn.Font = Enum.Font.GothamBold
    SubmitBtn.TextSize = 14
    SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmitBtn.Text = "⚡ AUTHENTICATE & LAUNCH"
    SubmitBtn.Parent = Dialog

    local SubCorner = Instance.new("UICorner")
    SubCorner.CornerRadius = UDim.new(0, 10)
    SubCorner.Parent = SubmitBtn

    local GetKeyBtn = Instance.new("TextButton")
    GetKeyBtn.Size = UDim2.new(0.5, -25, 0, 38)
    GetKeyBtn.Position = UDim2.new(0, 20, 0, 220)
    GetKeyBtn.BackgroundColor3 = Color3.fromRGB(28, 32, 54)
    GetKeyBtn.Font = Enum.Font.GothamSemibold
    GetKeyBtn.TextSize = 12
    GetKeyBtn.TextColor3 = Color3.fromRGB(123, 128, 234)
    GetKeyBtn.Text = "🔑 Get Key (Website)"
    GetKeyBtn.Parent = Dialog

    local GetKeyCorner = Instance.new("UICorner")
    GetKeyCorner.CornerRadius = UDim.new(0, 8)
    GetKeyCorner.Parent = GetKeyBtn

    local DiscordBtn = Instance.new("TextButton")
    DiscordBtn.Size = UDim2.new(0.5, -25, 0, 38)
    DiscordBtn.Position = UDim2.new(0.5, 5, 0, 220)
    DiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    DiscordBtn.Font = Enum.Font.GothamSemibold
    DiscordBtn.TextSize = 12
    DiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    DiscordBtn.Text = "💬 Join Discord"
    DiscordBtn.Parent = Dialog

    local DiscCorner = Instance.new("UICorner")
    DiscCorner.CornerRadius = UDim.new(0, 8)
    DiscCorner.Parent = DiscordBtn

    -- Interactions
    GetKeyBtn.MouseButton1Click:Connect(function()
        copyToClipboard(WEBSITE_URL)
        StatusMsg.TextColor3 = Color3.fromRGB(123, 128, 234)
        StatusMsg.Text = "✓ Copied: " .. WEBSITE_URL
    end)

    DiscordBtn.MouseButton1Click:Connect(function()
        copyToClipboard(DISCORD_INVITE)
        StatusMsg.TextColor3 = Color3.fromRGB(88, 101, 242)
        StatusMsg.Text = "✓ Discord invite copied to clipboard!"
    end)

    SubmitBtn.MouseButton1Click:Connect(function()
        local entered = InputBox.Text
        local valid, tier = isKeyAuthorized(entered)

        if valid then
            StatusMsg.TextColor3 = Color3.fromRGB(93, 98, 214)
            StatusMsg.Text = "✓ Verified (" .. tier .. ")! Initializing Hub..."
            SubmitBtn.Text = "ACCESS GRANTED"
            SubmitBtn.BackgroundColor3 = Color3.fromRGB(93, 98, 214)

            if writefile then
                pcall(function() writefile(KEY_FILE, entered) end)
            end

            task.wait(0.6)
            ScreenGui:Destroy()
            LaunchMainHub(tier)
        else
            StatusMsg.TextColor3 = Color3.fromRGB(255, 60, 80)
            StatusMsg.Text = "❌ Invalid key! Click 'Get Key' to grab a fresh one from our site."
            InputStroke.Color = Color3.fromRGB(255, 60, 80)
            task.wait(1.5)
            InputStroke.Color = Color3.fromRGB(45, 50, 80)
        end
    end)
end

ShowKeySystemModal()
