local P={}; local C; local function stop(p) local r=C.Root(p); if not r then return end; for _,v in ipairs(r:GetChildren()) do if v.Name=="PowerFlightVelocity" or v.Name=="PowerFlightAttachment" then v:Destroy() end end; r:SetAttribute("PowerFlight",false) end
function P.Init(x) C=x end
function P.Enable(p,s) local r=C.Root(p); if not r then return end; P.Disable(p); local a=Instance.new("Attachment"); a.Name="PowerFlightAttachment"; a.Parent=r; local v=Instance.new("LinearVelocity"); v.Name="PowerFlightVelocity"; v.Attachment0=a; v.MaxForce=math.huge; v.VectorVelocity=Vector3.zero; v.RelativeTo=Enum.ActuatorRelativeTo.World; v.Parent=r; r:SetAttribute("PowerFlight",true); r:SetAttribute("PowerFlightSpeed",tonumber(s) or C.Config.DefaultFlightSpeed) end
function P.Update(p,d) local r=C.Root(p); if not r or not r:GetAttribute("PowerFlight") then return end; local v=r:FindFirstChild("PowerFlightVelocity"); if v and typeof(d)=="Vector3" then v.VectorVelocity=d.Unit*(r:GetAttribute("PowerFlightSpeed") or C.Config.DefaultFlightSpeed) end end
function P.Disable(p) stop(p) end
P.SetSpeed=function(p,s) local r=C.Root(p); if r then r:SetAttribute("PowerFlightSpeed",tonumber(s) or C.Config.DefaultFlightSpeed) end end
return P
