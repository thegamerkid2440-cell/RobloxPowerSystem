-- PowerSystem/unfreeze.lua
local Power = {}

local Context = nil

function Power.Init(context)
    Context = context
end

function Power.Enable(player)
    local freezeModule = require(script.Parent.freeze)
    return freezeModule.Disable(player)
end

function Power.Disable(player)
    return Power.Enable(player)
end

return Power
