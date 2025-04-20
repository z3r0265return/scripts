-- Admin Panel Script with Complete Command Set

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local Lighting = game:GetService("Lighting")

-- Local references
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local playerGui = player:WaitForChild("PlayerGui")

-- UI Colors
local colors = {
    background = Color3.fromRGB(25, 25, 30),
    primary = Color3.fromRGB(40, 40, 50),
    secondary = Color3.fromRGB(55, 55, 70),
    accent = Color3.fromRGB(100, 150, 255),
    text = Color3.fromRGB(240, 240, 240),
    error = Color3.fromRGB(255, 80, 80),
    success = Color3.fromRGB(80, 255, 120),
    warning = Color3.fromRGB(255, 180, 40)
}

-- Main GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ZEROAdminGUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

-- Floating action button
local fab = Instance.new("ImageButton")
fab.Name = "FAB"
fab.Size = UDim2.new(0, 56, 0, 56)
fab.Position = UDim2.new(0, 20, 0.5, -28)
fab.AnchorPoint = Vector2.new(0, 0.5)
fab.BackgroundColor3 = colors.accent
fab.Image = "rbxassetid://3926305904"
fab.ImageRectOffset = Vector2.new(124, 364)
fab.ImageRectSize = Vector2.new(36, 36)
fab.ImageColor3 = colors.text
fab.ZIndex = 10

local fabCorner = Instance.new("UICorner")
fabCorner.CornerRadius = UDim.new(1, 0)
fabCorner.Parent = fab

local fabShadow = Instance.new("ImageLabel")
fabShadow.Name = "Shadow"
fabShadow.Size = UDim2.new(1, 10, 1, 10)
fabShadow.Position = UDim2.new(0, -5, 0, -5)
fabShadow.Image = "rbxassetid://1316045217"
fabShadow.ImageTransparency = 0.8
fabShadow.ScaleType = Enum.ScaleType.Slice
fabShadow.SliceCenter = Rect.new(10, 10, 118, 118)
fabShadow.BackgroundTransparency = 1
fabShadow.ZIndex = 9
fabShadow.Parent = fab

fab.Parent = gui

-- Command panel
local commandPanel = Instance.new("Frame")
commandPanel.Name = "CommandPanel"
commandPanel.Size = UDim2.new(0.4, 0, 0, 300)
commandPanel.Position = UDim2.new(0.5, 0, 1, -60)
commandPanel.AnchorPoint = Vector2.new(0.5, 1)
commandPanel.BackgroundColor3 = colors.background
commandPanel.Visible = false

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 12)
panelCorner.Parent = commandPanel

local panelShadow = Instance.new("ImageLabel")
panelShadow.Name = "Shadow"
panelShadow.Size = UDim2.new(1, 20, 1, 20)
panelShadow.Position = UDim2.new(0, -10, 0, -10)
panelShadow.Image = "rbxassetid://1316045217"
panelShadow.ImageTransparency = 0.9
panelShadow.ScaleType = Enum.ScaleType.Slice
panelShadow.SliceCenter = Rect.new(10, 10, 118, 118)
panelShadow.BackgroundTransparency = 1
panelShadow.ZIndex = -1
panelShadow.Parent = commandPanel

local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = colors.primary
titleBar.BorderSizePixel = 0

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

local titleText = Instance.new("TextLabel")
titleText.Name = "Title"
titleText.Size = UDim2.new(1, -20, 1, 0)
titleText.Position = UDim2.new(0, 20, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "ZERO ADMIN"
titleText.TextColor3 = colors.text
titleText.TextSize = 18
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

titleBar.Parent = commandPanel

local inputContainer = Instance.new("Frame")
inputContainer.Name = "InputContainer"
inputContainer.Size = UDim2.new(1, -20, 0, 50)
inputContainer.Position = UDim2.new(0, 10, 0, 50)
inputContainer.BackgroundColor3 = colors.secondary

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = inputContainer

local inputBox = Instance.new("TextBox")
inputBox.Name = "InputBox"
inputBox.Size = UDim2.new(1, -20, 1, -10)
inputBox.Position = UDim2.new(0, 10, 0, 5)
inputBox.BackgroundTransparency = 1
inputBox.TextColor3 = colors.text
inputBox.TextSize = 16
inputBox.Font = Enum.Font.Gotham
inputBox.ClearTextOnFocus = false
inputBox.PlaceholderText = "Type commands here... (type 'help' for list)"
inputBox.PlaceholderColor3 = Color3.fromRGB(180, 180, 180)
inputBox.TextXAlignment = Enum.TextXAlignment.Left
inputBox.Parent = inputContainer

inputContainer.Parent = commandPanel

local outputLog = Instance.new("ScrollingFrame")
outputLog.Name = "OutputLog"
outputLog.Size = UDim2.new(1, -20, 1, -120)
outputLog.Position = UDim2.new(0, 10, 0, 110)
outputLog.BackgroundTransparency = 1
outputLog.ScrollBarThickness = 5
outputLog.ScrollBarImageColor3 = colors.secondary
outputLog.AutomaticCanvasSize = Enum.AutomaticSize.Y
outputLog.CanvasSize = UDim2.new(0, 0, 0, 0)
outputLog.ScrollingDirection = Enum.ScrollingDirection.Y

local logLayout = Instance.new("UIListLayout")
logLayout.Padding = UDim.new(0, 5)
logLayout.Parent = outputLog

outputLog.Parent = commandPanel

local statusBar = Instance.new("Frame")
statusBar.Name = "StatusBar"
statusBar.Size = UDim2.new(1, 0, 0, 30)
statusBar.Position = UDim2.new(0, 0, 1, -30)
statusBar.BackgroundColor3 = colors.primary
statusBar.BorderSizePixel = 0

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 12)
statusCorner.Parent = statusBar

local statusText = Instance.new("TextLabel")
statusText.Name = "StatusText"
statusText.Size = UDim2.new(1, -20, 1, 0)
statusText.Position = UDim2.new(0, 20, 0, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "Ready"
statusText.TextColor3 = colors.text
statusText.TextSize = 14
statusText.Font = Enum.Font.Gotham
statusText.TextXAlignment = Enum.TextXAlignment.Left
statusText.Parent = statusBar

statusBar.Parent = commandPanel

commandPanel.Parent = gui

-- Animation Functions
local function tweenIn(instance)
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(instance, tweenInfo, {Position = UDim2.new(0.5, 0, 1, -60)})
    tween:Play()
end

local function tweenOut(instance)
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    local tween = TweenService:Create(instance, tweenInfo, {Position = UDim2.new(0.5, 0, 1, 300)})
    tween:Play()
end

-- UI Functions
local function addLogMessage(message, color)
    color = color or colors.text
    
    local logEntry = Instance.new("TextLabel")
    logEntry.Size = UDim2.new(1, 0, 0, 20)
    logEntry.BackgroundTransparency = 1
    logEntry.Text = "> " .. message
    logEntry.TextColor3 = color
    logEntry.TextSize = 14
    logEntry.Font = Enum.Font.Gotham
    logEntry.TextXAlignment = Enum.TextXAlignment.Left
    logEntry.TextTruncate = Enum.TextTruncate.AtEnd
    logEntry.Parent = outputLog
    
    outputLog.CanvasPosition = Vector2.new(0, outputLog.AbsoluteCanvasSize.Y)
end

local function setStatus(message, color)
    statusText.Text = message
    statusText.TextColor3 = color or colors.text
end

-- Command Variables
local noclipEnabled = false
local flyEnabled = false
local audioLoggerEnabled = false
local noclipConnection = nil
local flyController = nil

-- Command Implementations
local commandFunctions = {
    fly = function()
        if flyEnabled then
            return false, "Fly is already enabled"
        end
        
        local flyScript = loadstring(game:HttpGet("https://pastebin.com/raw/6YvYtGQG"))()
        flyController = flyScript()
        flyEnabled = true
        return true, "Fly enabled"
    end,
    
    unfly = function()
        if not flyEnabled then
            return false, "Fly isn't enabled"
        end
        
        if flyController then
            flyController:Unbind()
            flyController = nil
        end
        flyEnabled = false
        return true, "Fly disabled"
    end,
    
    freeze = function()
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.Anchored = true
            return true, "Character frozen"
        end
        return false, "No HumanoidRootPart found"
    end,
    
    unfreeze = function()
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.Anchored = false
            return true, "Character unfrozen"
        end
        return false, "No HumanoidRootPart found"
    end,
    
    noclip = function()
        if noclipEnabled then
            return false, "Noclip is already enabled"
        end
        
        noclipEnabled = true
        noclipConnection = RunService.Stepped:Connect(function()
            if not noclipEnabled then return end
            for _, v in pairs(character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end)
        return true, "Noclip enabled"
    end,
    
    unnoclip = function()
        if not noclipEnabled then
            return false, "Noclip isn't enabled"
        end
        
        noclipEnabled = false
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        
        for _, v in pairs(character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = true
            end
        end
        return true, "Noclip disabled"
    end,
    
    help = function()
        local commands = {
            "===== HELP - Available Commands =====",
            "fly - Enables fly mode",
            "unfly - Disables fly mode",
            "noclip - Enables noclip (walk through walls)",
            "unnoclip - Disables noclip",
            "freeze - Freezes your character",
            "unfreeze - Unfreezes your character",
            "speed [value] - Sets walk speed",
            "jumppower [value] - Sets jump power",
            "gravity [value] - Sets world gravity",
            "time [hour] - Sets game time (0-24)",
            "brightness [value] - Sets lighting brightness",
            "clear - Clears the command log",
            "help - Shows this help message",
            "audiologger - Toggles audio logging"
        }
        return true, commands
    end,
    
    clear = function()
        for _, child in ipairs(outputLog:GetChildren()) do
            if child:IsA("TextLabel") then
                child:Destroy()
            end
        end
        return true, "Log cleared"
    end,
    
    settings = function()
        return false, "Settings panel is not implemented yet"
    end,
    
    audiologger = function()
        audioLoggerEnabled = not audioLoggerEnabled
        
        if audioLoggerEnabled then
            SoundService.PlayingChanged:Connect(function(sound, isPlaying)
                if isPlaying then
                    addLogMessage("Audio played: " .. sound.Name, colors.accent)
                end
            end)
            return true, "Audio logging enabled"
        else
            return true, "Audio logging disabled"
        end
    end,
    
    speed = function(value)
        local num = tonumber(value)
        if not num then return false, "Invalid speed value" end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = num
            return true, "Walk speed set to " .. num
        end
        return false, "No humanoid found"
    end,
    
    jumppower = function(value)
        local num = tonumber(value)
        if not num then return false, "Invalid jump power value" end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.JumpPower = num
            return true, "Jump power set to " .. num
        end
        return false, "No humanoid found"
    end,
    
    gravity = function(value)
        local num = tonumber(value)
        if not num then return false, "Invalid gravity value" end
        
        workspace.Gravity = num
        return true, "Gravity set to " .. num
    end,
    
    time = function(value)
        local num = tonumber(value)
        if not num or num < 0 or num > 24 then 
            return false, "Invalid time (use 0-24)"
        end
        
        Lighting.ClockTime = num
        return true, "Time set to " .. num .. ":00"
    end,
    
    brightness = function(value)
        local num = tonumber(value)
        if not num or num < 0 then 
            return false, "Invalid brightness value"
        end
        
        Lighting.Brightness = num
        return true, "Brightness set to " .. num
    end
}

-- Command aliases
local commandAliases = {
    ["clip"] = "unnoclip",
    ["unfreeze"] = "freeze",
    ["unfly"] = "fly",
    ["walkspeed"] = "speed",
    ["jump"] = "jumppower",
    ["settime"] = "time",
    ["light"] = "brightness"
}

-- Execute Command Function
local function executeCommand(fullCommand)
    local args = {}
    for arg in string.gmatch(fullCommand, "[^%s]+") do
        table.insert(args, arg)
    end
    
    if #args == 0 then return end
    
    local command = args[1]:lower()
    table.remove(args, 1)
    
    command = commandAliases[command] or command
    
    addLogMessage(fullCommand, Color3.fromRGB(200, 200, 255))
    
    local func = commandFunctions[command]
    if func then
        local success, result = pcall(func, table.unpack(args))
        
        if success then
            if type(result) == "table" then
                for _, line in ipairs(result) do
                    addLogMessage(line, colors.accent)
                end
                setStatus("Help displayed", colors.success)
            elseif result == true then
                setStatus(args[2] or "Command executed", colors.success)
            elseif result == false then
                setStatus(args[2] or "Command failed", colors.error)
            else
                setStatus(result, result:find("fail") and colors.error or colors.success)
            end
        else
            setStatus("Command error: " .. tostring(result), colors.error)
        end
    else
        setStatus("Unknown command: " .. command, colors.error)
    end
end

-- Input Handling
inputBox.FocusLost:Connect(function(enterPressed)
    inputContainer.BackgroundColor3 = colors.secondary
    
    if enterPressed then
        local commandText = inputBox.Text
        
        if commandText ~= "" then
            for cmd in string.gmatch(commandText, "[^;]+") do
                cmd = string.gsub(cmd, "^%s*(.-)%s*$", "%1")
                if cmd ~= "" then
                    executeCommand(cmd)
                end
            end
            
            inputBox.Text = ""
        end
    end
end)

-- Toggle command panel
local panelVisible = false
fab.MouseButton1Click:Connect(function()
    panelVisible = not panelVisible
    commandPanel.Visible = panelVisible
    
    if panelVisible then
        tweenIn(commandPanel)
        inputBox:CaptureFocus()
    else
        tweenOut(commandPanel)
    end
end)

-- Keybinds
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Semicolon then
        panelVisible = not panelVisible
        commandPanel.Visible = panelVisible
        
        if panelVisible then
            tweenIn(commandPanel)
            inputBox:CaptureFocus()
        else
            tweenOut(commandPanel)
        end
    elseif input.KeyCode == Enum.KeyCode.Escape and panelVisible then
        panelVisible = false
        tweenOut(commandPanel)
    end
end)

-- Initialize UI after all functions are defined
setStatus("Admin panel loaded", colors.success)
addLogMessage("Type 'help' for a list of commands", colors.accent)
