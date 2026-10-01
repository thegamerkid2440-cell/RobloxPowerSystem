-- PowerSystem/sit.lua
local Power = {}

local Context = nil

function Power.Init(context)
    Context = context
end

function Power.Enable(player)
    local humanoid = Context and Context.GetHumanoid and Context.GetHumanoid(player)
    if not humanoid then
        return false
    end

    humanoid.Sit = true
    return true
end

function Power.Set(player)
    return Power.Enable(player)
end

return Power
