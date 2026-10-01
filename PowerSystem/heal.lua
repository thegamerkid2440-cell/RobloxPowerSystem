-- PowerSystem/health.lua
local Power = {}

local Context = nil

function Power.Init(context)
    Context = context
end

function Power.Set(player, amount)
    local humanoid = Context and Context.GetHumanoid and Context.GetHumanoid(player)
    if not humanoid then
        return false
    end

    local value = tonumber(amount) or 100
    humanoid.MaxHealth = math.max(1, value)
    humanoid.Health = math.clamp(value, 0, humanoid.MaxHealth)
    return true
end

function Power.SetMax(player, amount)
    return Power.Set(player, amount)
end

function Power.SetCurrent(player, amount)
    local humanoid = Context and Context.GetHumanoid and Context.GetHumanoid(player)
    if not humanoid then
        return false
    end

    humanoid.Health = math.clamp(tonumber(amount) or humanoid.Health, 0, humanoid.MaxHealth)
    return true
end

return Power
