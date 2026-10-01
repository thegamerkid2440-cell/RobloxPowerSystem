local P={}; local C
function P.Init(x) C=x end
function P.Set(p,a) local h=C.Humanoid(p); if h then h.WalkSpeed=math.clamp(tonumber(a) or C.Config.DefaultWalkSpeed,0,100) end end
function P.Enable(p,a) P.Set(p,a) end
function P.Disable(p) P.Set(p,C.Config.DefaultWalkSpeed) end
P.Reset=P.Disable
return P
