-- PowerSystem/freeze.lua
local Power = {}

local Context = nil
local frozen = {}

function Power.Init(context)
    Context = context
end

function Power.Enable(player)
    local humanoid = Context and Context.GetHumanoid and Context.GetHumanoid(player)
    local root = Context and Context.GetRoot and Context.GetRoot(player)
    if not humanoid or not root then
        return false
    end

    frozen[player] = {
        walkSpeed = humanoid.WalkSpeed,
        jumpPower = humanoid.JumpPower,
        anchored = root.Anchored,
    }

    humanoid.WalkSpeed = 0
    humanoid.JumpPower = 0
    root.Anchored = true
    return true
end

function Power.Disable(player)
    local humanoid = Context and Context.GetHumanoid and Context.GetHumanoid(player)
    local root = Context and Context.GetRoot and Context.GetRoot(player)
    if not humanoid or not root then
        return false
    end

    local state = frozen[player]
    if state then
        humanoid.WalkSpeed = state.walkSpeed
        humanoid.JumpPower = state.jumpPower
        root.Anchored = state.anchored
        frozen[player] = nil
    end

    return true
end

return Power
