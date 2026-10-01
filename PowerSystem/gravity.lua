-- PowerSystem/noclip.lua
local Power = {}

local Context = nil
local activePlayers = {}

function Power.Init(context)
    Context = context

    Context.RunService.RenderStepped:Connect(function()
        for player, enabled in pairs(activePlayers) do
            if enabled then
                local character = Context.GetCharacter(player)
                if character then
                    for _, part in ipairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end
        end
    end)
end

function Power.Enable(player)
    local character = Context and Context.GetCharacter and Context.GetCharacter(player)
    if not character then
        return false
    end

    activePlayers[player] = true
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
    return true
end

function Power.Disable(player)
    local character = Context and Context.GetCharacter and Context.GetCharacter(player)
    if not character then
        return false
    end

    activePlayers[player] = nil
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = true
        end
    end
    return true
end

return Power
