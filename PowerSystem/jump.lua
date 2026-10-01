-- PowerSystem/flight.lua
local Power = {}

local Context = nil
local active = {}

function Power.Init(context)
    Context = context
end

local function ensureVelocity(player)
    local root = Context and Context.GetRoot and Context.GetRoot(player)
    if not root then
        return nil
    end

    local velocity = root:FindFirstChild("PowerFlightVelocity")
    if not velocity then
        velocity = Instance.new("BodyVelocity")
        velocity.Name = "PowerFlightVelocity"
        velocity.MaxForce = Vector3.new(50000, 50000, 50000)
        velocity.Parent = root
    end

    return velocity
end

function Power.SetFlightSpeed(player, speed)
    local root = Context and Context.GetRoot and Context.GetRoot(player)
    if not root then
        return false
    end

    root:SetAttribute("PowerFlightSpeed", tonumber(speed) or Context.Config.DefaultFlightSpeed)
    return true
end

function Power.Enable(player, speed)
    local root = Context and Context.GetRoot and Context.GetRoot(player)
    if not root then
        return false
    end

    local velocity = ensureVelocity(player)
    if not velocity then
        return false
    end

    local flightSpeed = tonumber(speed) or Context.Config.DefaultFlightSpeed
    root:SetAttribute("PowerFlightSpeed", flightSpeed)
    root:SetAttribute("PowerFlightEnabled", true)
    active[player] = true
    return true
end

function Power.Disable(player)
    local root = Context and Context.GetRoot and Context.GetRoot(player)
    if not root then
        return false
    end

    local velocity = root:FindFirstChild("PowerFlightVelocity")
    if velocity then
        velocity:Destroy()
    end

    root:SetAttribute("PowerFlightEnabled", false)
    root:SetAttribute("PowerFlightSpeed", 0)
    active[player] = nil
    return true
end

function Power.Update(player, direction)
    local root = Context and Context.GetRoot and Context.GetRoot(player)
    if not root or root:GetAttribute("PowerFlightEnabled") ~= true then
        return false
    end

    local vector = direction or Vector3.new(0, 0, 0)
    local speed = root:GetAttribute("PowerFlightSpeed") or Context.Config.DefaultFlightSpeed

    local velocity = root:FindFirstChild("PowerFlightVelocity")
    if velocity then
        velocity.Velocity = vector.Unit * speed
    end

    return true
end

function Power.Set(player, amount)
    return Power.SetFlightSpeed(player, amount)
end

return Power
