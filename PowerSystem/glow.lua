local P={}; local C
function P.Init(x) C=x end
function P.Enable(p,color) local c=C.Character(p); if not c then return end; P.Disable(p); local h=Instance.new("Highlight"); h.Name="PowerGlow"; h.FillColor=typeof(color)=="Color3" and color or Color3.fromRGB(255,220,0); h.OutlineColor=h.FillColor; h.Parent=c end
function P.Disable(p) local c=C.Character(p); if c then local h=c:FindFirstChild("PowerGlow"); if h then h:Destroy() end end end
return P
