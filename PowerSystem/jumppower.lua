local P={}; local C
function P.Init(x) C=x end
function P.Set(p,a) local h=C.Humanoid(p); if h then h.UseJumpPower=true; h.JumpPower=tonumber(a) or C.Config.DefaultJumpPower end end
P.Enable=P.Set
function P.Reset(p) P.Set(p,C.Config.DefaultJumpPower) end
return P
