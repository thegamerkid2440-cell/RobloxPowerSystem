-- PowerSystem/main.lua
-- Server-side master entry point. Require this ModuleScript from one server Script.
local Root = script.Parent
local Config = require(Root.powers)

local Powers = {}
local names = { "speed", "flight", "jump", "noclip", "gravity", "highjump", "superjump", "walkspeed", "jumppower", "health", "heal", "shield", "invisibility", "glow", "freeze", "unfreeze", "teleport", "respawn", "sit", "spin", "tiny", "giant", "lowgravity", "normalgravity", "sprint", "dash", "doublejump", "playercontrol" }
local context = { Config = Config, Players = game:GetService("Players"), Workspace = game:GetService("Workspace"), RunService = game:GetService("RunService") }
function context.Character(player) return player and player.Character end
function context.Humanoid(player) local c=context.Character(player); return c and c:FindFirstChildOfClass("Humanoid") end
function context.Root(player) local c=context.Character(player); return c and c:FindFirstChild("HumanoidRootPart") end
function context.IsPlayer(value) return typeof(value)=="Instance" and value:IsA("Player") end

for _, name in ipairs(names) do
    local module = require(Root[name])
    if module.Init then module.Init(context) end
    local public = name:gsub("^%l", string.upper)
    Powers[public] = module
end
Powers.Config = Config

local remote
local function authorized(actor, target)
    if not context.IsPlayer(actor) or not context.IsPlayer(target) then return false end
    if actor == target and Config.AllowSelfUse then return true end
    return Config.AdminUserIds[actor.UserId] == true
end

function Powers.IsAuthorized(actor, target) return authorized(actor, target or actor) end
function Powers.Initialize()
    if remote then return remote end
    remote = Instance.new("RemoteEvent")
    remote.Name = Config.RemoteName
    remote.Parent = game:GetService("ReplicatedStorage")
    remote.OnServerEvent:Connect(function(player, action, data)
        data = typeof(data) == "table" and data or {}
        local target = data.Target
        if not context.IsPlayer(target) then target = player end
        if not authorized(player, target) then return end
        if action == "FlightInput" then Powers.Flight.Update(target, data.Direction) end
        if action == "Dash" then Powers.Dash.Enable(target, data.Power) end
        if action == "Sprint" then Powers.Sprint.Enable(target, data.Duration) end
        if action == "DoubleJump" then Powers.DoubleJump.Try(target) end
        if action == "FlightToggle" then if data.Enabled then Powers.Flight.Enable(target, data.Speed) else Powers.Flight.Disable(target) end end
    end)
    return remote
end
return Powers
