--[[
    Luminous UI Library - Basic Example
    
    This example demonstrates the basic usage of the Luminous UI Library,
    showing how to create a window, tabs, sections, and various UI elements.
]]

-- In a real Roblox environment, you would load the library like this:
-- local Luminous = loadstring(game:HttpGet('https://raw.githubusercontent.com/YourUsername/LuminousUI/main/UILibrary.lua'))()

-- For demonstration purposes only (since we're not in Roblox):
print("-----------------------------------------------")
print("| Luminous UI Library - Basic Example (MOCK) |")
print("-----------------------------------------------")
print("In a Roblox environment, this would create a fully interactive GUI")
print("This mock version will show the structure of UI elements being created")
print("")

-- Load our mock implementation
local Luminous = require("examples/MockLuminous")

-- Create a new window
local Window = Luminous:CreateWindow({
    Name = "Luminous UI Example",
    Theme = "Default",
    ToggleKey = Enum.KeyCode.RightShift
})

-- Create a Main tab
local MainTab = Window:CreateTab({
    Name = "Main Features",
    Icon = "rbxassetid://7733964370" -- Gear icon
})

-- Create a section in the Main tab
local GeneralSection = MainTab:CreateSection({
    Name = "General"
})

-- Add a button
GeneralSection:CreateButton({
    Name = "Simple Button",
    Description = "This is a basic button example",
    Callback = function()
        print("Button clicked!")
    end
})

-- Add a toggle
local MyToggle = GeneralSection:CreateToggle({
    Name = "Toggle Feature",
    Description = "Enable or disable a feature",
    Default = false,
    Flag = "FeatureEnabled",
    Callback = function(Value)
        print("Feature is now: " .. (Value and "Enabled" or "Disabled"))
    end
})

-- Add a slider
local MySlider = GeneralSection:CreateSlider({
    Name = "Speed Multiplier",
    Description = "Adjust the speed multiplier",
    Min = 0,
    Max = 10,
    Default = 1,
    Increment = 0.1,
    ValueSuffix = "x",
    Flag = "SpeedMultiplier",
    Callback = function(Value)
        print("Speed multiplier set to: " .. Value)
    end
})

-- Add a textbox
local MyTextBox = GeneralSection:CreateTextBox({
    Name = "Player Name",
    Description = "Enter a player's username",
    PlaceholderText = "Username...",
    Default = "",
    ClearTextOnFocus = true,
    Flag = "TargetPlayer",
    Callback = function(Text, EnterPressed)
        if EnterPressed then
            print("Searching for player: " .. Text)
        end
    end
})

-- Create a new section for customization
local CustomizeSection = MainTab:CreateSection({
    Name = "Customization"
})

-- Add a dropdown
local ThemeDropdown = CustomizeSection:CreateDropdown({
    Name = "Select Theme",
    Description = "Choose a UI theme",
    Options = {"Default", "Dark", "Light", "Cyan", "Purple"},
    Default = "Default",
    Flag = "SelectedTheme",
    Callback = function(Selected)
        print("Changing theme to: " .. Selected)
        Luminous:SetTheme(Selected)
    end
})

-- Add a color picker
local ColorPicker = CustomizeSection:CreateColorPicker({
    Name = "UI Accent Color",
    Description = "Choose a custom accent color",
    Default = Color3.fromRGB(45, 125, 225),
    Flag = "AccentColor",
    Callback = function(Color)
        print("New accent color: " .. tostring(Color))
        -- In a real application, you would apply this color to your elements
    end
})

-- Create a second tab for player-related options
local PlayerTab = Window:CreateTab({
    Name = "Player",
    Icon = "rbxassetid://7743875962" -- Person icon
})

-- Create a section for player modifications
local PlayerSection = PlayerTab:CreateSection({
    Name = "Player Modifications"
})

-- Add toggles for different player modifications
PlayerSection:CreateToggle({
    Name = "Walk Speed Boost",
    Description = "Increase your walking speed",
    Default = false,
    Flag = "SpeedBoost",
    Callback = function(Value)
        if Value then
            -- Code to increase walk speed would go here
            print("Speed boost enabled")
        else
            -- Code to reset walk speed would go here
            print("Speed boost disabled")
        end
    end
})

PlayerSection:CreateToggle({
    Name = "Jump Power Boost",
    Description = "Increase your jumping power",
    Default = false,
    Flag = "JumpBoost",
    Callback = function(Value)
        if Value then
            -- Code to increase jump power would go here
            print("Jump boost enabled")
        else
            -- Code to reset jump power would go here
            print("Jump boost disabled")
        end
    end
})

PlayerSection:CreateToggle({
    Name = "Infinite Jump",
    Description = "Jump without limitations",
    Default = false,
    Flag = "InfiniteJump",
    Callback = function(Value)
        if Value then
            -- Code to enable infinite jump would go here
            print("Infinite jump enabled")
        else
            -- Code to disable infinite jump would go here
            print("Infinite jump disabled")
        end
    end
})

-- Create a section for player teleportation
local TeleportSection = PlayerTab:CreateSection({
    Name = "Teleportation"
})

-- Add a dropdown for selecting locations
TeleportSection:CreateDropdown({
    Name = "Teleport Location",
    Description = "Select a location to teleport to",
    Options = {"Spawn", "Shop", "Boss Area", "Secret Room"},
    Default = "Spawn",
    Flag = "TeleportLocation",
    Callback = function(Selected)
        print("Teleporting to: " .. Selected)
        -- Code to teleport the player would go here
    end
})

-- Add a button to teleport to selected player
TeleportSection:CreateButton({
    Name = "Teleport to Player",
    Description = "Teleport to the selected player",
    Callback = function()
        local targetPlayer = Luminous:GetFlag("TargetPlayer")
        if targetPlayer and targetPlayer ~= "" then
            print("Teleporting to player: " .. targetPlayer)
            -- Code to teleport to player would go here
        else
            print("No player selected")
        end
    end
})

-- Create a third tab for settings
local SettingsTab = Window:CreateTab({
    Name = "Settings",
    Icon = "rbxassetid://7734053495" -- Settings icon
})

-- Create a section for UI settings
local UISettingsSection = SettingsTab:CreateSection({
    Name = "UI Settings"
})

-- Add a toggle for UI sounds
UISettingsSection:CreateToggle({
    Name = "UI Sounds",
    Description = "Enable or disable UI interaction sounds",
    Default = true,
    Flag = "UISounds",
    Callback = function(Value)
        print("UI sounds: " .. (Value and "Enabled" or "Disabled"))
    end
})

-- Add a dropdown to change toggle key
UISettingsSection:CreateDropdown({
    Name = "Toggle Key",
    Description = "Select a key to toggle the UI",
    Options = {"RightShift", "RightControl", "LeftAlt", "F4"},
    Default = "RightShift",
    Flag = "ToggleKey",
    Callback = function(Selected)
        local keyMap = {
            RightShift = Enum.KeyCode.RightShift,
            RightControl = Enum.KeyCode.RightControl,
            LeftAlt = Enum.KeyCode.LeftAlt,
            F4 = Enum.KeyCode.F4
        }
        
        local key = keyMap[Selected]
        if key then
            Luminous:SetToggleKey(key)
            print("Toggle key set to: " .. Selected)
        end
    end
})

-- Create a section for script options
local ScriptSection = SettingsTab:CreateSection({
    Name = "Script Options"
})

-- Add a button to reset all settings
ScriptSection:CreateButton({
    Name = "Reset All Settings",
    Description = "Reset all settings to their default values",
    Callback = function()
        -- Example of resetting various flags and UI elements
        MyToggle:Set(false)
        MySlider:Set(1)
        MyTextBox:Set("")
        ThemeDropdown:Set("Default")
        ColorPicker:Set(Color3.fromRGB(45, 125, 225))
        
        print("All settings have been reset to default")
    end
})

-- Notify user that the script has loaded
print("Luminous UI Example has been loaded! Press RightShift to toggle the UI.")
