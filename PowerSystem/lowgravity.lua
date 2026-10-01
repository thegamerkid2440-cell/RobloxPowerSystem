local P={}; local C
function P.Init(x) C=x end
function P.Enable() C.Workspace.Gravity=C.Config.LowGravity end
P.Set=P.Enable
return P
