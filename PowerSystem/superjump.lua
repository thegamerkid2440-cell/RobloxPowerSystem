-- PowerSystem/highjump.lua
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

    local jumpStrength = tonumber(amount) or Context.Config.HighJumpPower
    humanoid.JumpPower = jumpStrength
    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)

    task.delay(0.4, function()
        if humanoid and humanoid.Parent then
            humanoid.JumpPower = Context.Config.DefaultJumpPower
        end
    end)

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
