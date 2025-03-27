--[[
    Initialization Utility for Luminous UI Library
    
    Handles initialization and environment checks
]]

local Init = {}

function Init.Initialize()
    -- Print initialization message
    print("Luminous UI Library initialized")
    
    -- Compatibility check for different executors
    if KRNL_LOADED then
        print("Executing on KRNL")
    elseif syn then
        print("Executing on Synapse X")
    elseif getexecutorname then
        print("Executing on " .. getexecutorname())
    elseif identifyexecutor then
        print("Executing on " .. identifyexecutor())
    else
        print("Executing on an unknown executor")
    end
end

-- Check if we can use secure functionality
function Init.CheckSecure()
    local secure = {
        syn = false,
        krnl = false,
        protectGui = false,
        gethui = false,
        hiddenUI = false
    }
    
    -- Check for Synapse X
    if syn and syn.protect_gui then
        secure.syn = true
        secure.protectGui = true
    end
    
    -- Check for KRNL
    if KRNL_LOADED then
        secure.krnl = true
    end
    
    -- Check for gethui
    if gethui then
        secure.gethui = true
        secure.hiddenUI = true
    end
    
    -- Check for hidden property
    if game:GetService("CoreGui"):FindFirstChild("RobloxGui") then
        if pcall(function() game:GetService("CoreGui").RobloxGui.Enabled = false end) then
            game:GetService("CoreGui").RobloxGui.Enabled = true
            secure.hiddenUI = true
        end
    end
    
    return secure
end

-- Get the proper UI parent based on the executor
function Init.GetUIParent()
    local secureCheck = Init.CheckSecure()
    
    if secureCheck.protectGui then
        -- For Synapse X
        return syn.protect_gui
    elseif secureCheck.gethui then
        -- For executors with gethui
        return gethui()
    elseif secureCheck.krnl then
        -- For KRNL
        return game:GetService("CoreGui")
    else
        -- Fallback
        local success, result = pcall(function()
            return game:GetService("CoreGui")
        end)
        
        if success then
            return result
        else
            return game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
        end
    end
end

-- Safer version loading
function Init.LoadVersion()
    local version = {
        Major = 1,
        Minor = 0,
        Patch = 0,
        String = "1.0.0"
    }
    return version
end

return Init
