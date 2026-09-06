--====================================================================--
-- VARGIN SCRIPT HUB - PRO WINDUI EDITION
-- Multi-CDN Fallback • Fixed Sliders • Full Feature Bindings
--====================================================================--

-- 1. Multi-CDN Resilient WindUI Loader
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
    warn("[Vargin Hub Error] All CDN mirrors failed. Check executor network permissions.")
    return
end

-- 2. Engine Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera or Workspace:WaitForChild("Camera")
local OriginalGravity = Workspace.Gravity

-- 3. Global State
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

------------------------------------------------------------------------
-- CHARACTER HELPER FUNCTIONS
------------------------------------------------------------------------
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

------------------------------------------------------------------------
-- MAIN WINDOW SETUP
------------------------------------------------------------------------
local Window = WindUI:CreateWindow({
    Title = "VARGIN SCRIPT HUB",
    Icon = "shield-alert",
    Author = "Pro Edition • by LO",
    Folder = "VarginHubConfig",
    Size = UDim2.fromOffset(600, 420),
    Transparent = true,
    Theme = "Dark"
})

WindUI:Notify({
    Title = "Vargin Hub",
    Content = "All sliders and tabs loaded successfully, boss.",
    Duration = 3,
    Icon = "check"
})

------------------------------------------------------------------------
-- TABS
------------------------------------------------------------------------
local MovementTab = Window:Tab({ Title = "Movement", Icon = "zap" })
local VisualsTab  = Window:Tab({ Title = "Visuals", Icon = "eye" })
local CombatTab   = Window:Tab({ Title = "Combat", Icon = "swords" })
local PlayerTab   = Window:Tab({ Title = "Player", Icon = "user" })
local WorldTab    = Window:Tab({ Title = "World", Icon = "globe" })
local StealthTab  = Window:Tab({ Title = "Stealth", Icon = "shield" })
local TeleportTab = Window:Tab({ Title = "Teleports", Icon = "map-pin" })
local UtilityTab  = Window:Tab({ Title = "Utility", Icon = "settings" })

------------------------------------------------------------------------
-- 1. MOVEMENT TAB
------------------------------------------------------------------------
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
    Value = {
        Min = 16,
        Max = 350,
        Default = 50
    },
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
    Value = {
        Min = 50,
        Max = 400,
        Default = 100
    },
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
        Workspace.Gravity = v and State.GravityValue or OriginalGravity
    end
})

MovementTab:Slider({
    Title = "Gravity Level",
    Desc = "Target gravity coefficient",
    Step = 1,
    Value = {
        Min = 0,
        Max = 196,
        Default = 50
    },
    Callback = function(val)
        State.GravityValue = val
        if State.LowGravity then Workspace.Gravity = val end
    end
})

MovementTab:Toggle({
    Title = "Freeze Position",
    Desc = "Lock physical velocity to zero",
    Value = false,
    Callback = function(v) State.FreezePosition = v end
})

------------------------------------------------------------------------
-- 2. VISUALS TAB
------------------------------------------------------------------------
local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "VarginHub_ESP"
pcall(function() ESPFolder.Parent = CoreGui end)

local function UpdateESP()
    ESPFolder:ClearAllChildren()

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            -- Highlight Chams
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

            -- Head Dot
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

------------------------------------------------------------------------
-- 3. COMBAT TAB
------------------------------------------------------------------------
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
    Value = {
        Min = 1,
        Max = 35,
        Default = 10
    },
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
    Value = {
        Min = 2,
        Max = 25,
        Default = 5
    },
    Callback = function(val) State.HitboxSize = val end
})

------------------------------------------------------------------------
-- 4. PLAYER & CAMERA TAB
------------------------------------------------------------------------
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
    Value = {
        Min = 5,
        Max = 120,
        Default = 30
    },
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
    Value = {
        Min = 40,
        Max = 125,
        Default = 70
    },
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

------------------------------------------------------------------------
-- 5. WORLD TAB
------------------------------------------------------------------------
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

------------------------------------------------------------------------
-- 6. STEALTH TAB
------------------------------------------------------------------------
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

------------------------------------------------------------------------
-- 7. TELEPORT TAB
------------------------------------------------------------------------
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

------------------------------------------------------------------------
-- 8. UTILITY TAB
------------------------------------------------------------------------
UtilityTab:Button({
    Title = "Copy Place ID",
    Desc = "Copies PlaceId to clipboard",
    Callback = function()
        if setclipboard then
            setclipboard(tostring(game.PlaceId))
            WindUI:Notify({ Title = "Copied", Content = "PlaceId copied.", Duration = 2 })
        end
    end
})

UtilityTab:Button({
    Title = "Copy Job ID",
    Desc = "Copies JobId to clipboard",
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

------------------------------------------------------------------------
-- CONTINUOUS RUNTIME ENGINE
------------------------------------------------------------------------
RunService.Stepped:Connect(function()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")

        -- WalkSpeed
        if hum and State.SpeedHack then
            hum.WalkSpeed = State.WalkSpeed
        end

        -- JumpPower
        if hum and State.JumpPowerHack then
            hum.UseJumpPower = true
            hum.JumpPower = State.JumpPower
        end

        -- Noclip (Stepped prevents snapping)
        if State.Noclip then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end

        -- Spinbot
        if State.Spinbot and hrp then
            hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(State.SpinSpeed), 0)
        end

        -- Freeze
        if State.FreezePosition and hrp then
            hrp.AssemblyLinearVelocity = Vector3.zero
        end

        -- Hitbox Expander
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

-- Infinite Jump Listener
UserInputService.JumpRequest:Connect(function()
    if State.InfiniteJump then
        local hum = GetHumanoid()
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Auto Clicker Thread
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
