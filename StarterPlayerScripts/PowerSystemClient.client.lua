-- StarterPlayerScripts/PowerSystemClient.client.lua
local Players=game:GetService("Players")
local ReplicatedStorage=game:GetService("ReplicatedStorage")
local RunService=game:GetService("RunService")
local CAS=game:GetService("ContextActionService")
local player=Players.LocalPlayer
local remote=ReplicatedStorage:WaitForChild("PowerSystemRemote")
local up,down=false,false
local function action(name,state) if name=="PowerFlightUp" then up=state==Enum.UserInputState.Begin elseif name=="PowerFlightDown" then down=state==Enum.UserInputState.Begin end return Enum.ContextActionResult.Sink end
CAS:BindAction("PowerFlightUp",action,true,Enum.KeyCode.Space)
CAS:BindAction("PowerFlightDown",action,true,Enum.KeyCode.LeftControl)
CAS:SetTitle("PowerFlightUp","Up"); CAS:SetTitle("PowerFlightDown","Down") -- touch buttons are created automatically
RunService.RenderStepped:Connect(function()
 local c=player.Character; local h=c and c:FindFirstChildOfClass("Humanoid")
 if h and c:FindFirstChild("HumanoidRootPart") and c.HumanoidRootPart:GetAttribute("PowerFlight") then
  local dir=h.MoveDirection + Vector3.new(0,(up and 1 or 0)-(down and 1 or 0),0)
  if dir.Magnitude>0 then remote:FireServer("FlightInput",{Direction=dir}) end
 end
end)
-- These controls are self-targeted; the server still validates every request.
CAS:BindAction("PowerDash",function(_,s) if s==Enum.UserInputState.Begin then remote:FireServer("Dash",{}) end return Enum.ContextActionResult.Sink end,true,Enum.KeyCode.Q)
CAS:SetTitle("PowerDash","Dash")
CAS:BindAction("PowerDoubleJump",function(_,s) if s==Enum.UserInputState.Begin then remote:FireServer("DoubleJump",{}) end return Enum.ContextActionResult.Sink end,false,Enum.KeyCode.Space)
