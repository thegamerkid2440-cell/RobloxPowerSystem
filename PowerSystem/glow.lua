-- PowerSystem/invisibility.lua
local Power = {}

local Context = nil
local invisible = {}

function Power.Init(context)
    Context = context
end

function Power.Enable(player)
    local character = Context and Context.GetCharacter and Context.GetCharacter(player)
    if not character then
        return false
    end

    invisible[player] = true
    for _, descendant in ipairs(character:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.Transparency = 1
        end
    end

    return true
end

function Power.Disable(player)
    local character = Context and Context.GetCharacter and Context.GetCharacter(player)
    if not character then
        return false
    end

    invisible[player] = nil
    for _, descendant in ipairs(character:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.Transparency = 0
        end
    end

    return true
end

return Power
