-- PowerSystem/gravity.lua
local Power = {}

local Context = nil

function Power.Init(context)
    Context = context
end

function Power.Set(player, amount)
    local gravity = tonumber(amount) or Context.Config.DefaultGravity
    Context.Workspace.Gravity = gravity
    return true
end

function Power.Enable(player, amount)
    return Power.Set(player, amount)
end

function Power.Disable(player)
    Context.Workspace.Gravity = Context.Config.DefaultGravity
    return true
end

function Power.Reset(player)
    return Power.Disable(player)
end

return Power
