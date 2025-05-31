local player = game.Players.LocalPlayer
local root = nil
local conn = nil
local gui = nil

local function startTracker()
    if gui then gui:Destroy() end

    local char = player.Character or player.CharacterAdded:Wait()
    root = char:WaitForChild("HumanoidRootPart")

    gui = Instance.new("ScreenGui")
    gui.Name = "PositionTracker"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 340, 0, 180)
    frame.Position = UDim2.new(0.5, -170, 0.5, -90)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BorderSizePixel = 0
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Active = true
    frame.Draggable = true
    frame.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 5)
    title.BackgroundTransparency = 1
    title.Text = "Position Tracker"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 26
    title.Parent = frame

    local posLabel = Instance.new("TextLabel")
    posLabel.Size = UDim2.new(1, -40, 0, 35)
    posLabel.Position = UDim2.new(0.5, -150, 0, 60)
    posLabel.BackgroundTransparency = 1
    posLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    posLabel.Font = Enum.Font.GothamMedium
    posLabel.TextSize = 20
    posLabel.TextXAlignment = Enum.TextXAlignment.Center
    posLabel.Text = "X: 0, Y: 0, Z: 0"
    posLabel.Parent = frame

    local copyBtn = Instance.new("TextButton")
    copyBtn.Size = UDim2.new(0, 120, 0, 35)
    copyBtn.Position = UDim2.new(0.5, -130, 1, -45)
    copyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    copyBtn.Text = "Copy"
    copyBtn.Font = Enum.Font.GothamBold
    copyBtn.TextColor3 = Color3.new(1, 1, 1)
    copyBtn.TextSize = 18
    copyBtn.Parent = frame

    local exitBtn = Instance.new("TextButton")
    exitBtn.Size = UDim2.new(0, 120, 0, 35)
    exitBtn.Position = UDim2.new(0.5, 10, 1, -45)
    exitBtn.BackgroundColor3 = Color3.fromRGB(100, 40, 40)
    exitBtn.Text = "Exit"
    exitBtn.Font = Enum.Font.GothamBold
    exitBtn.TextColor3 = Color3.new(1, 1, 1)
    exitBtn.TextSize = 18
    exitBtn.Parent = frame

    local c1 = Instance.new("UICorner")
    c1.CornerRadius = UDim.new(0, 8)
    c1.Parent = copyBtn
    local c2 = Instance.new("UICorner")
    c2.CornerRadius = UDim.new(0, 8)
    c2.Parent = exitBtn

    local currPos = "X: 0, Y: 0, Z: 0"
    if conn then conn:Disconnect() end

    conn = game:GetService("RunService").RenderStepped:Connect(function()
        if root then
            local pos = root.Position
            currPos = string.format("X: %d, Y: %d, Z: %d", math.floor(pos.X), math.floor(pos.Y), math.floor(pos.Z))
            posLabel.Text = currPos
        end
    end)

    copyBtn.MouseButton1Click:Connect(function()
        setclipboard(currPos)
        copyBtn.Text = "Copied!"
        task.wait(1)
        copyBtn.Text = "Copy"
    end)

    exitBtn.MouseButton1Click:Connect(function()
        if conn then conn:Disconnect() end
        gui:Destroy()
    end)
end

startTracker()
​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​
