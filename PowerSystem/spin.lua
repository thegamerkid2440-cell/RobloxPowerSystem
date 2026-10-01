local P={}; local C
function P.Init(x) C=x end
function P.Enable(p,s) local r=C.Root(p); if not r then return end; P.Disable(p); local a=Instance.new("Attachment",r); a.Name="PowerSpinAttachment"; local v=Instance.new("AngularVelocity",r); v.Name="PowerSpin"; v.Attachment0=a; v.MaxTorque=math.huge; v.AngularVelocity=Vector3.new(0,tonumber(s) or C.Config.DefaultSpinSpeed,0) end
function P.Disable(p) local r=C.Root(p); if r then for _,v in ipairs(r:GetChildren()) do if v.Name=="PowerSpin" or v.Name=="PowerSpinAttachment" then v:Destroy() end end end end
return P
