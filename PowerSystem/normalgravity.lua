local P={}; local C
function P.Init(x) C=x end
function P.Enable() C.Workspace.Gravity=C.Config.DefaultGravity end
P.Set=P.Enable; P.Disable=P.Enable
return P
