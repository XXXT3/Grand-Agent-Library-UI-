--[[
    ColorPicker Element for Luminous UI Library
    
    Creates color picker elements with customizable defaults and callbacks
]]

local ColorPicker = {}

function ColorPicker.Create(library, parent, config)
    config = config or {}
    config.Name = config.Name or "ColorPicker"
    config.Default = config.Default or Color3.fromRGB(255, 255, 255)
    config.Flag = config.Flag or config.Name
    config.Callback = config.Callback or function() end
    config.Description = config.Description or nil
    config.Alpha = config.Alpha or false
    
    -- Create color picker container
    local ColorPickerContainer = Instance.new("Frame")
    local ColorPickerFrame = Instance.new("Frame")
    local ColorPickerUICorner = Instance.new("UICorner")
    local ColorPickerTitle = Instance.new("TextLabel")
    local ColorPreview = Instance.new("Frame")
    local ColorPreviewUICorner = Instance.new("UICorner")
    local ColorPickerButton = Instance.new("TextButton")
    local ColorPickerPanel = Instance.new("Frame")
    local ColorPickerPanelUICorner = Instance.new("UICorner")
    local HueFrame = Instance.new("Frame")
    local HueFrameUICorner = Instance.new("UICorner")
    local HueSlider = Instance.new("ImageButton")
    local SatValFrame = Instance.new("Frame")
    local SatValFrameUICorner = Instance.new("UICorner")
    local SatValSlider = Instance.new("ImageButton")
    local AlphaFrame = Instance.new("Frame")
    local AlphaFrameUICorner = Instance.new("UICorner")
    local AlphaSlider = Instance.new("ImageButton")
    local ColorInfoFrame = Instance.new("Frame")
    local RgbInput = Instance.new("TextBox")
    local HexInput = Instance.new("TextBox")
    local ApplyButton = Instance.new("TextButton")
    local ApplyButtonUICorner = Instance.new("UICorner")
    
    ColorPickerContainer.Name = "ColorPickerContainer_" .. config.Name
    ColorPickerContainer.BackgroundTransparency = 1
    ColorPickerContainer.Size = UDim2.new(1, 0, 0, 40)
    ColorPickerContainer.ClipsDescendants = true -- For dropdown animation
    ColorPickerContainer.Parent = parent
    
    ColorPickerFrame.Name = "ColorPickerFrame"
    ColorPickerFrame.BackgroundColor3 = library.SelectedTheme.ElementBackground
    ColorPickerFrame.Size = UDim2.new(1, 0, 0, 40)
    ColorPickerFrame.Parent = ColorPickerContainer
    
    ColorPickerUICorner.CornerRadius = UDim.new(0, 5)
    ColorPickerUICorner.Parent = ColorPickerFrame
    
    ColorPickerTitle.Name = "ColorPickerTitle"
    ColorPickerTitle.BackgroundTransparency = 1
    ColorPickerTitle.Position = UDim2.new(0, 10, 0, 0)
    ColorPickerTitle.Size = UDim2.new(1, -60, 1, 0)
    ColorPickerTitle.Font = Enum.Font.GothamSemibold
    ColorPickerTitle.Text = config.Name
    ColorPickerTitle.TextColor3 = library.SelectedTheme.TextColor
    ColorPickerTitle.TextSize = 14
    ColorPickerTitle.TextXAlignment = Enum.TextXAlignment.Left
    ColorPickerTitle.Parent = ColorPickerFrame
    
    ColorPreview.Name = "ColorPreview"
    ColorPreview.BackgroundColor3 = config.Default
    ColorPreview.Position = UDim2.new(1, -50, 0.5, -10)
    ColorPreview.Size = UDim2.new(0, 40, 0, 20)
    ColorPreview.Parent = ColorPickerFrame
    
    ColorPreviewUICorner.CornerRadius = UDim.new(0, 5)
    ColorPreviewUICorner.Parent = ColorPreview
    
    ColorPickerButton.Name = "ColorPickerButton"
    ColorPickerButton.BackgroundTransparency = 1
    ColorPickerButton.Size = UDim2.new(1, 0, 1, 0)
    ColorPickerButton.Font = Enum.Font.SourceSans
    ColorPickerButton.Text = ""
    ColorPickerButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    ColorPickerButton.TextSize = 14
    ColorPickerButton.Parent = ColorPickerFrame
    
    -- Add description if provided
    if config.Description then
        ColorPickerContainer.Size = UDim2.new(1, 0, 0, 60)
        ColorPickerFrame.Size = UDim2.new(1, 0, 0, 60)
        
        local ColorPickerDescription = Instance.new("TextLabel")
        ColorPickerDescription.Name = "ColorPickerDescription"
        ColorPickerDescription.BackgroundTransparency = 1
        ColorPickerDescription.Position = UDim2.new(0, 10, 0, 24)
        ColorPickerDescription.Size = UDim2.new(1, -60, 0, 20)
        ColorPickerDescription.Font = Enum.Font.Gotham
        ColorPickerDescription.Text = config.Description
        ColorPickerDescription.TextColor3 = library.SelectedTheme.SubTextColor
        ColorPickerDescription.TextSize = 12
        ColorPickerDescription.TextWrapped = true
        ColorPickerDescription.TextXAlignment = Enum.TextXAlignment.Left
        ColorPickerDescription.Parent = ColorPickerFrame
    end
    
    -- Color picker panel (hidden by default)
    ColorPickerPanel.Name = "ColorPickerPanel"
    ColorPickerPanel.BackgroundColor3 = library.SelectedTheme.ElementBackground
    ColorPickerPanel.Position = UDim2.new(0, 0, 0, ColorPickerFrame.Size.Y.Offset + 5)
    ColorPickerPanel.Size = UDim2.new(1, 0, 0, 180)
    ColorPickerPanel.Visible = false
    ColorPickerPanel.ZIndex = 10
    ColorPickerPanel.Parent = ColorPickerContainer
    
    ColorPickerPanelUICorner.CornerRadius = UDim.new(0, 5)
    ColorPickerPanelUICorner.Parent = ColorPickerPanel
    
    -- Saturation-Value selector
    SatValFrame.Name = "SatValFrame"
    SatValFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Will be updated with hue
    SatValFrame.Position = UDim2.new(0, 10, 0, 10)
    SatValFrame.Size = UDim2.new(0, 160, 0, 160)
    SatValFrame.ZIndex = 11
    SatValFrame.Parent = ColorPickerPanel
    
    SatValFrameUICorner.CornerRadius = UDim.new(0, 5)
    SatValFrameUICorner.Parent = SatValFrame
    
    -- SatVal gradient
    local SatValGradient1 = Instance.new("UIGradient")
    SatValGradient1.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    }
    SatValGradient1.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 0)
    }
    SatValGradient1.Rotation = 90
    SatValGradient1.Parent = SatValFrame
    
    local SatValGradient2 = Instance.new("UIGradient")
    SatValGradient2.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
    }
    SatValGradient2.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(1, 0)
    }
    SatValGradient2.Rotation = 0
    SatValGradient2.Parent = SatValFrame
    
    SatValSlider.Name = "SatValSlider"
    SatValSlider.BackgroundTransparency = 1
    SatValSlider.Position = UDim2.new(0, 0, 0, 0)
    SatValSlider.Size = UDim2.new(1, 0, 1, 0)
    SatValSlider.ZIndex = 12
    SatValSlider.Image = "rbxassetid://4805639000"
    SatValSlider.ImageColor3 = Color3.fromRGB(255, 255, 255)
    SatValSlider.ImageTransparency = 1
    SatValSlider.Parent = SatValFrame
    
    -- Hue selector
    HueFrame.Name = "HueFrame"
    HueFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    HueFrame.Position = UDim2.new(0, 180, 0, 10)
    HueFrame.Size = UDim2.new(0, 20, 0, 160)
    HueFrame.ZIndex = 11
    HueFrame.Parent = ColorPickerPanel
    
    HueFrameUICorner.CornerRadius = UDim.new(0, 5)
    HueFrameUICorner.Parent = HueFrame
    
    -- Hue gradient
    local HueGradient = Instance.new("UIGradient")
    HueGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    }
    HueGradient.Rotation = 90
    HueGradient.Parent = HueFrame
    
    HueSlider.Name = "HueSlider"
    HueSlider.BackgroundTransparency = 1
    HueSlider.Position = UDim2.new(0, 0, 0, 0)
    HueSlider.Size = UDim2.new(1, 0, 1, 0)
    HueSlider.ZIndex = 12
    HueSlider.Image = "rbxassetid://4805639000"
    HueSlider.ImageColor3 = Color3.fromRGB(255, 255, 255)
    HueSlider.ImageTransparency = 1
    HueSlider.Parent = HueFrame
    
    -- Alpha selector (optional)
    if config.Alpha then
        AlphaFrame.Name = "AlphaFrame"
        AlphaFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        AlphaFrame.Position = UDim2.new(0, 210, 0, 10)
        AlphaFrame.Size = UDim2.new(0, 20, 0, 160)
        AlphaFrame.ZIndex = 11
        AlphaFrame.Parent = ColorPickerPanel
        
        AlphaFrameUICorner.CornerRadius = UDim.new(0, 5)
        AlphaFrameUICorner.Parent = AlphaFrame
        
        -- Alpha gradient
        local AlphaGradient = Instance.new("UIGradient")
        AlphaGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
        }
        AlphaGradient.Transparency = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(1, 1)
        }
        AlphaGradient.Rotation = 90
        AlphaGradient.Parent = AlphaFrame
        
        AlphaSlider.Name = "AlphaSlider"
        AlphaSlider.BackgroundTransparency = 1
        AlphaSlider.Position = UDim2.new(0, 0, 0, 0)
        AlphaSlider.Size = UDim2.new(1, 0, 1, 0)
        AlphaSlider.ZIndex = 12
        AlphaSlider.Image = "rbxassetid://4805639000"
        AlphaSlider.ImageColor3 = Color3.fromRGB(255, 255, 255)
        AlphaSlider.ImageTransparency = 1
        AlphaSlider.Parent = AlphaFrame
    end
    
    -- Color info display
    ColorInfoFrame.Name = "ColorInfoFrame"
    ColorInfoFrame.BackgroundTransparency = 1
    ColorInfoFrame.Position = UDim2.new(0, config.Alpha and 240 or 210, 0, 10)
    ColorInfoFrame.Size = UDim2.new(0, 150, 0, 160)
    ColorInfoFrame.ZIndex = 11
    ColorInfoFrame.Parent = ColorPickerPanel
    
    -- RGB input
    RgbInput.Name = "RgbInput"
    RgbInput.BackgroundColor3 = library.SelectedTheme.InputBackground
    RgbInput.Position = UDim2.new(0, 10, 0, 10)
    RgbInput.Size = UDim2.new(1, -20, 0, 30)
    RgbInput.ZIndex = 12
    RgbInput.Font = Enum.Font.Gotham
    RgbInput.PlaceholderText = "RGB Values"
    RgbInput.Text = tostring(math.floor(config.Default.R * 255)) .. ", " .. 
                   tostring(math.floor(config.Default.G * 255)) .. ", " .. 
                   tostring(math.floor(config.Default.B * 255))
    RgbInput.TextColor3 = library.SelectedTheme.TextColor
    RgbInput.TextSize = 14
    RgbInput.Parent = ColorInfoFrame
    
    local RgbInputUICorner = Instance.new("UICorner")
    RgbInputUICorner.CornerRadius = UDim.new(0, 5)
    RgbInputUICorner.Parent = RgbInput
    
    -- Hex input
    HexInput.Name = "HexInput"
    HexInput.BackgroundColor3 = library.SelectedTheme.InputBackground
    HexInput.Position = UDim2.new(0, 10, 0, 50)
    HexInput.Size = UDim2.new(1, -20, 0, 30)
    HexInput.ZIndex = 12
    HexInput.Font = Enum.Font.Gotham
    HexInput.PlaceholderText = "Hex Value"
    HexInput.Text = "#" .. string.format("%02X%02X%02X", 
                   math.floor(config.Default.R * 255), 
                   math.floor(config.Default.G * 255), 
                   math.floor(config.Default.B * 255))
    HexInput.TextColor3 = library.SelectedTheme.TextColor
    HexInput.TextSize = 14
    HexInput.Parent = ColorInfoFrame
    
    local HexInputUICorner = Instance.new("UICorner")
    HexInputUICorner.CornerRadius = UDim.new(0, 5)
    HexInputUICorner.Parent = HexInput
    
    -- Apply button
    ApplyButton.Name = "ApplyButton"
    ApplyButton.BackgroundColor3 = library.SelectedTheme.ButtonBackground
    ApplyButton.Position = UDim2.new(0, 10, 0, 120)
    ApplyButton.Size = UDim2.new(1, -20, 0, 30)
    ApplyButton.ZIndex = 12
    ApplyButton.Font = Enum.Font.GothamSemibold
    ApplyButton.Text = "Apply"
    ApplyButton.TextColor3 = library.SelectedTheme.TextColor
    ApplyButton.TextSize = 14
    ApplyButton.Parent = ColorInfoFrame
    
    ApplyButtonUICorner.CornerRadius = UDim.new(0, 5)
    ApplyButtonUICorner.Parent = ApplyButton
    
    -- Color picker variables
    local hue, sat, val = 0, 0, 1
    local alpha = 1
    local color = config.Default
    library.Flags[config.Flag] = color
    
    local opened = false
    
    -- Function to update UI with current color
    local function updateColor()
        -- Update color preview
        ColorPreview.BackgroundColor3 = color
        
        -- Update RGB input
        RgbInput.Text = tostring(math.floor(color.R * 255)) .. ", " .. 
                       tostring(math.floor(color.G * 255)) .. ", " .. 
                       tostring(math.floor(color.B * 255))
        
        -- Update Hex input
        HexInput.Text = "#" .. string.format("%02X%02X%02X", 
                       math.floor(color.R * 255), 
                       math.floor(color.G * 255), 
                       math.floor(color.B * 255))
    end
    
    -- Convert RGB to HSV
    local function rgbToHsv(r, g, b)
        r, g, b = r, g, b
        
        local max, min = math.max(r, g, b), math.min(r, g, b)
        local h, s, v
        v = max
        
        local d = max - min
        if max == 0 then
            s = 0
        else
            s = d / max
        end
        
        if max == min then
            h = 0
        else
            if max == r then
                h = (g - b) / d
                if g < b then h = h + 6 end
            elseif max == g then
                h = (b - r) / d + 2
            elseif max == b then
                h = (r - g) / d + 4
            end
            h = h / 6
        end
        
        return h, s, v
    end
    
    -- Convert HSV to RGB
    local function hsvToRgb(h, s, v)
        local r, g, b
        
        local i = math.floor(h * 6)
        local f = h * 6 - i
        local p = v * (1 - s)
        local q = v * (1 - f * s)
        local t = v * (1 - (1 - f) * s)
        
        i = i % 6
        
        if i == 0 then r, g, b = v, t, p
        elseif i == 1 then r, g, b = q, v, p
        elseif i == 2 then r, g, b = p, v, t
        elseif i == 3 then r, g, b = p, q, v
        elseif i == 4 then r, g, b = t, p, v
        elseif i == 5 then r, g, b = v, p, q
        end
        
        return r, g, b
    end
    
    -- Initial HSV conversion from default RGB color
    hue, sat, val = rgbToHsv(color.R, color.G, color.B)
    
    -- Update sat-val frame color based on hue
    local function updateSatValFrame()
        local r, g, b = hsvToRgb(hue, 1, 1)
        SatValFrame.BackgroundColor3 = Color3.fromRGB(r * 255, g * 255, b * 255)
    end
    
    updateSatValFrame()
    
    -- Function to toggle color picker panel
    local function toggleColorPicker()
        opened = not opened
        
        if opened then
            -- Show color picker panel
            ColorPickerPanel.Visible = true
            ColorPickerContainer.Size = UDim2.new(1, 0, 0, ColorPickerFrame.Size.Y.Offset + ColorPickerPanel.Size.Y.Offset + 5)
        else
            -- Hide color picker panel
            local originalSize = config.Description and UDim2.new(1, 0, 0, 60) or UDim2.new(1, 0, 0, 40)
            ColorPickerContainer.Size = originalSize
            
            -- Delay hiding the panel to allow animation to complete
            task.delay(0.2, function()
                if not opened then
                    ColorPickerPanel.Visible = false
                end
            end)
        end
    end
    
    -- Color picker click handler
    ColorPickerButton.MouseButton1Click:Connect(toggleColorPicker)
    
    -- Hue slider logic
    local hueDragging = false
    
    HueSlider.MouseButton1Down:Connect(function()
        hueDragging = true
    end)
    
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            hueDragging = false
        end
    end)
    
    HueSlider.MouseMoved:Connect(function(_, y)
        if hueDragging then
            local relativeY = math.clamp((y - HueFrame.AbsolutePosition.Y) / HueFrame.AbsoluteSize.Y, 0, 1)
            hue = 1 - relativeY
            
            -- Update color
            local r, g, b = hsvToRgb(hue, sat, val)
            color = Color3.fromRGB(r * 255, g * 255, b * 255)
            library.Flags[config.Flag] = color
            
            -- Update UI
            updateSatValFrame()
            updateColor()
        end
    end)
    
    -- SatVal slider logic
    local satValDragging = false
    
    SatValSlider.MouseButton1Down:Connect(function()
        satValDragging = true
    end)
    
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            satValDragging = false
        end
    end)
    
    SatValSlider.MouseMoved:Connect(function(x, y)
        if satValDragging then
            local relativeX = math.clamp((x - SatValFrame.AbsolutePosition.X) / SatValFrame.AbsoluteSize.X, 0, 1)
            local relativeY = math.clamp((y - SatValFrame.AbsolutePosition.Y) / SatValFrame.AbsoluteSize.Y, 0, 1)
            
            sat = relativeX
            val = 1 - relativeY
            
            -- Update color
            local r, g, b = hsvToRgb(hue, sat, val)
            color = Color3.fromRGB(r * 255, g * 255, b * 255)
            library.Flags[config.Flag] = color
            
            -- Update UI
            updateColor()
        end
    end)
    
    -- Alpha slider logic (if enabled)
    if config.Alpha then
        local alphaDragging = false
        
        AlphaSlider.MouseButton1Down:Connect(function()
            alphaDragging = true
        end)
        
        game:GetService("UserInputService").InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                alphaDragging = false
            end
        end)
        
        AlphaSlider.MouseMoved:Connect(function(_, y)
            if alphaDragging then
                local relativeY = math.clamp((y - AlphaFrame.AbsolutePosition.Y) / AlphaFrame.AbsoluteSize.Y, 0, 1)
                alpha = 1 - relativeY
                
                -- Update flag with alpha value
                library.Flags[config.Flag .. "_Alpha"] = alpha
                
                -- Call callback with both color and alpha
                pcall(config.Callback, color, alpha)
            end
        end)
    end
    
    -- RGB input logic
    RgbInput.FocusLost:Connect(function()
        local r, g, b = 255, 255, 255
        
        -- Attempt to parse RGB values
        local success = pcall(function()
            local values = string.split(RgbInput.Text, ",")
            r = math.clamp(tonumber(values[1]) or 255, 0, 255)
            g = math.clamp(tonumber(values[2]) or 255, 0, 255)
            b = math.clamp(tonumber(values[3]) or 255, 0, 255)
        end)
        
        if success then
            -- Update color
            color = Color3.fromRGB(r, g, b)
            
            -- Update HSV values
            hue, sat, val = rgbToHsv(r/255, g/255, b/255)
            
            -- Update UI
            updateSatValFrame()
            updateColor()
            
            -- Update flag and call callback
            library.Flags[config.Flag] = color
            if config.Alpha then
                pcall(config.Callback, color, alpha)
            else
                pcall(config.Callback, color)
            end
        else
            -- Reset to current color if parsing failed
            updateColor()
        end
    end)
    
    -- Hex input logic
    HexInput.FocusLost:Connect(function()
        local r, g, b = 255, 255, 255
        
        -- Attempt to parse Hex value
        local success = pcall(function()
            local hex = HexInput.Text:gsub("#", "")
            if #hex == 6 then
                r = tonumber("0x" .. hex:sub(1, 2)) or 255
                g = tonumber("0x" .. hex:sub(3, 4)) or 255
                b = tonumber("0x" .. hex:sub(5, 6)) or 255
            end
        end)
        
        if success then
            -- Update color
            color = Color3.fromRGB(r, g, b)
            
            -- Update HSV values
            hue, sat, val = rgbToHsv(r/255, g/255, b/255)
            
            -- Update UI
            updateSatValFrame()
            updateColor()
            
            -- Update flag and call callback
            library.Flags[config.Flag] = color
            if config.Alpha then
                pcall(config.Callback, color, alpha)
            else
                pcall(config.Callback, color)
            end
        else
            -- Reset to current color if parsing failed
            updateColor()
        end
    end)
    
    -- Apply button click handler
    ApplyButton.MouseButton1Click:Connect(function()
        -- Update flag and call callback
        library.Flags[config.Flag] = color
        if config.Alpha then
            pcall(config.Callback, color, alpha)
        else
            pcall(config.Callback, color)
        end
        
        -- Close color picker
        toggleColorPicker()
    end)
    
    -- Color picker hover effect
    ColorPickerButton.MouseEnter:Connect(function()
        library.Utils.Tween.Create(ColorPickerFrame, 0.2, {
            BackgroundColor3 = library.SelectedTheme.ElementBackgroundHover
        })
    end)
    
    ColorPickerButton.MouseLeave:Connect(function()
        library.Utils.Tween.Create(ColorPickerFrame, 0.2, {
            BackgroundColor3 = library.SelectedTheme.ElementBackground
        })
    end)
    
    -- Apply button hover effect
    ApplyButton.MouseEnter:Connect(function()
        library.Utils.Tween.Create(ApplyButton, 0.2, {
            BackgroundColor3 = library.SelectedTheme.ButtonBackgroundHover
        })
    end)
    
    ApplyButton.MouseLeave:Connect(function()
        library.Utils.Tween.Create(ApplyButton, 0.2, {
            BackgroundColor3 = library.SelectedTheme.ButtonBackground
        })
    end)
    
    -- Set initial flag value
    if config.Alpha then
        library.Flags[config.Flag .. "_Alpha"] = alpha
    end
    
    -- Color picker methods
    local colorpicker = {
        Instance = ColorPickerContainer,
        ColorPickerFrame = ColorPickerFrame,
        Title = ColorPickerTitle,
        Color = color,
        Alpha = alpha
    }
    
    -- Set colorpicker color
    function colorpicker:Set(newColor, newAlpha)
        if typeof(newColor) == "Color3" then
            color = newColor
            
            -- Update HSV values
            hue, sat, val = rgbToHsv(color.R, color.G, color.B)
            
            -- Update UI
            updateSatValFrame()
            updateColor()
            
            -- Update flag
            library.Flags[config.Flag] = color
        end
        
        if config.Alpha and newAlpha then
            alpha = math.clamp(newAlpha, 0, 1)
            library.Flags[config.Flag .. "_Alpha"] = alpha
        end
        
        -- Call callback
        if config.Alpha then
            pcall(config.Callback, color, alpha)
        else
            pcall(config.Callback, color)
        end
    end
    
    -- Get colorpicker color
    function colorpicker:Get()
        if config.Alpha then
            return color, alpha
        else
            return color
        end
    end
    
    -- Change colorpicker title
    function colorpicker:SetTitle(title)
        ColorPickerTitle.Text = title
    end
    
    -- Update colorpicker callback
    function colorpicker:SetCallback(callback)
        config.Callback = callback
    end
    
    return colorpicker
end

return ColorPicker
