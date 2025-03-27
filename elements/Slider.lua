--[[
    Slider Element for Luminous UI Library
    
    Creates slider elements with customizable ranges, appearance, and callbacks
]]

local Slider = {}

function Slider.Create(library, parent, config)
    config = config or {}
    config.Name = config.Name or "Slider"
    config.Min = config.Min or 0
    config.Max = config.Max or 100
    config.Default = config.Default or config.Min
    config.Increment = config.Increment or 1
    config.ValueSuffix = config.ValueSuffix or ""
    config.Flag = config.Flag or config.Name
    config.Callback = config.Callback or function() end
    config.Description = config.Description or nil
    
    -- Clamp default value to range
    config.Default = math.clamp(config.Default, config.Min, config.Max)
    
    -- Create slider container
    local SliderContainer = Instance.new("Frame")
    local SliderFrame = Instance.new("Frame")
    local SliderUICorner = Instance.new("UICorner")
    local SliderTitle = Instance.new("TextLabel")
    local SliderValue = Instance.new("TextLabel")
    local SliderBarContainer = Instance.new("Frame")
    local SliderBarContainerUICorner = Instance.new("UICorner")
    local SliderBar = Instance.new("Frame")
    local SliderBarUICorner = Instance.new("UICorner")
    local SliderClick = Instance.new("TextButton")
    
    SliderContainer.Name = "SliderContainer_" .. config.Name
    SliderContainer.BackgroundTransparency = 1
    SliderContainer.Size = UDim2.new(1, 0, 0, 50)
    SliderContainer.Parent = parent
    
    SliderFrame.Name = "SliderFrame"
    SliderFrame.BackgroundColor3 = library.SelectedTheme.ElementBackground
    SliderFrame.Size = UDim2.new(1, 0, 1, 0)
    SliderFrame.Parent = SliderContainer
    
    SliderUICorner.CornerRadius = UDim.new(0, 5)
    SliderUICorner.Parent = SliderFrame
    
    SliderTitle.Name = "SliderTitle"
    SliderTitle.BackgroundTransparency = 1
    SliderTitle.Position = UDim2.new(0, 10, 0, 0)
    SliderTitle.Size = UDim2.new(1, -20, 0, 30)
    SliderTitle.Font = Enum.Font.GothamSemibold
    SliderTitle.Text = config.Name
    SliderTitle.TextColor3 = library.SelectedTheme.TextColor
    SliderTitle.TextSize = 14
    SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
    SliderTitle.Parent = SliderFrame
    
    SliderValue.Name = "SliderValue"
    SliderValue.BackgroundTransparency = 1
    SliderValue.Position = UDim2.new(1, -60, 0, 0)
    SliderValue.Size = UDim2.new(0, 50, 0, 30)
    SliderValue.Font = Enum.Font.GothamSemibold
    SliderValue.Text = tostring(config.Default) .. config.ValueSuffix
    SliderValue.TextColor3 = library.SelectedTheme.TextColor
    SliderValue.TextSize = 14
    SliderValue.TextXAlignment = Enum.TextXAlignment.Right
    SliderValue.Parent = SliderFrame
    
    SliderBarContainer.Name = "SliderBarContainer"
    SliderBarContainer.BackgroundColor3 = library.SelectedTheme.SliderBackground
    SliderBarContainer.Position = UDim2.new(0, 10, 0, 32)
    SliderBarContainer.Size = UDim2.new(1, -20, 0, 10)
    SliderBarContainer.Parent = SliderFrame
    
    SliderBarContainerUICorner.CornerRadius = UDim.new(0, 5)
    SliderBarContainerUICorner.Parent = SliderBarContainer
    
    SliderBar.Name = "SliderBar"
    SliderBar.BackgroundColor3 = library.SelectedTheme.SliderFill
    SliderBar.Size = UDim2.new(0, 0, 1, 0)
    SliderBar.Parent = SliderBarContainer
    
    SliderBarUICorner.CornerRadius = UDim.new(0, 5)
    SliderBarUICorner.Parent = SliderBar
    
    SliderClick.Name = "SliderClick"
    SliderClick.BackgroundTransparency = 1
    SliderClick.Size = UDim2.new(1, 0, 1, 0)
    SliderClick.Text = ""
    SliderClick.Parent = SliderBarContainer
    
    -- Add description if provided
    if config.Description then
        SliderContainer.Size = UDim2.new(1, 0, 0, 70)
        
        local SliderDescription = Instance.new("TextLabel")
        SliderDescription.Name = "SliderDescription"
        SliderDescription.BackgroundTransparency = 1
        SliderDescription.Position = UDim2.new(0, 10, 0, 46)
        SliderDescription.Size = UDim2.new(1, -20, 0, 20)
        SliderDescription.Font = Enum.Font.Gotham
        SliderDescription.Text = config.Description
        SliderDescription.TextColor3 = library.SelectedTheme.SubTextColor
        SliderDescription.TextSize = 12
        SliderDescription.TextWrapped = true
        SliderDescription.TextXAlignment = Enum.TextXAlignment.Left
        SliderDescription.Parent = SliderFrame
    end
    
    -- Slider variables
    local value = config.Default
    library.Flags[config.Flag] = value
    
    -- Function to update slider value
    local function updateSlider(input)
        local sizeX = math.clamp((input.Position.X - SliderBarContainer.AbsolutePosition.X) / SliderBarContainer.AbsoluteSize.X, 0, 1)
        
        -- Calculate value based on size and range
        local newValue = math.floor((((config.Max - config.Min) * sizeX) + config.Min) / config.Increment + 0.5) * config.Increment
        newValue = math.clamp(newValue, config.Min, config.Max)
        
        -- Round to avoid floating point issues
        if config.Increment == 1 then
            newValue = math.floor(newValue)
        else
            newValue = math.floor(newValue * 100) / 100
        end
        
        -- Update UI
        SliderBar.Size = UDim2.new(sizeX, 0, 1, 0)
        SliderValue.Text = tostring(newValue) .. config.ValueSuffix
        
        -- Update value and call callback if changed
        if value ~= newValue then
            value = newValue
            library.Flags[config.Flag] = value
            pcall(config.Callback, value)
        end
    end
    
    -- Set default value
    SliderBar.Size = UDim2.new((config.Default - config.Min) / (config.Max - config.Min), 0, 1, 0)
    
    -- Slider input handlers
    local dragging = false
    
    SliderClick.MouseButton1Down:Connect(function()
        dragging = true
        updateSlider(game:GetService("UserInputService"):GetMouseLocation())
    end)
    
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)
    
    -- Slider hover effect
    SliderFrame.MouseEnter:Connect(function()
        library.Utils.Tween.Create(SliderFrame, 0.2, {
            BackgroundColor3 = library.SelectedTheme.ElementBackgroundHover
        })
    end)
    
    SliderFrame.MouseLeave:Connect(function()
        library.Utils.Tween.Create(SliderFrame, 0.2, {
            BackgroundColor3 = library.SelectedTheme.ElementBackground
        })
    end)
    
    -- Slider methods
    local slider = {
        Instance = SliderContainer,
        SliderFrame = SliderFrame,
        Title = SliderTitle,
        Value = value
    }
    
    -- Set slider value
    function slider:Set(newValue)
        newValue = math.clamp(newValue, config.Min, config.Max)
        
        if config.Increment ~= 1 then
            newValue = math.floor(newValue / config.Increment + 0.5) * config.Increment
            newValue = math.floor(newValue * 100) / 100
        else
            newValue = math.floor(newValue)
        end
        
        value = newValue
        library.Flags[config.Flag] = value
        
        local sizeX = (value - config.Min) / (config.Max - config.Min)
        SliderBar.Size = UDim2.new(sizeX, 0, 1, 0)
        SliderValue.Text = tostring(value) .. config.ValueSuffix
        
        pcall(config.Callback, value)
    end
    
    -- Get slider value
    function slider:Get()
        return value
    end
    
    -- Change slider text
    function slider:SetText(text)
        SliderTitle.Text = text
    end
    
    -- Update slider callback
    function slider:SetCallback(callback)
        config.Callback = callback
    end
    
    return slider
end

return Slider
