local P={}; local C
function P.Init(x) C=x end
function P.Enable(p) local h=C.Humanoid(p); if h then h.Sit=true end end
P.Set=P.Enable
return P
