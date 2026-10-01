local P={}; local C
function P.Init(x) C=x end
function P.Enable(p,d) local h=C.Humanoid(p); if h then h.WalkSpeed=C.Config.SprintWalkSpeed; if d then task.delay(tonumber(d),function() if h.Parent then h.WalkSpeed=C.Config.DefaultWalkSpeed end end) end end end
function P.Disable(p) local h=C.Humanoid(p); if h then h.WalkSpeed=C.Config.DefaultWalkSpeed end end
return P
