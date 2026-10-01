local P={}; local C
function P.Init(x) C=x end
function P.Enable(p) require(script.Parent.freeze).Disable(p) end
P.Disable=P.Enable
return P
