local P={}; local C
function P.Init(x) C=x end
function P.Enable(p,s) local h=C.Humanoid(p); if h and h:ScaleTo then h:ScaleTo(tonumber(s) or C.Config.GiantScale) end end
P.Set=P.Enable
return P
