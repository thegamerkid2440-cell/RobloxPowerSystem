local P={}; local C; local saved={}
function P.Init(x) C=x end
function P.Enable(p) local h=C.Humanoid(p); local r=C.Root(p); if h and r then saved[p]={ws=h.WalkSpeed,jp=h.JumpPower,anch=r.Anchored}; h.WalkSpeed=0; h.JumpPower=0; r.Anchored=true end end
function P.Disable(p) local h=C.Humanoid(p); local r=C.Root(p); local s=saved[p]; if h and r and s then h.WalkSpeed=s.ws; h.JumpPower=s.jp; r.Anchored=s.anch; saved[p]=nil end end
return P
