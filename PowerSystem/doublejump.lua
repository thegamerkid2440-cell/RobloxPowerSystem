-- PowerSystem/dash.lua
local Power = {}

local Context = nil
local lastUsed = {}

function Power.Init(context)
    Context = context
end

function Power.Enable(player, power)
    local root = Context and Context.GetRoot and Context.GetRoot(player)
    if not root then
        return false
    end

    local now = os.clock()
    if lastUsed[player] and now - lastUsed[player] < (Context.Config.DashCooldown or 1) then
        return false
    end

    local dashForce = tonumber(power) or Context.Config.DefaultDashPower
    local direction = root.CFrame.LookVector
    root.CFrame = root.CFrame + Vector3.new(0, 0.1, 0)
    root.AssemblyLinearVelocity = direction * dashForce
    lastUsed[player] = now
    return true
end

function Power.Dash(player, power)
    return Power.Enable(player, power)
end

return Power
