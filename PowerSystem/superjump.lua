local P={}; local C
function P.Init(x) C=x end
function P.Enable(p,a) local h=C.Humanoid(p); if h then h.UseJumpPower=true; h.JumpPower=tonumber(a) or C.Config.SuperJumpPower end end
P.Set=P.Enable
function P.Disable(p) local h=C.Humanoid(p); if h then h.JumpPower=C.Config.DefaultJumpPower end end
return P
