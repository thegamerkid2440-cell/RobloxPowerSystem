-- PowerSystem/doublejump.lua
local Power = {}

local Context = nil
local state = {}

function Power.Init(context)
    Context = context
end

function Power.Enable(player)
    local humanoid = Context and Context.GetHumanoid and Context.GetHumanoid(player)
    if not humanoid then
        return false
    end

    state[player] = true
    return true
end

function Power.Try(player)
    local humanoid = Context and Context.GetHumanoid and Context.GetHumanoid(player)
    local root = Context and Context.GetRoot and Context.GetRoot(player)
    if not humanoid or not root then
        return false
    end

    if humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
        return false
    end

    local boost = tonumber(Context.Config.DoubleJumpPower) or 70
    root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, boost, root.AssemblyLinearVelocity.Z)
    return true
end

function Power.Disable(player)
    state[player] = nil
    return true
end

return Power
