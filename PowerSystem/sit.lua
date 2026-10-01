-- PowerSystem/respawn.lua
local Power = {}

local Context = nil

function Power.Init(context)
    Context = context
end

function Power.Enable(player)
    if player and player:IsA("Player") then
        player:LoadCharacter()
        return true
    end

    return false
end

function Power.Respawn(player)
    return Power.Enable(player)
end

function Power.Reset(player)
    return Power.Enable(player)
end

return Power
