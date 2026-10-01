-- PowerSystem/shield.lua
local Power = {}

local Context = nil
local shields = {}

function Power.Init(context)
    Context = context
end

function Power.Enable(player, duration)
    local character = Context and Context.GetCharacter and Context.GetCharacter(player)
    if not character then
        return false
    end

    if character:FindFirstChild("PowerShield") then
        character.PowerShield:Destroy()
    end

    local forceField = Instance.new("ForceField")
    forceField.Name = "PowerShield"
    forceField.Visible = true
    forceField.Parent = character
    shields[player] = forceField

    local seconds = tonumber(duration) or Context.Config.ShieldDuration
    task.delay(seconds, function()
        if shields[player] and shields[player].Parent then
            shields[player]:Destroy()
            shields[player] = nil
        end
    end)

    return true
end

function Power.Disable(player)
    local character = Context and Context.GetCharacter and Context.GetCharacter(player)
    if not character then
        return false
    end

    local shield = character:FindFirstChild("PowerShield")
    if shield then
        shield:Destroy()
    end

    shields[player] = nil
    return true
end

return Power
