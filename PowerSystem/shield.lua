-- PowerSystem/heal.lua
local Power = {}

local Context = nil

function Power.Init(context)
    Context = context
end

function Power.Enable(player, amount)
    local humanoid = Context and Context.GetHumanoid and Context.GetHumanoid(player)
    if not humanoid then
        return false
    end

    local healAmount = tonumber(amount) or 25
    humanoid.Health = math.clamp(humanoid.Health + healAmount, 0, humanoid.MaxHealth)
    return true
end

function Power.Heal(player, amount)
    return Power.Enable(player, amount)
end

return Power
