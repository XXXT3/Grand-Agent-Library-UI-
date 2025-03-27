--[[
    Dropdown Element for Luminous UI Library
    
    Creates dropdown selection elements with customizable options and callbacks
]]

local Dropdown = {}

function Dropdown.Create(library, parent, config)
    config = config or {}
    config.Name = config.Name or "Dropdown"
    config.Options = config.Options or {}
    config.Default = config.Default or nil
    config.Flag = config.Flag or config.Name
    config.Callback = config.Callback or function() end
    config.Description = config.Description or nil
    config.MultiSelect = config.MultiSelect or false
    
    -- Create dropdown container
    local DropdownContainer = Instance.new("Frame")
    local DropdownFrame = Instance.new("Frame")
    local DropdownUICorner = Instance.new("UICorner")
    local DropdownTitle = Instance.new("TextLabel")
    local DropdownButton = Instance.new("Frame")
    local DropdownButtonUICorner = Instance.new("UICorner")
    local DropdownButtonText = Instance.new("TextLabel")
    local DropdownIcon = Instance.new("ImageLabel")
    local DropdownClick = Instance.new("TextButton")
    local DropdownOptionsFrame = Instance.new("Frame")
    local DropdownOptionsFrameUICorner = Instance.new("UICorner")
    local DropdownOptionsUIListLayout = Instance.new("UIListLayout")
    local DropdownOptionsPadding = Instance.new("UIPadding")
    
    DropdownContainer.Name = "DropdownContainer_" .. config.Name
    DropdownContainer.BackgroundTransparency = 1
    DropdownContainer.Size = UDim2.new(1, 0, 0, 40)
    DropdownContainer.ClipsDescendants = true -- For dropdown animation
    DropdownContainer.Parent = parent
    
    DropdownFrame.Name = "DropdownFrame"
    DropdownFrame.BackgroundColor3 = library.SelectedTheme.ElementBackground
    DropdownFrame.Size = UDim2.new(1, 0, 0, 40)
    DropdownFrame.Position = UDim2.new(0, 0, 0, 0)
    DropdownFrame.Parent = DropdownContainer
    
    DropdownUICorner.CornerRadius = UDim.new(0, 5)
    DropdownUICorner.Parent = DropdownFrame
    
    DropdownTitle.Name = "DropdownTitle"
    DropdownTitle.BackgroundTransparency = 1
    DropdownTitle.Position = UDim2.new(0, 10, 0, 0)
    DropdownTitle.Size = UDim2.new(0.5, -10, 1, 0)
    DropdownTitle.Font = Enum.Font.GothamSemibold
    DropdownTitle.Text = config.Name
    DropdownTitle.TextColor3 = library.SelectedTheme.TextColor
    DropdownTitle.TextSize = 14
    DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left
    DropdownTitle.Parent = DropdownFrame
    
    DropdownButton.Name = "DropdownButton"
    DropdownButton.BackgroundColor3 = library.SelectedTheme.DropdownBackground
    DropdownButton.Position = UDim2.new(0.5, 5, 0.5, -10)
    DropdownButton.Size = UDim2.new(0.5, -15, 0, 20)
    DropdownButton.Parent = DropdownFrame
    
    DropdownButtonUICorner.CornerRadius = UDim.new(0, 5)
    DropdownButtonUICorner.Parent = DropdownButton
    
    DropdownButtonText.Name = "DropdownButtonText"
    DropdownButtonText.BackgroundTransparency = 1
    DropdownButtonText.Position = UDim2.new(0, 8, 0, 0)
    DropdownButtonText.Size = UDim2.new(1, -30, 1, 0)
    DropdownButtonText.Font = Enum.Font.Gotham
    DropdownButtonText.Text = config.MultiSelect and "Select Option(s)" or "Select Option"
    DropdownButtonText.TextColor3 = library.SelectedTheme.TextColor
    DropdownButtonText.TextSize = 12
    DropdownButtonText.TextXAlignment = Enum.TextXAlignment.Left
    DropdownButtonText.TextTruncate = Enum.TextTruncate.AtEnd
    DropdownButtonText.Parent = DropdownButton
    
    DropdownIcon.Name = "DropdownIcon"
    DropdownIcon.BackgroundTransparency = 1
    DropdownIcon.Position = UDim2.new(1, -20, 0.5, -5)
    DropdownIcon.Size = UDim2.new(0, 10, 0, 10)
    DropdownIcon.Image = "rbxassetid://6031091004" -- Down arrow icon
    DropdownIcon.ImageColor3 = library.SelectedTheme.TextColor
    DropdownIcon.Parent = DropdownButton
    
    DropdownClick.Name = "DropdownClick"
    DropdownClick.BackgroundTransparency = 1
    DropdownClick.Size = UDim2.new(1, 0, 1, 0)
    DropdownClick.Text = ""
    DropdownClick.Parent = DropdownFrame
    
    DropdownOptionsFrame.Name = "DropdownOptionsFrame"
    DropdownOptionsFrame.BackgroundColor3 = library.SelectedTheme.DropdownBackground
    DropdownOptionsFrame.Position = UDim2.new(0, 0, 0, 45)
    DropdownOptionsFrame.Size = UDim2.new(1, 0, 0, 0) -- Will be resized based on content
    DropdownOptionsFrame.Visible = false
    DropdownOptionsFrame.Parent = DropdownContainer
    
    DropdownOptionsFrameUICorner.CornerRadius = UDim.new(0, 5)
    DropdownOptionsFrameUICorner.Parent = DropdownOptionsFrame
    
    DropdownOptionsUIListLayout.Name = "DropdownOptionsUIListLayout"
    DropdownOptionsUIListLayout.Padding = UDim.new(0, 5)
    DropdownOptionsUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    DropdownOptionsUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    DropdownOptionsUIListLayout.Parent = DropdownOptionsFrame
    
    DropdownOptionsPadding.Name = "DropdownOptionsPadding"
    DropdownOptionsPadding.PaddingTop = UDim.new(0, 5)
    DropdownOptionsPadding.PaddingLeft = UDim.new(0, 5)
    DropdownOptionsPadding.PaddingRight = UDim.new(0, 5)
    DropdownOptionsPadding.PaddingBottom = UDim.new(0, 5)
    DropdownOptionsPadding.Parent = DropdownOptionsFrame
    
    -- Add description if provided
    if config.Description then
        DropdownContainer.Size = UDim2.new(1, 0, 0, 60)
        DropdownFrame.Size = UDim2.new(1, 0, 0, 60)
        
        local DropdownDescription = Instance.new("TextLabel")
        DropdownDescription.Name = "DropdownDescription"
        DropdownDescription.BackgroundTransparency = 1
        DropdownDescription.Position = UDim2.new(0, 10, 0, 24)
        DropdownDescription.Size = UDim2.new(0.5, -10, 0, 20)
        DropdownDescription.Font = Enum.Font.Gotham
        DropdownDescription.Text = config.Description
        DropdownDescription.TextColor3 = library.SelectedTheme.SubTextColor
        DropdownDescription.TextSize = 12
        DropdownDescription.TextWrapped = true
        DropdownDescription.TextXAlignment = Enum.TextXAlignment.Left
        DropdownDescription.Parent = DropdownFrame
        
        DropdownOptionsFrame.Position = UDim2.new(0, 0, 0, 65)
    end
    
    -- Dropdown variables
    local opened = false
    local selected = config.MultiSelect and {} or nil
    library.Flags[config.Flag] = selected
    
    -- Create option elements
    local optionInstances = {}
    
    -- Function to create option buttons
    local function createOptions()
        -- Clear existing options
        for _, option in pairs(optionInstances) do
            option:Destroy()
        end
        optionInstances = {}
        
        -- Create new options
        for i, optionName in ipairs(config.Options) do
            -- Create option button
            local OptionButton = Instance.new("TextButton")
            local OptionButtonUICorner = Instance.new("UICorner")
            
            OptionButton.Name = "OptionButton_" .. optionName
            OptionButton.BackgroundColor3 = library.SelectedTheme.ElementBackground
            OptionButton.Size = UDim2.new(1, -10, 0, 30)
            OptionButton.Font = Enum.Font.Gotham
            OptionButton.Text = optionName
            OptionButton.TextColor3 = library.SelectedTheme.TextColor
            OptionButton.TextSize = 14
            OptionButton.Parent = DropdownOptionsFrame
            
            OptionButtonUICorner.CornerRadius = UDim.new(0, 5)
            OptionButtonUICorner.Parent = OptionButton
            
            -- Highlight selected option
            if config.MultiSelect then
                if table.find(selected, optionName) then
                    OptionButton.BackgroundColor3 = library.SelectedTheme.ElementBackgroundHover
                end
            else
                if selected == optionName then
                    OptionButton.BackgroundColor3 = library.SelectedTheme.ElementBackgroundHover
                end
            end
            
            -- Option hover effect
            OptionButton.MouseEnter:Connect(function()
                if config.MultiSelect then
                    if not table.find(selected, optionName) then
                        library.Utils.Tween.Create(OptionButton, 0.2, {
                            BackgroundColor3 = library.SelectedTheme.ElementBackgroundHover
                        })
                    end
                else
                    if selected ~= optionName then
                        library.Utils.Tween.Create(OptionButton, 0.2, {
                            BackgroundColor3 = library.SelectedTheme.ElementBackgroundHover
                        })
                    end
                end
            end)
            
            OptionButton.MouseLeave:Connect(function()
                if config.MultiSelect then
                    if not table.find(selected, optionName) then
                        library.Utils.Tween.Create(OptionButton, 0.2, {
                            BackgroundColor3 = library.SelectedTheme.ElementBackground
                        })
                    end
                else
                    if selected ~= optionName then
                        library.Utils.Tween.Create(OptionButton, 0.2, {
                            BackgroundColor3 = library.SelectedTheme.ElementBackground
                        })
                    end
                end
            end)
            
            -- Option click handler
            OptionButton.MouseButton1Click:Connect(function()
                if config.MultiSelect then
                    -- Toggle selection
                    if table.find(selected, optionName) then
                        table.remove(selected, table.find(selected, optionName))
                        library.Utils.Tween.Create(OptionButton, 0.2, {
                            BackgroundColor3 = library.SelectedTheme.ElementBackground
                        })
                    else
                        table.insert(selected, optionName)
                        library.Utils.Tween.Create(OptionButton, 0.2, {
                            BackgroundColor3 = library.SelectedTheme.ElementBackgroundHover
                        })
                    end
                    
                    -- Update text
                    if #selected == 0 then
                        DropdownButtonText.Text = "Select Option(s)"
                    else
                        DropdownButtonText.Text = table.concat(selected, ", ")
                    end
                else
                    -- Single selection
                    selected = optionName
                    
                    -- Update all option buttons
                    for _, option in pairs(optionInstances) do
                        library.Utils.Tween.Create(option, 0.2, {
                            BackgroundColor3 = library.SelectedTheme.ElementBackground
                        })
                    end
                    
                    library.Utils.Tween.Create(OptionButton, 0.2, {
                        BackgroundColor3 = library.SelectedTheme.ElementBackgroundHover
                    })
                    
                    -- Update text
                    DropdownButtonText.Text = selected
                    
                    -- Close dropdown after selection for single select
                    toggleDropdown()
                end
                
                -- Update flag and call callback
                library.Flags[config.Flag] = selected
                pcall(config.Callback, selected)
            end)
            
            table.insert(optionInstances, OptionButton)
        end
        
        -- Resize options frame based on content
        DropdownOptionsFrame.Size = UDim2.new(1, 0, 0, DropdownOptionsUIListLayout.AbsoluteContentSize.Y + 10)
    end
    
    -- Function to toggle dropdown
    local function toggleDropdown()
        opened = not opened
        
        if opened then
            -- Show options
            DropdownOptionsFrame.Visible = true
            DropdownContainer.Size = UDim2.new(1, 0, 0, DropdownFrame.Size.Y.Offset + DropdownOptionsFrame.Size.Y.Offset + 5)
            
            -- Rotate arrow icon
            library.Utils.Tween.Create(DropdownIcon, 0.2, {
                Rotation = 180
            })
        else
            -- Hide options
            local originalSize = config.Description and UDim2.new(1, 0, 0, 60) or UDim2.new(1, 0, 0, 40)
            DropdownContainer.Size = originalSize
            
            -- Rotate arrow icon back
            library.Utils.Tween.Create(DropdownIcon, 0.2, {
                Rotation = 0
            })
            
            -- Delay hiding the options frame to allow animation to complete
            task.delay(0.2, function()
                if not opened then
                    DropdownOptionsFrame.Visible = false
                end
            end)
        end
    end
    
    -- Create options and set default value
    createOptions()
    
    if config.Default then
        if config.MultiSelect then
            if type(config.Default) == "table" then
                -- Set multiple default values
                for _, defaultOption in ipairs(config.Default) do
                    if table.find(config.Options, defaultOption) and not table.find(selected, defaultOption) then
                        table.insert(selected, defaultOption)
                    end
                end
                
                if #selected > 0 then
                    DropdownButtonText.Text = table.concat(selected, ", ")
                end
            end
        else
            -- Set single default value
            if table.find(config.Options, config.Default) then
                selected = config.Default
                DropdownButtonText.Text = selected
            end
        end
        
        library.Flags[config.Flag] = selected
    end
    
    -- Dropdown click handler
    DropdownClick.MouseButton1Click:Connect(toggleDropdown)
    
    -- Dropdown hover effect
    DropdownClick.MouseEnter:Connect(function()
        library.Utils.Tween.Create(DropdownFrame, 0.2, {
            BackgroundColor3 = library.SelectedTheme.ElementBackgroundHover
        })
    end)
    
    DropdownClick.MouseLeave:Connect(function()
        library.Utils.Tween.Create(DropdownFrame, 0.2, {
            BackgroundColor3 = library.SelectedTheme.ElementBackground
        })
    end)
    
    -- Dropdown methods
    local dropdown = {
        Instance = DropdownContainer,
        DropdownFrame = DropdownFrame,
        Title = DropdownTitle,
        Selected = selected,
        Options = config.Options
    }
    
    -- Manually set selected value(s)
    function dropdown:Set(newValue)
        if config.MultiSelect then
            if type(newValue) == "table" then
                -- Clear current selection
                selected = {}
                
                -- Set new values
                for _, value in ipairs(newValue) do
                    if table.find(config.Options, value) then
                        table.insert(selected, value)
                    end
                end
                
                -- Update text
                if #selected == 0 then
                    DropdownButtonText.Text = "Select Option(s)"
                else
                    DropdownButtonText.Text = table.concat(selected, ", ")
                end
            end
        else
            if table.find(config.Options, newValue) then
                selected = newValue
                DropdownButtonText.Text = selected
            end
        end
        
        -- Update flag and call callback
        dropdown.Selected = selected
        library.Flags[config.Flag] = selected
        pcall(config.Callback, selected)
        
        -- Refresh option instances to reflect changes
        createOptions()
    end
    
    -- Get current value(s)
    function dropdown:Get()
        return selected
    end
    
    -- Change options
    function dropdown:SetOptions(newOptions)
        config.Options = newOptions
        
        -- Clear selection if selected value is no longer in options
        if config.MultiSelect then
            local newSelected = {}
            for _, option in ipairs(selected) do
                if table.find(newOptions, option) then
                    table.insert(newSelected, option)
                end
            end
            selected = newSelected
            
            -- Update text
            if #selected == 0 then
                DropdownButtonText.Text = "Select Option(s)"
            else
                DropdownButtonText.Text = table.concat(selected, ", ")
            end
        else
            if not table.find(newOptions, selected) then
                selected = nil
                DropdownButtonText.Text = "Select Option"
            end
        end
        
        dropdown.Options = newOptions
        dropdown.Selected = selected
        library.Flags[config.Flag] = selected
        
        -- Recreate option instances
        createOptions()
    end
    
    -- Change dropdown text
    function dropdown:SetText(text)
        DropdownTitle.Text = text
    end
    
    -- Update dropdown callback
    function dropdown:SetCallback(callback)
        config.Callback = callback
    end
    
    return dropdown
end

return Dropdown
