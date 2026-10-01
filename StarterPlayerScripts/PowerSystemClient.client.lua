-- ServerScriptService/PowerSystemServer.server.lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PowerFolder = ReplicatedStorage:FindFirstChild("PowerSystem")

if not PowerFolder then
    PowerFolder = Instance.new("Folder")
    PowerFolder.Name = "PowerSystem"
    PowerFolder.Parent = ReplicatedStorage
end

local mainModule = PowerFolder:FindFirstChild("main")
if not mainModule then
    warn("PowerSystem: main.lua must be inside ReplicatedStorage/PowerSystem as ModuleScript named 'main'.")
    return
end

local Powers = require(mainModule)
Powers.Initialize()

-- Example server-side admin grant API
local function grantPower(adminPlayer, targetPlayer, powerName, value)
    local ok, err = Powers.Give(adminPlayer, targetPlayer, powerName, value)
    if not ok then
        warn(adminPlayer.Name .. " failed to grant " .. tostring(powerName) .. ": " .. tostring(err))
    else
        print(adminPlayer.Name .. " granted " .. tostring(powerName) .. " to " .. targetPlayer.Name)
    end
end

-- Example: this script can be called from your admin command system.
-- grantPower(player, targetPlayer, "Flight", 90)
-- grantPower(player, targetPlayer, "Speed", 50)
-- grantPower(player, targetPlayer, "Jump", 150)
-- grantPower(player, targetPlayer, "Health", 500)
