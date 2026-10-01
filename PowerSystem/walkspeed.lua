local P={}; local C
function P.Init(x) C=x end
function P.Set(p,a) local h=C.Humanoid(p); if h then h.WalkSpeed=tonumber(a) or C.Config.DefaultWalkSpeed end end
P.Enable=P.Set
function P.Reset(p) P.Set(p,C.Config.DefaultWalkSpeed) end
return P
