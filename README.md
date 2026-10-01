# Modular Roblox Power System

## Explorer placement
1. Create `ReplicatedStorage/PowerSystem` and place every file in the `PowerSystem/` folder there as a ModuleScript. `main.lua` is the ModuleScript named `main`; `powers.lua` is the ModuleScript named `powers`.
2. Create a Script named `PowerSystemServer` in `ServerScriptService` using the supplied server file.
3. Create a LocalScript named `PowerSystemClient` in `StarterPlayerScripts` using the supplied client file.
4. Give `PowerSystemServer` access to the ReplicatedStorage folder. It creates the `PowerSystemRemote` RemoteEvent automatically at runtime.
5. Change `AdminUserIds` in `powers.lua` to trusted numeric UserIds. Self-use is enabled by default; only server code can target another player.

## Server API
```lua
local Powers = require(game.ReplicatedStorage.PowerSystem.main)
Powers.Speed.Set(player, 50)
Powers.Flight.Enable(player, 75)
Powers.Jump.Set(player, 100)
Powers.Health.Set(player, 500)
Powers.Gravity.Set(player, 50)
Powers.Dash.Enable(player, 75)
Powers.Teleport.ToPlayer(player, otherPlayer)
Powers.Teleport.ToPosition(player, Vector3.new(0,20,0))
```
`Powers.Initialize()` is called by the included server Script and must be called exactly once.

## Adding a power
Create a ModuleScript in `ReplicatedStorage/PowerSystem` with `Init(context)`, then add its lowercase filename to the `names` array in `main.lua`. The main controller automatically requires it, initializes it, and exposes it using a capitalized API name. Keep client input in the LocalScript and send a narrowly validated RemoteEvent action.

Gravity is a Workspace-wide setting in Roblox; use it only from trusted server code. Shield uses a normal server-created ForceField. Flight, dash, and double jump use server-side constraints/physics and client input only for direction.
