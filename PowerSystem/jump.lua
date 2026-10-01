local P={}; local C
function P.Init(x) C=x end
function P.Set(p,a) local h=C.Humanoid(p); if h then h.UseJumpPower=true; h.JumpPower=math.clamp(tonumber(a) or C.Config.DefaultJumpPower,0,250) end end
function P.Reset(p) P.Set(p,C.Config.DefaultJumpPower) end
return P
