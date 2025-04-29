-- Custom UI Library
local UI = {}

-- Helper function to create rounded corners
local function createRoundedFrame(parent, size, position, color, cornerRadius)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.Size = size
    frame.Position = position
    frame.BackgroundColor3 = color
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true

    local corner = Instance.new("UICorner")
    corner.Parent = frame
    corner.CornerRadius = UDim.new(0, cornerRadius)

    return frame
end

-- Helper function to create a button with an icon
local function createButtonWithIcon(parent, size, position, text, iconID, callback)
    local button = Instance.new("TextButton")
    button.Parent = parent
    button.Size = size
    button.Position = position
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.TextScaled = true
    button.Font = Enum.Font.Gotham
    button.TextButton1Click:Connect(callback)

    local icon = Instance.new("ImageLabel")
    icon.Parent = button
    icon.Size = UDim2.new(0, 30, 0, 30)
    icon.Position = UDim2.new(0, 5, 0, 5)
    icon.Image = iconID
    icon.BackgroundTransparency = 1

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.Parent = button
    buttonCorner.CornerRadius = UDim.new(0, 12)

    return button
end

-- Initialize the Library
function UI:CreateWindow(title)
    local window = Instance.new("ScreenGui")
    window.Name = title
    window.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    window.ResetOnSpawn = false

    local frame = createRoundedFrame(window, UDim2.new(0, 500, 0, 400), UDim2.new(0.5, -250, 0.5, -200), Color3.fromRGB(34, 34, 34), 20)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = frame
    titleLabel.Text = title
    titleLabel.Size = UDim2.new(1, 0, 0, 40)
    titleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextScaled = true
    titleLabel.TextTransparency = 0.1
    titleLabel.BorderSizePixel = 0

    -- Create a sample button with a custom icon (Roblox asset for now)
    local button = createButtonWithIcon(frame, UDim2.new(0, 200, 0, 50), UDim2.new(0.5, -100, 0.5, 0), "Sample Button", "rbxassetid://6031071050", function()
        print("Button Clicked!")
    end)

    -- Create a slider
    local sliderFrame = createRoundedFrame(frame, UDim2.new(0, 400, 0, 40), UDim2.new(0.5, -200, 0.8, 0), Color3.fromRGB(40, 40, 40), 10)

    local sliderLabel = Instance.new("TextLabel")
    sliderLabel.Parent = sliderFrame
    sliderLabel.Text = "Volume"
    sliderLabel.Size = UDim2.new(0, 100, 1, 0)
    sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    sliderLabel.TextScaled = true
    sliderLabel.BackgroundTransparency = 1

    local sliderBar = Instance.new("Frame")
    sliderBar.Parent = sliderFrame
    sliderBar.Size = UDim2.new(1, -120, 0, 10)
    sliderBar.Position = UDim2.new(0, 100, 0, 15)
    sliderBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderBar.BorderSizePixel = 0

    local sliderKnob = Instance.new("Frame")
    sliderKnob.Parent = sliderBar
    sliderKnob.Size = UDim2.new(0, 20, 1, 0)
    sliderKnob.Position = UDim2.new(0, 0, 0, 0)
    sliderKnob.BackgroundColor3 = Color3.fromRGB(0, 128, 255)
    sliderKnob.BorderSizePixel = 0

    sliderKnob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mouse = game:GetService("Players").LocalPlayer:GetMouse()
            local startX = mouse.X
            local function updateSlider()
                local delta = mouse.X - startX
                local newX = math.clamp(sliderKnob.Position.X.Offset + delta, 0, sliderBar.Size.X.Offset - sliderKnob.Size.X.Offset)
                sliderKnob.Position = UDim2.new(0, newX, 0, 0)
            end
            game:GetService("RunService").Heartbeat:Connect(updateSlider)
        end
    end)

    return window
end

return UI
