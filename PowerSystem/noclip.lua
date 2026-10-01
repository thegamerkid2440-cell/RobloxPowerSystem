local P={}; local C; local enabled={}
function P.Init(x) C=x; C.RunService.Stepped:Connect(function() for p in pairs(enabled) do local c=C.Character(p); if c then for _,v in ipairs(c:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide=false end end end end end) end
function P.Enable(p) enabled[p]=true end
function P.Disable(p) enabled[p]=nil; local c=C.Character(p); if c then for _,v in ipairs(c:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide=true end end end end
return P
