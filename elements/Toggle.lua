--[[
    Toggle Element for Luminous UI Library
    
    Creates toggleable switch elements with customizable appearance and callbacks
]]

local Toggle = {}

function Toggle.Create(library, parent, config)
    config = config or {}
    config.Name = config.Name or "Toggle"
    config.Default = config.Default or false
    config.Flag = config.Flag or config.Name
    config.Callback = config.Callback or function() end
    config.Description = config.Description or nil
    
    -- Create toggle container
    local ToggleContainer = Instance.new("Frame")
    local ToggleFrame = Instance.new("Frame")
    local ToggleUICorner = Instance.new("UICorner")
    local ToggleTitle = Instance.new("TextLabel")
    local ToggleButton = Instance.new("Frame")
    local ToggleButtonUICorner = Instance.new("UICorner")
    local ToggleSwitch = Instance.new("Frame")
    local ToggleSwitchUICorner = Instance.new("UICorner")
    local ToggleClick = Instance.new("TextButton")
    
    ToggleContainer.Name = "ToggleContainer_" .. config.Name
    ToggleContainer.BackgroundTransparency = 1
    ToggleContainer.Size = UDim2.new(1, 0, 0, 40)
    ToggleContainer.Parent = parent
    
    ToggleFrame.Name = "ToggleFrame"
    ToggleFrame.BackgroundColor3 = library.SelectedTheme.ElementBackground
    ToggleFrame.Size = UDim2.new(1, 0, 1, 0)
    ToggleFrame.Parent = ToggleContainer
    
    ToggleUICorner.CornerRadius = UDim.new(0, 5)
    ToggleUICorner.Parent = ToggleFrame
    
    ToggleTitle.Name = "ToggleTitle"
    ToggleTitle.BackgroundTransparency = 1
    ToggleTitle.Position = UDim2.new(0, 10, 0, 0)
    ToggleTitle.Size = UDim2.new(1, -60, 1, 0)
    ToggleTitle.Font = Enum.Font.GothamSemibold
    ToggleTitle.Text = config.Name
    ToggleTitle.TextColor3 = library.SelectedTheme.TextColor
    ToggleTitle.TextSize = 14
    ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
    ToggleTitle.Parent = ToggleFrame
    
    ToggleButton.Name = "ToggleButton"
    ToggleButton.BackgroundColor3 = library.SelectedTheme.ToggleBackground
    ToggleButton.Position = UDim2.new(1, -50, 0.5, -10)
    ToggleButton.Size = UDim2.new(0, 40, 0, 20)
    ToggleButton.Parent = ToggleFrame
    
    ToggleButtonUICorner.CornerRadius = UDim.new(0, 10)
    ToggleButtonUICorner.Parent = ToggleButton
    
    ToggleSwitch.Name = "ToggleSwitch"
    ToggleSwitch.BackgroundColor3 = library.SelectedTheme.ToggleSwitch
    ToggleSwitch.Position = UDim2.new(0, 2, 0.5, -8)
    ToggleSwitch.Size = UDim2.new(0, 16, 0, 16)
    ToggleSwitch.Parent = ToggleButton
    
    ToggleSwitchUICorner.CornerRadius = UDim.new(1, 0)
    ToggleSwitchUICorner.Parent = ToggleSwitch
    
    ToggleClick.Name = "ToggleClick"
    ToggleClick.BackgroundTransparency = 1
    ToggleClick.Size = UDim2.new(1, 0, 1, 0)
    ToggleClick.Font = Enum.Font.SourceSans
    ToggleClick.Text = ""
    ToggleClick.TextColor3 = Color3.fromRGB(0, 0, 0)
    ToggleClick.TextSize = 14
    ToggleClick.Parent = ToggleFrame
    
    -- Add description if provided
    if config.Description then
        ToggleContainer.Size = UDim2.new(1, 0, 0, 60)
        
        local ToggleDescription = Instance.new("TextLabel")
        ToggleDescription.Name = "ToggleDescription"
        ToggleDescription.BackgroundTransparency = 1
        ToggleDescription.Position = UDim2.new(0, 10, 0, 24)
        ToggleDescription.Size = UDim2.new(1, -60, 0, 20)
        ToggleDescription.Font = Enum.Font.Gotham
        ToggleDescription.Text = config.Description
        ToggleDescription.TextColor3 = library.SelectedTheme.SubTextColor
        ToggleDescription.TextSize = 12
        ToggleDescription.TextWrapped = true
        ToggleDescription.TextXAlignment = Enum.TextXAlignment.Left
        ToggleDescription.Parent = ToggleFrame
    end
    
    -- Toggle state variables
    local toggled = config.Default
    library.Flags[config.Flag] = toggled
    
    -- Function to update toggle state
    local function updateToggle()
        toggled = not toggled
        library.Flags[config.Flag] = toggled
        
        if toggled then
            library.Utils.Tween.Create(ToggleButton, 0.2, {
                BackgroundColor3 = library.SelectedTheme.ToggleBackgroundEnabled
            })
            
            library.Utils.Tween.Create(ToggleSwitch, 0.2, {
                Position = UDim2.new(1, -18, 0.5, -8)
            })
        else
            library.Utils.Tween.Create(ToggleButton, 0.2, {
                BackgroundColor3 = library.SelectedTheme.ToggleBackground
            })
            
            library.Utils.Tween.Create(ToggleSwitch, 0.2, {
                Position = UDim2.new(0, 2, 0.5, -8)
            })
        end
        
        -- Call the callback function
        pcall(config.Callback, toggled)
    end
    
    -- Set default state
    if config.Default then
        updateToggle()
        updateToggle() -- Toggle twice to get to the correct state with the right animation
    end
    
    -- Toggle click handler
    ToggleClick.MouseButton1Click:Connect(updateToggle)
    
    -- Toggle hover effect
    ToggleClick.MouseEnter:Connect(function()
        library.Utils.Tween.Create(ToggleFrame, 0.2, {
            BackgroundColor3 = library.SelectedTheme.ElementBackgroundHover
        })
    end)
    
    ToggleClick.MouseLeave:Connect(function()
        library.Utils.Tween.Create(ToggleFrame, 0.2, {
            BackgroundColor3 = library.SelectedTheme.ElementBackground
        })
    end)
    
    -- Toggle methods
    local toggle = {
        Instance = ToggleContainer,
        ToggleFrame = ToggleFrame,
        Title = ToggleTitle,
        Toggled = toggled
    }
    
    -- Set toggle state
    function toggle:Set(state)
        if toggled ~= state then
            updateToggle()
        end
    end
    
    -- Get toggle state
    function toggle:Get()
        return toggled
    end
    
    -- Change toggle text
    function toggle:SetText(text)
        ToggleTitle.Text = text
    end
    
    -- Update toggle callback
    function toggle:SetCallback(callback)
        config.Callback = callback
    end
    
    return toggle
end

return Toggle
