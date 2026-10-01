-- PowerSystem/jumppower.lua
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

    humanoid.JumpPower = tonumber(amount) or Context.Config.DefaultJumpPower
    return true
end

function Power.Enable(player, amount)
    return Power.Set(player, amount)
end

function Power.Disable(player)
    local humanoid = Context and Context.GetHumanoid and Context.GetHumanoid(player)
    if humanoid then
        humanoid.JumpPower = Context.Config.DefaultJumpPower
    end
    return true
end

return Power
