-- PowerSystem/glow.lua
local Power = {}

local Context = nil

function Power.Init(context)
    Context = context
end

function Power.Enable(player, color)
    local character = Context and Context.GetCharacter and Context.GetCharacter(player)
    if not character then
        return false
    end

    local highlight = character:FindFirstChild("PowerGlow")
    if highlight then
        highlight:Destroy()
    end

    local newHighlight = Instance.new("Highlight")
    newHighlight.Name = "PowerGlow"
    newHighlight.FillColor = color or Color3.fromRGB(255, 215, 0)
    newHighlight.OutlineColor = newHighlight.FillColor
    newHighlight.Parent = character
    return true
end

function Power.Disable(player)
    local character = Context and Context.GetCharacter and Context.GetCharacter(player)
    if not character then
        return false
    end

    local highlight = character:FindFirstChild("PowerGlow")
    if highlight then
        highlight:Destroy()
    end

    return true
end

return Power
