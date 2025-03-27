--[[
    TextBox Element for Luminous UI Library
    
    Creates text input elements with customizable validation and callbacks
]]

local TextBox = {}

function TextBox.Create(library, parent, config)
    config = config or {}
    config.Name = config.Name or "TextBox"
    config.PlaceholderText = config.PlaceholderText or "Enter text..."
    config.Default = config.Default or ""
    config.Flag = config.Flag or config.Name
    config.Callback = config.Callback or function() end
    config.Description = config.Description or nil
    config.ClearTextOnFocus = config.ClearTextOnFocus == nil and true or config.ClearTextOnFocus
    config.TextScaled = config.TextScaled or false
    
    -- Create textbox container
    local TextBoxContainer = Instance.new("Frame")
    local TextBoxFrame = Instance.new("Frame")
    local TextBoxUICorner = Instance.new("UICorner")
    local TextBoxTitle = Instance.new("TextLabel")
    local TextBoxInput = Instance.new("TextBox")
    local TextBoxInputUICorner = Instance.new("UICorner")
    
    TextBoxContainer.Name = "TextBoxContainer_" .. config.Name
    TextBoxContainer.BackgroundTransparency = 1
    TextBoxContainer.Size = UDim2.new(1, 0, 0, 40)
    TextBoxContainer.Parent = parent
    
    TextBoxFrame.Name = "TextBoxFrame"
    TextBoxFrame.BackgroundColor3 = library.SelectedTheme.ElementBackground
    TextBoxFrame.Size = UDim2.new(1, 0, 1, 0)
    TextBoxFrame.Parent = TextBoxContainer
    
    TextBoxUICorner.CornerRadius = UDim.new(0, 5)
    TextBoxUICorner.Parent = TextBoxFrame
    
    TextBoxTitle.Name = "TextBoxTitle"
    TextBoxTitle.BackgroundTransparency = 1
    TextBoxTitle.Position = UDim2.new(0, 10, 0, 0)
    TextBoxTitle.Size = UDim2.new(0.5, -10, 1, 0)
    TextBoxTitle.Font = Enum.Font.GothamSemibold
    TextBoxTitle.Text = config.Name
    TextBoxTitle.TextColor3 = library.SelectedTheme.TextColor
    TextBoxTitle.TextSize = 14
    TextBoxTitle.TextXAlignment = Enum.TextXAlignment.Left
    TextBoxTitle.Parent = TextBoxFrame
    
    TextBoxInput.Name = "TextBoxInput"
    TextBoxInput.BackgroundColor3 = library.SelectedTheme.InputBackground
    TextBoxInput.Position = UDim2.new(0.5, 5, 0.5, -10)
    TextBoxInput.Size = UDim2.new(0.5, -15, 0, 20)
    TextBoxInput.Font = Enum.Font.Gotham
    TextBoxInput.PlaceholderText = config.PlaceholderText
    TextBoxInput.PlaceholderColor3 = library.SelectedTheme.InputPlaceholder
    TextBoxInput.Text = config.Default
    TextBoxInput.TextColor3 = library.SelectedTheme.TextColor
    TextBoxInput.TextSize = 12
    TextBoxInput.TextWrapped = true
    TextBoxInput.TextScaled = config.TextScaled
    TextBoxInput.ClearTextOnFocus = config.ClearTextOnFocus
    TextBoxInput.Parent = TextBoxFrame
    
    TextBoxInputUICorner.CornerRadius = UDim.new(0, 5)
    TextBoxInputUICorner.Parent = TextBoxInput
    
    -- Add description if provided
    if config.Description then
        TextBoxContainer.Size = UDim2.new(1, 0, 0, 60)
        
        local TextBoxDescription = Instance.new("TextLabel")
        TextBoxDescription.Name = "TextBoxDescription"
        TextBoxDescription.BackgroundTransparency = 1
        TextBoxDescription.Position = UDim2.new(0, 10, 0, 24)
        TextBoxDescription.Size = UDim2.new(0.5, -10, 0, 20)
        TextBoxDescription.Font = Enum.Font.Gotham
        TextBoxDescription.Text = config.Description
        TextBoxDescription.TextColor3 = library.SelectedTheme.SubTextColor
        TextBoxDescription.TextSize = 12
        TextBoxDescription.TextWrapped = true
        TextBoxDescription.TextXAlignment = Enum.TextXAlignment.Left
        TextBoxDescription.Parent = TextBoxFrame
    end
    
    -- TextBox variables
    local text = config.Default
    library.Flags[config.Flag] = text
    
    -- TextBox focus/unfocus effects
    TextBoxInput.Focused:Connect(function()
        library.Utils.Tween.Create(TextBoxInput, 0.2, {
            BackgroundColor3 = library.SelectedTheme.InputBackgroundFocused
        })
    end)
    
    TextBoxInput.FocusLost:Connect(function(enterPressed)
        library.Utils.Tween.Create(TextBoxInput, 0.2, {
            BackgroundColor3 = library.SelectedTheme.InputBackground
        })
        
        if text ~= TextBoxInput.Text then
            text = TextBoxInput.Text
            library.Flags[config.Flag] = text
            pcall(config.Callback, text, enterPressed)
        end
    end)
    
    -- TextBox hover effect
    TextBoxFrame.MouseEnter:Connect(function()
        library.Utils.Tween.Create(TextBoxFrame, 0.2, {
            BackgroundColor3 = library.SelectedTheme.ElementBackgroundHover
        })
    end)
    
    TextBoxFrame.MouseLeave:Connect(function()
        library.Utils.Tween.Create(TextBoxFrame, 0.2, {
            BackgroundColor3 = library.SelectedTheme.ElementBackground
        })
    end)
    
    -- TextBox methods
    local textbox = {
        Instance = TextBoxContainer,
        TextBoxFrame = TextBoxFrame,
        Title = TextBoxTitle,
        Input = TextBoxInput,
        Text = text
    }
    
    -- Set textbox text
    function textbox:Set(newText)
        text = tostring(newText)
        TextBoxInput.Text = text
        library.Flags[config.Flag] = text
        pcall(config.Callback, text, false)
    end
    
    -- Get textbox text
    function textbox:Get()
        return text
    end
    
    -- Change textbox title
    function textbox:SetTitle(title)
        TextBoxTitle.Text = title
    end
    
    -- Change placeholder text
    function textbox:SetPlaceholder(placeholder)
        TextBoxInput.PlaceholderText = placeholder
    end
    
    -- Update textbox callback
    function textbox:SetCallback(callback)
        config.Callback = callback
    end
    
    return textbox
end

return TextBox
