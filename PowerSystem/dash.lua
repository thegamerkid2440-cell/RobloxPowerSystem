local P={}; local C; local last={}
function P.Init(x) C=x end
function P.Enable(p,power) local now=os.clock(); if now-(last[p] or 0)<C.Config.DashCooldown then return false end; local r=C.Root(p); if not r then return false end; last[p]=now; r:ApplyImpulse(r.CFrame.LookVector*(tonumber(power) or C.Config.DefaultDashPower)*r.AssemblyMass); return true end
P.Dash=P.Enable
return P
