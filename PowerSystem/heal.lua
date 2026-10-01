local P={}; local C
function P.Init(x) C=x end
function P.Enable(p,a) local h=C.Humanoid(p); if h then h.Health=math.min(h.MaxHealth,h.Health+(tonumber(a) or h.MaxHealth)) end end
P.Heal=P.Enable
return P
