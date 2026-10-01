-- PowerSystem/normalgravity.lua
local Power = {}

local Context = nil

function Power.Init(context)
    Context = context
end

function Power.Enable(player)
    Context.Workspace.Gravity = Context.Config.DefaultGravity
    return true
end

function Power.Set(player)
    return Power.Enable(player)
end

function Power.Disable(player)
    return Power.Enable(player)
end

return Power
