-- PowerSystem/spin.lua
local Power = {}

local Context = nil

function Power.Init(context)
    Context = context
end

function Power.Enable(player, speed)
    local root = Context and Context.GetRoot and Context.GetRoot(player)
    if not root then
        return false
    end

    local spin = root:FindFirstChild("PowerSpin")
    if spin then
        spin:Destroy()
    end

    local attachment = Instance.new("Attachment")
    attachment.Name = "PowerSpinAttachment"
    attachment.Parent = root

    local angularVelocity = Instance.new("AngularVelocity")
    angularVelocity.Name = "PowerSpin"
    angularVelocity.Attachment0 = attachment
    angularVelocity.AngularVelocity = Vector3.new(0, tonumber(speed) or Context.Config.DefaultSpinSpeed, 0)
    angularVelocity.MaxTorque = math.huge
    angularVelocity.Parent = root
    return true
end

function Power.Disable(player)
    local root = Context and Context.GetRoot and Context.GetRoot(player)
    if not root then
        return false
    end

    local spin = root:FindFirstChild("PowerSpin")
    if spin then
        spin:Destroy()
    end

    local attachment = root:FindFirstChild("PowerSpinAttachment")
    if attachment then
        attachment:Destroy()
    end

    return true
end

return Power
