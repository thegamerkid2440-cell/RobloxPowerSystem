local P={}; local C; local state={}
function P.Init(x) C=x end
function P.Enable(p) state[p]={used=false}; local h=C.Humanoid(p); if h then h.StateChanged:Connect(function(_,new) if new==Enum.HumanoidStateType.Landed or new==Enum.HumanoidStateType.Running then state[p].used=false end end) end end
function P.Try(p) local h=C.Humanoid(p); local r=C.Root(p); if not h or not r then return end; state[p]=state[p] or {used=false}; if state[p].used then return end; local s=h:GetState(); if s==Enum.HumanoidStateType.Freefall or s==Enum.HumanoidStateType.Jumping then state[p].used=true; r:ApplyImpulse(Vector3.new(0,C.Config.DoubleJumpPower,0)*r.AssemblyMass) end end
function P.Disable(p) state[p]=nil end
return P
