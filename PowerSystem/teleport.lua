local P={}; local C
function P.Init(x) C=x end
function P.ToPlayer(p,target) local a=C.Root(p); local b=C.Root(target); if a and b then a.CFrame=b.CFrame+Vector3.new(3,0,0) end end
function P.ToPosition(p,pos) local r=C.Root(p); if r and typeof(pos)=="Vector3" then r.CFrame=CFrame.new(pos) end end
P.Set=P.ToPosition
return P
