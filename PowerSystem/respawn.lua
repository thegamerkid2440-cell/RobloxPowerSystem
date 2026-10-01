local P={}; local C
function P.Init(x) C=x end
function P.Enable(p) p:LoadCharacter() end
P.Respawn=P.Enable; P.Reset=P.Enable
return P
