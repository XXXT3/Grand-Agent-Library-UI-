--[[
    Button Element for Luminous UI Library
    
    Creates interactive button elements with customizable appearance and callbacks
]]

local Button = {}

function Button.Create(library, parent, config)
    config = config or {}
    config.Name = config.Name or "Button"
    config.Callback = config.Callback or function() end
    config.Icon = config.Icon or nil
    config.Description = config.Description or nil
    
    -- Create button container
    local ButtonContainer = Instance.new("Frame")
    local ButtonFrame = Instance.new("Frame")
    local ButtonUICorner = Instance.new("UICorner")
    local ButtonTitle = Instance.new("TextLabel")
    local ButtonClick = Instance.new("TextButton")
    
    ButtonContainer.Name = "ButtonContainer_" .. config.Name
    ButtonContainer.BackgroundTransparency = 1
    ButtonContainer.Size = UDim2.new(1, 0, 0, 40)
    ButtonContainer.Parent = parent
    
    ButtonFrame.Name = "ButtonFrame"
    ButtonFrame.BackgroundColor3 = library.SelectedTheme.ElementBackground
    ButtonFrame.Size = UDim2.new(1, 0, 1, 0)
    ButtonFrame.Parent = ButtonContainer
    
    ButtonUICorner.CornerRadius = UDim.new(0, 5)
    ButtonUICorner.Parent = ButtonFrame
    
    ButtonTitle.Name = "ButtonTitle"
    ButtonTitle.BackgroundTransparency = 1
    ButtonTitle.Position = UDim2.new(0, 10, 0, 0)
    ButtonTitle.Size = UDim2.new(1, -20, 1, 0)
    ButtonTitle.Font = Enum.Font.GothamSemibold
    ButtonTitle.Text = config.Name
    ButtonTitle.TextColor3 = library.SelectedTheme.TextColor
    ButtonTitle.TextSize = 14
    ButtonTitle.TextXAlignment = Enum.TextXAlignment.Left
    ButtonTitle.Parent = ButtonFrame
    
    ButtonClick.Name = "ButtonClick"
    ButtonClick.BackgroundTransparency = 1
    ButtonClick.Size = UDim2.new(1, 0, 1, 0)
    ButtonClick.Font = Enum.Font.SourceSans
    ButtonClick.Text = ""
    ButtonClick.TextColor3 = Color3.fromRGB(0, 0, 0)
    ButtonClick.TextSize = 14
    ButtonClick.Parent = ButtonFrame
    
    -- Add icon if provided
    if config.Icon then
        local ButtonIcon = Instance.new("ImageLabel")
        ButtonIcon.Name = "ButtonIcon"
        ButtonIcon.BackgroundTransparency = 1
        ButtonIcon.Position = UDim2.new(0, 10, 0.5, -10)
        ButtonIcon.Size = UDim2.new(0, 20, 0, 20)
        ButtonIcon.Image = config.Icon
        ButtonIcon.ImageColor3 = library.SelectedTheme.TextColor
        ButtonIcon.Parent = ButtonFrame
        
        ButtonTitle.Position = UDim2.new(0, 40, 0, 0)
        ButtonTitle.Size = UDim2.new(1, -50, 1, 0)
    end
    
    -- Add description if provided
    if config.Description then
        ButtonContainer.Size = UDim2.new(1, 0, 0, 60)
        
        local ButtonDescription = Instance.new("TextLabel")
        ButtonDescription.Name = "ButtonDescription"
        ButtonDescription.BackgroundTransparency = 1
        ButtonDescription.Position = UDim2.new(0, 10, 0, 24)
        ButtonDescription.Size = UDim2.new(1, -20, 0, 20)
        ButtonDescription.Font = Enum.Font.Gotham
        ButtonDescription.Text = config.Description
        ButtonDescription.TextColor3 = library.SelectedTheme.SubTextColor
        ButtonDescription.TextSize = 12
        ButtonDescription.TextWrapped = true
        ButtonDescription.TextXAlignment = Enum.TextXAlignment.Left
        ButtonDescription.Parent = ButtonFrame
        
        if config.Icon then
            ButtonDescription.Position = UDim2.new(0, 40, 0, 24)
            ButtonDescription.Size = UDim2.new(1, -50, 0, 20)
        end
    end
    
    -- Button click animation and callback
    ButtonClick.MouseButton1Click:Connect(function()
        -- Button press animation
        library.Utils.Tween.Create(ButtonFrame, 0.1, {
            BackgroundColor3 = library.SelectedTheme.ElementBackgroundHover
        })
        
        task.delay(0.1, function()
            library.Utils.Tween.Create(ButtonFrame, 0.1, {
                BackgroundColor3 = library.SelectedTheme.ElementBackground
            })
        end)
        
        -- Call the callback function
        pcall(config.Callback)
    end)
    
    -- Button hover effect
    ButtonClick.MouseEnter:Connect(function()
        library.Utils.Tween.Create(ButtonFrame, 0.2, {
            BackgroundColor3 = library.SelectedTheme.ElementBackgroundHover
        })
    end)
    
    ButtonClick.MouseLeave:Connect(function()
        library.Utils.Tween.Create(ButtonFrame, 0.2, {
            BackgroundColor3 = library.SelectedTheme.ElementBackground
        })
    end)
    
    -- Button methods
    local button = {
        Instance = ButtonContainer,
        ButtonFrame = ButtonFrame,
        Title = ButtonTitle
    }
    
    -- Change button text
    function button:SetText(text)
        ButtonTitle.Text = text
    end
    
    -- Update button callback
    function button:SetCallback(callback)
        config.Callback = callback
    end
    
    return button
end

return Button
