--[[
    Luminous UI Library v1.0.0
    A customizable Roblox UI library with broad executor support
    
    Inspired by Rayfield but with a unique design and enhanced customization options
    
    Features:
    - Modern, clean UI design
    - Customizable themes and layouts
    - Broad executor compatibility
    - Optimized performance
    - Comprehensive element set
]]

local Luminous = {
    Name = "Luminous UI Library",
    Version = "1.0.0",
    Flags = {},
    Elements = {},
    Themes = {},
    Windows = {},
    SelectedTheme = nil,
    ToggleKey = Enum.KeyCode.RightShift,
    Toggled = true,
    FirstLoad = true,
}

-- Import utilities and elements
local Elements = {
    Button = loadstring(game:HttpGet('https://raw.githubusercontent.com/XXXT3/Grand-Agent-Library-UI-/refs/heads/main/elements/Button.lua'))(),
    Toggle = loadstring(game:HttpGet('https://raw.githubusercontent.com/XXXT3/Grand-Agent-Library-UI-/refs/heads/main/elements/Toggle.lua'))(),
    Slider = loadstring(game:HttpGet('https://raw.githubusercontent.com/XXXT3/Grand-Agent-Library-UI-/refs/heads/main/elements/Slider.lua'))(),
    Dropdown = loadstring(game:HttpGet('https://raw.githubusercontent.com/XXXT3/Grand-Agent-Library-UI-/refs/heads/main/elements/Dropdown.lua'))(),
    TextBox = loadstring(game:HttpGet('https://raw.githubusercontent.com/XXXT3/Grand-Agent-Library-UI-/refs/heads/main/elements/TextBox.lua'))(),
    ColorPicker = loadstring(game:HttpGet('https://raw.githubusercontent.com/XXXT3/Grand-Agent-Library-UI-/refs/heads/main/elements/ColorPicker.lua'))(),
}

local Utils = {
    Init = loadstring(game:HttpGet('https://raw.githubusercontent.com/XXXT3/Grand-Agent-Library-UI-/refs/heads/main/utils/Init.lua'))(),
    Themes = loadstring(game:HttpGet('https://raw.githubusercontent.com/XXXT3/Grand-Agent-Library-UI-/refs/heads/main/utils/Themes.lua'))(),
    Tween = loadstring(game:HttpGet('https://raw.githubusercontent.com/XXXT3/Grand-Agent-Library-UI-/refs/heads/main/utils/Tween.lua'))(),
}

-- Alternative loading method for better executor compatibility
local function safeLoad(moduleName, url)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)

    if not success then
        warn("Failed to load module: " .. moduleName .. ". Using built-in fallback.")
        -- Use a simplified built-in version as fallback
        return {}
    end

    return result
end

-- Try to use imported modules, fallback to built-in if fails
Luminous.Utils = Utils
Luminous.Elements = Elements
Luminous.Themes = Utils.Themes.GetThemes()
Luminous.SelectedTheme = Luminous.Themes.Default

-- Error handler
function Luminous:Error(message)
    warn("[Luminous UI] Error: " .. message)
end

-- Create the main UI container
function Luminous:CreateUI()
    -- Ensure we can run on this environment
    if not game:IsLoaded() then
        game.Loaded:Wait()
    end

    -- Protect GUI from game scripts
    local protectGui = function(gui)
        if syn and syn.protect_gui then
            syn.protect_gui(gui)
            gui.Parent = game:GetService("CoreGui")
        elseif gethui then
            gui.Parent = gethui()
        elseif KRNL_LOADED then
            gui.Parent = game:GetService("CoreGui")
        else
            gui.Parent = game:GetService("CoreGui")
        end
    end
    
    -- Create main UI elements
    local LuminousUI = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local TopBar = Instance.new("Frame")
    local TopBarUICorner = Instance.new("UICorner")
    local Title = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")
    local Tabs = Instance.new("Frame")
    local TabsUIListLayout = Instance.new("UIListLayout")
    local ContentFrame = Instance.new("Frame")
    local Shadow = Instance.new("ImageLabel")
    
    -- Configure UI properties
    LuminousUI.Name = "LuminousUI"
    LuminousUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    protectGui(LuminousUI)
    
    MainFrame.Name = "MainFrame"
    MainFrame.BackgroundColor3 = self.SelectedTheme.Background
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -175)
    MainFrame.Size = UDim2.new(0, 600, 0, 350)
    MainFrame.Parent = LuminousUI
    
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = MainFrame
    
    Shadow.Name = "Shadow"
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0, -15, 0, -15)
    Shadow.Size = UDim2.new(1, 30, 1, 30)
    Shadow.Image = "rbxassetid://6014261993"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.5
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    Shadow.ZIndex = -1
    Shadow.Parent = MainFrame
    
    TopBar.Name = "TopBar"
    TopBar.BackgroundColor3 = self.SelectedTheme.TopBar
    TopBar.Size = UDim2.new(1, 0, 0, 36)
    TopBar.Parent = MainFrame
    
    TopBarUICorner.CornerRadius = UDim.new(0, 6)
    TopBarUICorner.Parent = TopBar
    
    Title.Name = "Title"
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 12, 0, 0)
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "Luminous UI"
    Title.TextColor3 = self.SelectedTheme.TextColor
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar
    
    CloseButton.Name = "CloseButton"
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(1, -36, 0, 0)
    CloseButton.Size = UDim2.new(0, 36, 0, 36)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "✕"
    CloseButton.TextColor3 = self.SelectedTheme.TextColor
    CloseButton.TextSize = 18
    CloseButton.Parent = TopBar
    
    Tabs.Name = "Tabs"
    Tabs.BackgroundColor3 = self.SelectedTheme.TabBackground
    Tabs.BackgroundTransparency = 0.35
    Tabs.Position = UDim2.new(0, 12, 0, 48)
    Tabs.Size = UDim2.new(0, 150, 0, 290)
    Tabs.Parent = MainFrame
    
    local TabsUICorner = Instance.new("UICorner")
    TabsUICorner.CornerRadius = UDim.new(0, 6)
    TabsUICorner.Parent = Tabs
    
    TabsUIListLayout.Name = "TabsUIListLayout"
    TabsUIListLayout.Padding = UDim.new(0, 5)
    TabsUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabsUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabsUIListLayout.Parent = Tabs
    
    ContentFrame.Name = "ContentFrame"
    ContentFrame.BackgroundColor3 = self.SelectedTheme.ContentBackground
    ContentFrame.BackgroundTransparency = 0.1
    ContentFrame.Position = UDim2.new(0, 174, 0, 48)
    ContentFrame.Size = UDim2.new(0, 414, 0, 290)
    ContentFrame.Parent = MainFrame
    
    local ContentFrameUICorner = Instance.new("UICorner")
    ContentFrameUICorner.CornerRadius = UDim.new(0, 6)
    ContentFrameUICorner.Parent = ContentFrame
    
    -- Make UI draggable
    local UserInputService = game:GetService("UserInputService")
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    
    -- Close button functionality
    CloseButton.MouseButton1Click:Connect(function()
        LuminousUI:Destroy()
    end)
    
    -- Add keybind to toggle UI
    UserInputService.InputBegan:Connect(function(input, processed)
        if not processed and input.KeyCode == self.ToggleKey then
            self.Toggled = not self.Toggled
            MainFrame.Visible = self.Toggled
        end
    end)
    
    -- Store UI references
    Luminous.GUI = {
        ScreenGui = LuminousUI,
        MainFrame = MainFrame,
        TopBar = TopBar,
        Title = Title,
        Tabs = Tabs,
        ContentFrame = ContentFrame
    }
    
    return Luminous.GUI
end

-- Create a new window
function Luminous:CreateWindow(config)
    config = config or {}
    config.Name = config.Name or "Luminous"
    config.Theme = config.Theme or "Default"
    config.ToggleKey = config.ToggleKey or Enum.KeyCode.RightShift
    
    self.ToggleKey = config.ToggleKey
    
    -- Set theme
    if self.Themes[config.Theme] then
        self.SelectedTheme = self.Themes[config.Theme]
    else
        self:Error("Theme not found: " .. config.Theme .. ". Using Default theme.")
        self.SelectedTheme = self.Themes.Default
    end
    
    -- Initialize UI
    local UI = self:CreateUI()
    UI.Title.Text = config.Name
    
    -- Window methods
    local window = {
        Name = config.Name,
        Tabs = {},
        TabsInstances = {},
        TabContents = {}
    }
    
    -- Create a new tab
    function window:CreateTab(tabConfig)
        tabConfig = tabConfig or {}
        tabConfig.Name = tabConfig.Name or "Tab"
        tabConfig.Icon = tabConfig.Icon or "rbxassetid://10723407389" -- Default icon
        
        -- Create tab button
        local TabButton = Instance.new("TextButton")
        local TabIcon = Instance.new("ImageLabel")
        local TabName = Instance.new("TextLabel")
        
        TabButton.Name = "TabButton_" .. tabConfig.Name
        TabButton.BackgroundColor3 = Luminous.SelectedTheme.TabInactive
        TabButton.BackgroundTransparency = 0.4
        TabButton.Size = UDim2.new(0.9, 0, 0, 32)
        TabButton.Font = Enum.Font.GothamSemibold
        TabButton.Text = ""
        TabButton.TextColor3 = Luminous.SelectedTheme.TextColor
        TabButton.Parent = Luminous.GUI.Tabs
        
        local TabButtonUICorner = Instance.new("UICorner")
        TabButtonUICorner.CornerRadius = UDim.new(0, 6)
        TabButtonUICorner.Parent = TabButton
        
        TabIcon.Name = "TabIcon"
        TabIcon.BackgroundTransparency = 1
        TabIcon.Position = UDim2.new(0, 10, 0.5, -10)
        TabIcon.Size = UDim2.new(0, 20, 0, 20)
        TabIcon.Image = tabConfig.Icon
        TabIcon.ImageColor3 = Luminous.SelectedTheme.TextColor
        TabIcon.Parent = TabButton
        
        TabName.Name = "TabName"
        TabName.BackgroundTransparency = 1
        TabName.Position = UDim2.new(0, 36, 0, 0)
        TabName.Size = UDim2.new(1, -46, 1, 0)
        TabName.Font = Enum.Font.GothamSemibold
        TabName.Text = tabConfig.Name
        TabName.TextColor3 = Luminous.SelectedTheme.TextColor
        TabName.TextSize = 14
        TabName.TextXAlignment = Enum.TextXAlignment.Left
        TabName.Parent = TabButton
        
        -- Create tab content
        local TabContent = Instance.new("ScrollingFrame")
        local TabContentUIListLayout = Instance.new("UIListLayout")
        local TabContentPadding = Instance.new("UIPadding")
        
        TabContent.Name = "TabContent_" .. tabConfig.Name
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.ScrollBarThickness = 4
        TabContent.ScrollBarImageColor3 = Luminous.SelectedTheme.ScrollBar
        TabContent.Visible = false
        TabContent.Parent = Luminous.GUI.ContentFrame
        
        TabContentUIListLayout.Name = "TabContentUIListLayout"
        TabContentUIListLayout.Padding = UDim.new(0, 8)
        TabContentUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        TabContentUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabContentUIListLayout.Parent = TabContent
        
        TabContentPadding.Name = "TabContentPadding"
        TabContentPadding.PaddingTop = UDim.new(0, 10)
        TabContentPadding.PaddingLeft = UDim.new(0, 10)
        TabContentPadding.PaddingRight = UDim.new(0, 10)
        TabContentPadding.PaddingBottom = UDim.new(0, 10)
        TabContentPadding.Parent = TabContent
        
        -- Auto-size content
        TabContentUIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, TabContentUIListLayout.AbsoluteContentSize.Y + 20)
        end)
        
        -- Store tab references
        table.insert(window.Tabs, tabConfig.Name)
        window.TabsInstances[tabConfig.Name] = TabButton
        window.TabContents[tabConfig.Name] = TabContent
        
        -- Handle tab button clicks
        TabButton.MouseButton1Click:Connect(function()
            -- Hide all tab contents
            for _, content in pairs(window.TabContents) do
                content.Visible = false
            end
            
            -- Reset all tab buttons
            for _, button in pairs(window.TabsInstances) do
                button.BackgroundColor3 = Luminous.SelectedTheme.TabInactive
            end
            
            -- Show selected tab content and highlight button
            TabContent.Visible = true
            TabButton.BackgroundColor3 = Luminous.SelectedTheme.TabActive
        end)
        
        -- If this is the first tab, select it
        if #window.Tabs == 1 then
            TabContent.Visible = true
            TabButton.BackgroundColor3 = Luminous.SelectedTheme.TabActive
        end
        
        -- Tab object and methods
        local tab = {
            Name = tabConfig.Name,
            Content = TabContent
        }
        
        -- Create a new section
        function tab:CreateSection(sectionConfig)
            sectionConfig = sectionConfig or {}
            sectionConfig.Name = sectionConfig.Name or "Section"
            
            local Section = Instance.new("Frame")
            local SectionTitle = Instance.new("TextLabel")
            local SectionContent = Instance.new("Frame")
            local SectionContentUIListLayout = Instance.new("UIListLayout")
            
            Section.Name = "Section_" .. sectionConfig.Name
            Section.BackgroundColor3 = Luminous.SelectedTheme.SectionBackground
            Section.BackgroundTransparency = 0.15
            Section.Size = UDim2.new(1, -20, 0, 36) -- Will be resized based on content
            Section.Parent = TabContent
            
            local SectionUICorner = Instance.new("UICorner")
            SectionUICorner.CornerRadius = UDim.new(0, 6)
            SectionUICorner.Parent = Section
            
            SectionTitle.Name = "SectionTitle"
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Position = UDim2.new(0, 12, 0, 0)
            SectionTitle.Size = UDim2.new(1, -24, 0, 30)
            SectionTitle.Font = Enum.Font.GothamBold
            SectionTitle.Text = sectionConfig.Name
            SectionTitle.TextColor3 = Luminous.SelectedTheme.TextColor
            SectionTitle.TextSize = 16
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            SectionTitle.Parent = Section
            
            SectionContent.Name = "SectionContent"
            SectionContent.BackgroundTransparency = 1
            SectionContent.Position = UDim2.new(0, 12, 0, 36)
            SectionContent.Size = UDim2.new(1, -24, 0, 0) -- Will be resized based on content
            SectionContent.Parent = Section
            
            SectionContentUIListLayout.Name = "SectionContentUIListLayout"
            SectionContentUIListLayout.Padding = UDim.new(0, 8)
            SectionContentUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionContentUIListLayout.Parent = SectionContent
            
            -- Auto-size section based on content
            SectionContentUIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                SectionContent.Size = UDim2.new(1, -24, 0, SectionContentUIListLayout.AbsoluteContentSize.Y)
                Section.Size = UDim2.new(1, -20, 0, 36 + SectionContentUIListLayout.AbsoluteContentSize.Y + 10)
            end)
            
            -- Section object and methods
            local section = {
                Name = sectionConfig.Name,
                Content = SectionContent
            }
            
            -- Create a button
            function section:CreateButton(config)
                return Elements.Button.Create(Luminous, SectionContent, config)
            end
            
            -- Create a toggle
            function section:CreateToggle(config)
                return Elements.Toggle.Create(Luminous, SectionContent, config)
            end
            
            -- Create a slider
            function section:CreateSlider(config)
                return Elements.Slider.Create(Luminous, SectionContent, config)
            end
            
            -- Create a dropdown
            function section:CreateDropdown(config)
                return Elements.Dropdown.Create(Luminous, SectionContent, config)
            end
            
            -- Create a textbox
            function section:CreateTextBox(config)
                return Elements.TextBox.Create(Luminous, SectionContent, config)
            end
            
            -- Create a color picker
            function section:CreateColorPicker(config)
                return Elements.ColorPicker.Create(Luminous, SectionContent, config)
            end
            
            return section
        end
        
        return tab
    end
    
    -- Store window reference
    table.insert(self.Windows, window)
    
    return window
end

-- Set a new theme
function Luminous:SetTheme(themeName)
    if not self.Themes[themeName] then
        self:Error("Theme not found: " .. themeName)
        return
    end
    
    self.SelectedTheme = self.Themes[themeName]
    
    -- Update UI with new theme
    -- (Implementation would update all UI elements with new theme colors)
end

-- Set toggle key
function Luminous:SetToggleKey(key)
    if typeof(key) == "EnumItem" and key.EnumType == Enum.KeyCode then
        self.ToggleKey = key
    else
        self:Error("Invalid key type. Expected KeyCode Enum.")
    end
end

-- Get a flag value
function Luminous:GetFlag(flag)
    return self.Flags[flag]
end

-- Set a flag value
function Luminous:SetFlag(flag, value)
    self.Flags[flag] = value
end

-- Initialize library
Luminous.Utils.Init.Initialize()

return Luminous
