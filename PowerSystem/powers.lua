-- PowerSystem/main.lua
-- Single master entry point for the whole power system.
-- Put this file in ReplicatedStorage/PowerSystem as ModuleScript named "main".

local PowerSystemFolder = script.Parent
local Config = require(PowerSystemFolder:WaitForChild("powers"))

local Powers = {}
local moduleNames = {
    "speed",
    "flight",
    "jump",
    "noclip",
    "gravity",
    "highjump",
    "superjump",
    "walkspeed",
    "jumppower",
    "health",
    "heal",
    "shield",
    "invisibility",
    "glow",
    "freeze",
    "unfreeze",
    "teleport",
    "respawn",
    "sit",
    "spin",
    "tiny",
    "giant",
    "lowgravity",
    "normalgravity",
    "sprint",
    "dash",
    "doublejump",
    "playercontrol",
    "admin",
}

local Services = {
    Players = game:GetService("Players"),
    RunService = game:GetService("RunService"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    Workspace = game:GetService("Workspace"),
}

local function getCharacter(player)
    if not player or not player:IsA("Player") then
        return nil
    end
    return player.Character or player.CharacterAdded:Wait()
end

local function getHumanoid(player)
    local character = getCharacter(player)
    if not character then
        return nil
    end
    return character:FindFirstChildOfClass("Humanoid")
end

local function getRoot(player)
    local character = getCharacter(player)
    if not character then
        return nil
    end
    return character:FindFirstChild("HumanoidRootPart")
end

local function isPlayer(obj)
    return typeof(obj) == "Instance" and obj:IsA("Player")
end

local context = {
    Config = Config,
    Players = Services.Players,
    RunService = Services.RunService,
    Workspace = Services.Workspace,
    ReplicatedStorage = Services.RepliclicatedStorage,
    GetCharacter = getCharacter,
    GetHumanoid = getHumanoid,
    GetRoot = getRoot,
    IsPlayer = isPlayer,
}

for _, moduleName in ipairs(moduleNames) do
    local moduleScript = PowerSystemFolder:FindFirstChild(moduleName)
    if not moduleScript or not moduleScript:IsA("ModuleScript") then
        warn("PowerSystem: missing module " .. moduleName)
        continue
    end

    local module = require(moduleScript)
    if type(module) == "table" then
        if module.Init then
            module.Init(context)
        end

        local exportName = moduleName:gsub("^%l", string.upper)
        Powers[exportName] = module
    end
end

Powers.Config = Config
Powers.Context = context

Powers.Admin = Powers.Admin or {}
Powers.Admin.CanGrant = function(actor, target)
    if not isPlayer(actor) then
        return false
    end

    if not isPlayer(target) then
        return false
    end

    if actor == target then
        return Config.AllowSelfUse == true
    end

    return Config.AdminUserIds[actor.UserId] == true
end

Powers.Admin.Grant = function(actor, target, powerName, value)
    if not Powers.Admin.CanGrant(actor, target) then
        return false, "Not authorized"
    end

    local validPower = Powers[powerName]
    if not validPower then
        return false, "Unknown power: " .. tostring(powerName)
    end

    if validPower.Set and type(validPower.Set) == "function" then
        if value == nil then
            validPower.Set(target, Config.DefaultWalkSpeed)
        else
            validPower.Set(target, value)
        end
        return true
    end

    if validPower.Enable and type(validPower.Enable) == "function" then
        if value == nil then
            validPower.Enable(target)
        else
            validPower.Enable(target, value)
        end
        return true
    end

    return false, "Power does not expose Set/Enable"
end

Powers.Give = function(actor, target, powerName, value)
    return Powers.Admin.Grant(actor, target, powerName, value)
end

-- Remote event for client control input.
local remote = Services.ReplicatedStorage:FindFirstChild(Config.RemoteName)
if not remote then
    remote = Instance.new("RemoteEvent")
    remote.Name = Config.RemoteName
    remote.Parent = Services.ReplicatedStorage
end

remote.OnServerEvent:Connect(function(player, action, payload)
    payload = payload or {}
    local target = payload.Target or player

    if not Powers.Admin.CanGrant(player, target) then
        return
    end

    if action == "FlightInput" then
        if Powers.Flight and Powers.Flight.Update then
            Powers.Flight.Update(target, payload.Direction)
        end
    elseif action == "FlightToggle" then
        if payload.Enabled == true then
            Powers.Flight.Enable(target, payload.Speed or Config.DefaultFlightSpeed)
        else
            Powers.Flight.Disable(target)
        end
    elseif action == "Dash" then
        if Powers.Dash and Powers.Dash.Enable then
            Powers.Dash.Enable(target, payload.Power or Config.DefaultDashPower)
        end
    elseif action == "Sprint" then
        if Powers.Sprint and Powers.Sprint.Enable then
            Powers.Sprint.Enable(target, payload.Duration or 2)
        end
    elseif action == "DoubleJump" then
        if Powers.DoubleJump and Powers.DoubleJump.Try then
            Powers.DoubleJump.Try(target)
        end
    end
end)

function Powers.Initialize()
    return remote
end

return Powers
