-- PowerSystem/lowgravity.lua
local Power = {}

local Context = nil

function Power.Init(context)
    Context = context
end

function Power.Enable(player)
    Context.Workspace.Gravity = Context.Config.LowGravity
    return true
end

function Power.Set(player)
    return Power.Enable(player)
end

return Power
