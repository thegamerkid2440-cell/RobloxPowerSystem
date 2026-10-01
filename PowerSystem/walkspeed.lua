-- PowerSystem/superjump.lua
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

    humanoid.JumpPower = tonumber(amount) or Context.Config.SuperJumpPower
    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    return true
end

function Power.Set(player, amount)
    return Power.Enable(player, amount)
end

function Power.Disable(player)
    local humanoid = Context and Context.GetHumanoid and Context.GetHumanoid(player)
    if humanoid then
        humanoid.JumpPower = Context.Config.DefaultJumpPower
    end
    return true
end

return Power
