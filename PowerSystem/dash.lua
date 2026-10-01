-- PowerSystem/sprint.lua
local Power = {}

local Context = nil
local sprintTimers = {}

function Power.Init(context)
    Context = context
end

function Power.Enable(player, duration)
    local humanoid = Context and Context.GetHumanoid and Context.GetHumanoid(player)
    if not humanoid then
        return false
    end

    local oldSpeed = humanoid.WalkSpeed
    humanoid.WalkSpeed = Context.Config.SprintWalkSpeed

    if sprintTimers[player] then
        sprintTimers[player]:Disconnect()
        sprintTimers[player] = nil
    end

    local time = tonumber(duration) or 2
    local connection
    connection = task.delay(time, function()
        if humanoid and humanoid.Parent then
            humanoid.WalkSpeed = oldSpeed
        end
        sprintTimers[player] = nil
    end)

    sprintTimers[player] = { Disconnect = function() task.cancel(connection) end }
    return true
end

function Power.Disable(player)
    local humanoid = Context and Context.GetHumanoid and Context.GetHumanoid(player)
    if humanoid then
        humanoid.WalkSpeed = Context.Config.DefaultWalkSpeed
    end
    return true
end

return Power
