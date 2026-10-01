local P={}; local C
function P.Init(x) C=x end
function P.Set(p,a) C.Workspace.Gravity=math.clamp(tonumber(a) or C.Config.DefaultGravity,0,1000) end
function P.Reset() C.Workspace.Gravity=C.Config.DefaultGravity end
function P.Launch(p,power) local r=C.Root(p); if r then r:ApplyImpulse(Vector3.new(0,tonumber(power) or C.Config.DefaultJumpPower,0)*r.AssemblyMass) end end
return P
