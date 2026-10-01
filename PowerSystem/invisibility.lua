local P={}; local C; local cache={}
function P.Init(x) C=x end
function P.Enable(p) local c=C.Character(p); if not c then return end; cache[p]={}; for _,v in ipairs(c:GetDescendants()) do if v:IsA("BasePart") or v:IsA("Decal") or v:IsA("Texture") then cache[p][v]=v.Transparency; v.Transparency=1 end end end
function P.Disable(p) if cache[p] then for v,t in pairs(cache[p]) do if v.Parent then v.Transparency=t end end; cache[p]=nil end end
return P
