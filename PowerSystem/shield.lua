local P={}; local C
function P.Init(x) C=x end
function P.Enable(p,d) local c=C.Character(p); if not c then return end; P.Disable(p); local f=Instance.new("ForceField"); f.Name="PowerShield"; f.Visible=true; f.Parent=c; if d~=false then task.delay(tonumber(d) or C.Config.ShieldDuration,function() if f.Parent then f:Destroy() end end) end end
function P.Disable(p) local c=C.Character(p); if c then local f=c:FindFirstChild("PowerShield"); if f then f:Destroy() end end end
return P
