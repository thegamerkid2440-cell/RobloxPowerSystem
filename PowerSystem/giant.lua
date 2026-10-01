-- PowerSystem/tiny.lua
local Power = {}

local Context = nil

function Power.Init(context)
    Context = context
end

function Power.Enable(player, scale)
    local humanoid = Context and Context.GetHumanoid and Context.GetHumanoid(player)
    if not humanoid or not humanoid:FindFirstChild("BodyScale") then
        return false
    end

    local targetScale = tonumber(scale) or Context.Config.TinyScale
    if humanoid and humanoid:ScaleTo then
        humanoid:ScaleTo(targetScale)
    end
    return true
end

function Power.Set(player, scale)
    return Power.Enable(player, scale)
end

return Power
