-- PowerSystem/playercontrol.lua
local Power = {}

function Power.Init(context)
    self.Context = context
end

function Power.Enable(player)
    if player and player:IsA("Player") then
        player:SetAttribute("PowerPlayerControlEnabled", true)
    end
    return true
end

function Power.Disable(player)
    if player and player:IsA("Player") then
        player:SetAttribute("PowerPlayerControlEnabled", false)
    end
    return true
end

return Power
