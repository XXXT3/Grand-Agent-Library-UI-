--[[
    Tween Utility for Luminous UI Library
    
    Provides animation functionality with support across different executors
]]

local Tween = {}

-- Check for tween service availability
local TweenService = game:GetService("TweenService")

-- Default tween info
local defaultTweenInfo = TweenInfo.new(
    0.2,                -- Duration (seconds)
    Enum.EasingStyle.Quad, -- Easing style
    Enum.EasingDirection.Out, -- Easing direction
    0,                  -- Repeat count (0 = don't repeat)
    false,              -- Reverses (false = don't reverse)
    0                   -- Delay time (seconds)
)

-- Create a tween with custom properties
function Tween.Create(instance, duration, properties, style, direction)
    -- Ensure the instance is valid
    if not instance then
        warn("Tween.Create: Instance is nil")
        return nil
    end
    
    -- Create tween info
    local tweenInfo = TweenInfo.new(
        duration or 0.2,
        style or Enum.EasingStyle.Quad,
        direction or Enum.EasingDirection.Out,
        0, false, 0
    )
    
    -- Handle compatibility with different executors
    local success, tween = pcall(function()
        return TweenService:Create(instance, tweenInfo, properties)
    end)
    
    if not success then
        warn("Tween.Create: Failed to create tween - " .. tostring(tween))
        return nil
    end
    
    -- Play the tween
    tween:Play()
    
    return tween
end

-- Create a sequence of tweens
function Tween.Sequence(tweens, delays)
    delays = delays or {}
    
    -- Run the first tween immediately
    if #tweens > 0 then
        local firstTween = tweens[1]
        if typeof(firstTween) == "table" and firstTween.Play then
            firstTween:Play()
        end
    end
    
    -- Schedule the rest with delays
    for i = 2, #tweens do
        local delay = delays[i-1] or 0.1
        task.delay(delay, function()
            local currentTween = tweens[i]
            if typeof(currentTween) == "table" and currentTween.Play then
                currentTween:Play()
            end
        end)
    end
end

-- Simple property transition without using TweenService
-- Fallback for environments where TweenService might not work
function Tween.Transition(instance, property, targetValue, duration, callback)
    -- Ensure the instance is valid
    if not instance then
        warn("Tween.Transition: Instance is nil")
        return
    end
    
    -- Get initial value
    local initialValue = instance[property]
    
    -- Determine if we need to tween a Color3, UDim2, or number
    local isColor = typeof(initialValue) == "Color3"
    local isUDim2 = typeof(initialValue) == "UDim2"
    local isVector2 = typeof(initialValue) == "Vector2"
    local isVector3 = typeof(initialValue) == "Vector3"
    
    duration = duration or 0.2
    local startTime = tick()
    
    -- Function to calculate lerp (linear interpolation)
    local function lerp(a, b, t)
        return a + (b - a) * t
    end
    
    -- Function to calculate Color3 lerp
    local function lerpColor(c1, c2, t)
        return Color3.new(
            lerp(c1.R, c2.R, t),
            lerp(c1.G, c2.G, t),
            lerp(c1.B, c2.B, t)
        )
    end
    
    -- Function to calculate UDim2 lerp
    local function lerpUDim2(u1, u2, t)
        return UDim2.new(
            lerp(u1.X.Scale, u2.X.Scale, t),
            lerp(u1.X.Offset, u2.X.Offset, t),
            lerp(u1.Y.Scale, u2.Y.Scale, t),
            lerp(u1.Y.Offset, u2.Y.Offset, t)
        )
    end
    
    -- Function to calculate Vector2 lerp
    local function lerpVector2(v1, v2, t)
        return Vector2.new(
            lerp(v1.X, v2.X, t),
            lerp(v1.Y, v2.Y, t)
        )
    end
    
    -- Function to calculate Vector3 lerp
    local function lerpVector3(v1, v2, t)
        return Vector3.new(
            lerp(v1.X, v2.X, t),
            lerp(v1.Y, v2.Y, t),
            lerp(v1.Z, v2.Z, t)
        )
    end
    
    -- Connection to update the property value
    local connection
    connection = game:GetService("RunService").RenderStepped:Connect(function()
        local elapsed = tick() - startTime
        local alpha = math.min(elapsed / duration, 1)
        
        -- Apply easing (simple quad out easing)
        local easedAlpha = 1 - (1 - alpha) * (1 - alpha)
        
        -- Calculate and set the current value based on type
        if isColor then
            instance[property] = lerpColor(initialValue, targetValue, easedAlpha)
        elseif isUDim2 then
            instance[property] = lerpUDim2(initialValue, targetValue, easedAlpha)
        elseif isVector2 then
            instance[property] = lerpVector2(initialValue, targetValue, easedAlpha)
        elseif isVector3 then
            instance[property] = lerpVector3(initialValue, targetValue, easedAlpha)
        else
            -- Assume it's a number or other simple value
            instance[property] = lerp(initialValue, targetValue, easedAlpha)
        end
        
        -- Check if the transition is complete
        if alpha >= 1 then
            connection:Disconnect()
            if callback then
                callback()
            end
        end
    end)
    
    -- Return a function to cancel the transition
    return function()
        if connection then
            connection:Disconnect()
        end
    end
end

-- Fade an instance in (from transparent to visible)
function Tween.FadeIn(instance, duration, targetTransparency)
    if not instance then return end
    targetTransparency = targetTransparency or 0
    
    -- Store original transparency
    local originalTransparency = instance.BackgroundTransparency
    
    -- Set initial transparency
    instance.BackgroundTransparency = 1
    
    -- Animate to target transparency
    return Tween.Create(instance, duration or 0.2, {
        BackgroundTransparency = targetTransparency
    })
end

-- Fade an instance out (from visible to transparent)
function Tween.FadeOut(instance, duration, callback)
    if not instance then return end
    
    -- Animate to full transparency
    local tween = Tween.Create(instance, duration or 0.2, {
        BackgroundTransparency = 1
    })
    
    -- Handle callback after tween completes
    if callback then
        tween.Completed:Connect(function()
            callback()
        end)
    end
    
    return tween
end

-- Slide an instance in from a direction
function Tween.SlideIn(instance, direction, duration)
    if not instance then return end
    direction = direction or "Right"
    duration = duration or 0.3
    
    -- Store original position
    local originalPosition = instance.Position
    
    -- Set initial position based on direction
    local startPosition
    if direction == "Right" then
        startPosition = UDim2.new(1, 50, originalPosition.Y.Scale, originalPosition.Y.Offset)
    elseif direction == "Left" then
        startPosition = UDim2.new(-1, -50, originalPosition.Y.Scale, originalPosition.Y.Offset)
    elseif direction == "Up" then
        startPosition = UDim2.new(originalPosition.X.Scale, originalPosition.X.Offset, -1, -50)
    elseif direction == "Down" then
        startPosition = UDim2.new(originalPosition.X.Scale, originalPosition.X.Offset, 1, 50)
    end
    
    instance.Position = startPosition
    
    -- Animate to original position
    return Tween.Create(instance, duration, {
        Position = originalPosition
    })
end

-- Slide an instance out in a direction
function Tween.SlideOut(instance, direction, duration, callback)
    if not instance then return end
    direction = direction or "Right"
    duration = duration or 0.3
    
    -- Store original position
    local originalPosition = instance.Position
    
    -- Set target position based on direction
    local endPosition
    if direction == "Right" then
        endPosition = UDim2.new(1, 50, originalPosition.Y.Scale, originalPosition.Y.Offset)
    elseif direction == "Left" then
        endPosition = UDim2.new(-1, -50, originalPosition.Y.Scale, originalPosition.Y.Offset)
    elseif direction == "Up" then
        endPosition = UDim2.new(originalPosition.X.Scale, originalPosition.X.Offset, -1, -50)
    elseif direction == "Down" then
        endPosition = UDim2.new(originalPosition.X.Scale, originalPosition.X.Offset, 1, 50)
    end
    
    -- Animate to end position
    local tween = Tween.Create(instance, duration, {
        Position = endPosition
    })
    
    -- Handle callback after tween completes
    if callback then
        tween.Completed:Connect(function()
            callback()
        end)
    end
    
    return tween
end

return Tween
