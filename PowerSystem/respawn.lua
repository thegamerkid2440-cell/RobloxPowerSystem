-- PowerSystem/teleport.lua
local Power = {}

local Context = nil

function Power.Init(context)
    Context = context
end

function Power.ToPlayer(player, target)
    local root = Context and Context.GetRoot and Context.GetRoot(player)
    local targetRoot = Context and Context.GetRoot and Context.GetRoot(target)
    if not root or not targetRoot then
        return false
    end

    root.CFrame = targetRoot.CFrame + Vector3.new(0, 3, 0)
    return true
end

function Power.ToPosition(player, position)
    local root = Context and Context.GetRoot and Context.GetRoot(player)
    if not root or typeof(position) ~= "Vector3" then
        return false
    end

    root.CFrame = CFrame.new(position)
    return true
end

function Power.Enable(player, targetOrPosition)
    if typeof(targetOrPosition) == "Vector3" then
        return Power.ToPosition(player, targetOrPosition)
    end

    if targetOrPosition and targetOrPosition:IsA("Player") then
        return Power.ToPlayer(player, targetOrPosition)
    end

    return false
end

return Power
