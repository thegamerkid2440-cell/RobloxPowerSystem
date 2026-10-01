local P={}; local C
function P.Init(x) C=x end
function P.Enable(p,d) local h=C.Humanoid(p); if h then h.UseJumpPower=true; h.JumpPower=C.Config.HighJumpPower; task.delay(tonumber(d) or 5,function() if h.Parent then h.JumpPower=C.Config.DefaultJumpPower end end) end end
P.Set=P.Enable
return P
