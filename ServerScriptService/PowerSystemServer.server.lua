-- ServerScriptService/PowerSystemServer.server.lua
local ReplicatedStorage=game:GetService("ReplicatedStorage")
local folder=ReplicatedStorage:WaitForChild("PowerSystem")
local Powers=require(folder.main)
Powers.Initialize()

-- Example server-only usage:
-- Powers.Speed.Set(player, 50)
-- Powers.Flight.Enable(player, 75)
-- Powers.Jump.Set(player, 100)
-- Never accept arbitrary target names from an untrusted client; validate your own admin UI here.
