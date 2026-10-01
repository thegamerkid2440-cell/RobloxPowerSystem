local P={}; local C
function P.Init(x) C=x end
function P.SetMax(p,a) local h=C.Humanoid(p); if h then h.MaxHealth=math.max(1,tonumber(a) or 100) end end
function P.Set(p,a) local h=C.Humanoid(p); if h then h.MaxHealth=math.max(1,tonumber(a) or 100); h.Health=h.MaxHealth end end
function P.SetCurrent(p,a) local h=C.Humanoid(p); if h then h.Health=math.clamp(tonumber(a) or h.Health,0,h.MaxHealth) end end
return P
