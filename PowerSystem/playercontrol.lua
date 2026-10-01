local P={}; local C
function P.Init(x) C=x end
function P.Set(p,enabled) p:SetAttribute("PowerPlayerControl",enabled==true) end
P.Enable=P.Set
function P.Disable(p) P.Set(p,false) end
return P
