--[[
    Themes Utility for Luminous UI Library
    
    Provides theme definitions and theme management functions
]]

local Themes = {}

-- Default themes
local themes = {
    Default = {
        -- Main UI Colors
        Background = Color3.fromRGB(25, 25, 35),
        TopBar = Color3.fromRGB(30, 30, 40),
        TabBackground = Color3.fromRGB(20, 20, 30),
        ContentBackground = Color3.fromRGB(25, 25, 35),
        SectionBackground = Color3.fromRGB(30, 30, 40),
        
        -- Element Colors
        ElementBackground = Color3.fromRGB(35, 35, 45),
        ElementBackgroundHover = Color3.fromRGB(40, 40, 55),
        
        -- Text Colors
        TextColor = Color3.fromRGB(255, 255, 255),
        SubTextColor = Color3.fromRGB(170, 170, 180),
        
        -- Tab Colors
        TabInactive = Color3.fromRGB(30, 30, 40),
        TabActive = Color3.fromRGB(55, 55, 70),
        
        -- Button Colors
        ButtonBackground = Color3.fromRGB(50, 50, 65),
        ButtonBackgroundHover = Color3.fromRGB(60, 60, 75),
        
        -- Toggle Colors
        ToggleBackground = Color3.fromRGB(40, 40, 55),
        ToggleBackgroundEnabled = Color3.fromRGB(45, 125, 225),
        ToggleSwitch = Color3.fromRGB(240, 240, 245),
        
        -- Slider Colors
        SliderBackground = Color3.fromRGB(40, 40, 55),
        SliderFill = Color3.fromRGB(45, 125, 225),
        
        -- Dropdown Colors
        DropdownBackground = Color3.fromRGB(40, 40, 55),
        
        -- Input Colors
        InputBackground = Color3.fromRGB(40, 40, 55),
        InputBackgroundFocused = Color3.fromRGB(50, 50, 65),
        InputPlaceholder = Color3.fromRGB(150, 150, 160),
        
        -- ScrollBar Color
        ScrollBar = Color3.fromRGB(50, 50, 65)
    },
    
    Dark = {
        -- Main UI Colors
        Background = Color3.fromRGB(15, 15, 20),
        TopBar = Color3.fromRGB(20, 20, 25),
        TabBackground = Color3.fromRGB(10, 10, 15),
        ContentBackground = Color3.fromRGB(15, 15, 20),
        SectionBackground = Color3.fromRGB(20, 20, 25),
        
        -- Element Colors
        ElementBackground = Color3.fromRGB(25, 25, 30),
        ElementBackgroundHover = Color3.fromRGB(30, 30, 40),
        
        -- Text Colors
        TextColor = Color3.fromRGB(240, 240, 240),
        SubTextColor = Color3.fromRGB(160, 160, 170),
        
        -- Tab Colors
        TabInactive = Color3.fromRGB(20, 20, 25),
        TabActive = Color3.fromRGB(45, 45, 55),
        
        -- Button Colors
        ButtonBackground = Color3.fromRGB(35, 35, 45),
        ButtonBackgroundHover = Color3.fromRGB(45, 45, 55),
        
        -- Toggle Colors
        ToggleBackground = Color3.fromRGB(30, 30, 40),
        ToggleBackgroundEnabled = Color3.fromRGB(35, 115, 215),
        ToggleSwitch = Color3.fromRGB(230, 230, 235),
        
        -- Slider Colors
        SliderBackground = Color3.fromRGB(30, 30, 40),
        SliderFill = Color3.fromRGB(35, 115, 215),
        
        -- Dropdown Colors
        DropdownBackground = Color3.fromRGB(30, 30, 40),
        
        -- Input Colors
        InputBackground = Color3.fromRGB(30, 30, 40),
        InputBackgroundFocused = Color3.fromRGB(40, 40, 50),
        InputPlaceholder = Color3.fromRGB(140, 140, 150),
        
        -- ScrollBar Color
        ScrollBar = Color3.fromRGB(40, 40, 50)
    },
    
    Light = {
        -- Main UI Colors
        Background = Color3.fromRGB(240, 240, 245),
        TopBar = Color3.fromRGB(250, 250, 255),
        TabBackground = Color3.fromRGB(230, 230, 235),
        ContentBackground = Color3.fromRGB(240, 240, 245),
        SectionBackground = Color3.fromRGB(250, 250, 255),
        
        -- Element Colors
        ElementBackground = Color3.fromRGB(230, 230, 235),
        ElementBackgroundHover = Color3.fromRGB(220, 220, 225),
        
        -- Text Colors
        TextColor = Color3.fromRGB(30, 30, 35),
        SubTextColor = Color3.fromRGB(80, 80, 90),
        
        -- Tab Colors
        TabInactive = Color3.fromRGB(230, 230, 235),
        TabActive = Color3.fromRGB(210, 210, 215),
        
        -- Button Colors
        ButtonBackground = Color3.fromRGB(210, 210, 215),
        ButtonBackgroundHover = Color3.fromRGB(200, 200, 205),
        
        -- Toggle Colors
        ToggleBackground = Color3.fromRGB(200, 200, 205),
        ToggleBackgroundEnabled = Color3.fromRGB(45, 125, 225),
        ToggleSwitch = Color3.fromRGB(255, 255, 255),
        
        -- Slider Colors
        SliderBackground = Color3.fromRGB(200, 200, 205),
        SliderFill = Color3.fromRGB(45, 125, 225),
        
        -- Dropdown Colors
        DropdownBackground = Color3.fromRGB(210, 210, 215),
        
        -- Input Colors
        InputBackground = Color3.fromRGB(210, 210, 215),
        InputBackgroundFocused = Color3.fromRGB(200, 200, 205),
        InputPlaceholder = Color3.fromRGB(100, 100, 110),
        
        -- ScrollBar Color
        ScrollBar = Color3.fromRGB(180, 180, 190)
    },
    
    Cyan = {
        -- Main UI Colors
        Background = Color3.fromRGB(25, 30, 35),
        TopBar = Color3.fromRGB(30, 35, 40),
        TabBackground = Color3.fromRGB(20, 25, 30),
        ContentBackground = Color3.fromRGB(25, 30, 35),
        SectionBackground = Color3.fromRGB(30, 35, 40),
        
        -- Element Colors
        ElementBackground = Color3.fromRGB(35, 40, 45),
        ElementBackgroundHover = Color3.fromRGB(45, 50, 55),
        
        -- Text Colors
        TextColor = Color3.fromRGB(240, 245, 250),
        SubTextColor = Color3.fromRGB(170, 180, 190),
        
        -- Tab Colors
        TabInactive = Color3.fromRGB(30, 35, 40),
        TabActive = Color3.fromRGB(0, 170, 200),
        
        -- Button Colors
        ButtonBackground = Color3.fromRGB(0, 150, 180),
        ButtonBackgroundHover = Color3.fromRGB(0, 170, 200),
        
        -- Toggle Colors
        ToggleBackground = Color3.fromRGB(35, 40, 45),
        ToggleBackgroundEnabled = Color3.fromRGB(0, 170, 200),
        ToggleSwitch = Color3.fromRGB(240, 240, 245),
        
        -- Slider Colors
        SliderBackground = Color3.fromRGB(35, 40, 45),
        SliderFill = Color3.fromRGB(0, 170, 200),
        
        -- Dropdown Colors
        DropdownBackground = Color3.fromRGB(35, 40, 45),
        
        -- Input Colors
        InputBackground = Color3.fromRGB(35, 40, 45),
        InputBackgroundFocused = Color3.fromRGB(40, 45, 50),
        InputPlaceholder = Color3.fromRGB(150, 160, 170),
        
        -- ScrollBar Color
        ScrollBar = Color3.fromRGB(0, 150, 180)
    },
    
    Purple = {
        -- Main UI Colors
        Background = Color3.fromRGB(30, 25, 35),
        TopBar = Color3.fromRGB(35, 30, 40),
        TabBackground = Color3.fromRGB(25, 20, 30),
        ContentBackground = Color3.fromRGB(30, 25, 35),
        SectionBackground = Color3.fromRGB(35, 30, 40),
        
        -- Element Colors
        ElementBackground = Color3.fromRGB(40, 35, 45),
        ElementBackgroundHover = Color3.fromRGB(50, 45, 55),
        
        -- Text Colors
        TextColor = Color3.fromRGB(245, 240, 250),
        SubTextColor = Color3.fromRGB(180, 170, 190),
        
        -- Tab Colors
        TabInactive = Color3.fromRGB(35, 30, 40),
        TabActive = Color3.fromRGB(140, 80, 210),
        
        -- Button Colors
        ButtonBackground = Color3.fromRGB(130, 70, 190),
        ButtonBackgroundHover = Color3.fromRGB(140, 80, 210),
        
        -- Toggle Colors
        ToggleBackground = Color3.fromRGB(40, 35, 45),
        ToggleBackgroundEnabled = Color3.fromRGB(140, 80, 210),
        ToggleSwitch = Color3.fromRGB(240, 240, 245),
        
        -- Slider Colors
        SliderBackground = Color3.fromRGB(40, 35, 45),
        SliderFill = Color3.fromRGB(140, 80, 210),
        
        -- Dropdown Colors
        DropdownBackground = Color3.fromRGB(40, 35, 45),
        
        -- Input Colors
        InputBackground = Color3.fromRGB(40, 35, 45),
        InputBackgroundFocused = Color3.fromRGB(45, 40, 50),
        InputPlaceholder = Color3.fromRGB(160, 150, 170),
        
        -- ScrollBar Color
        ScrollBar = Color3.fromRGB(130, 70, 190)
    }
}

-- Get all available themes
function Themes.GetThemes()
    return themes
end

-- Get a specific theme
function Themes.GetTheme(themeName)
    if themes[themeName] then
        return themes[themeName]
    else
        warn("Theme not found: " .. themeName .. ". Using Default theme.")
        return themes.Default
    end
end

-- Create a custom theme
function Themes.CreateTheme(themeName, themeColors)
    if not themeColors then
        warn("Invalid theme colors provided for theme: " .. themeName)
        return
    end
    
    -- Create new theme with default values for missing colors
    local newTheme = {}
    
    -- Set values from provided colors, or use Default theme as fallback
    for key, value in pairs(themes.Default) do
        newTheme[key] = themeColors[key] or value
    end
    
    -- Add theme to themes table
    themes[themeName] = newTheme
    
    return newTheme
end

return Themes
