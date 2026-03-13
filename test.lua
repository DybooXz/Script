local DybooUI = {}

local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

function DybooUI:CreateWindow(title)

    if CoreGui:FindFirstChild("DybooHub") then
        CoreGui.DybooHub:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "DybooHub"
    ScreenGui.Parent = CoreGui
    ScreenGui.Enabled = true

    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0,220,0,140)
    MainFrame.Position = UDim2.new(0.5,-110,0.5,-70)
    MainFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    Instance.new("UICorner",MainFrame).CornerRadius = UDim.new(0,10)

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(80,80,80)
    Stroke.Thickness = 2
    Stroke.Parent = MainFrame

    -- Title
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1,0,0,30)
    Title.BackgroundTransparency = 1
    Title.Text = title or "Dyboo Hub"
    Title.TextColor3 = Color3.fromRGB(255,255,255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.Parent = MainFrame

    -- Minimize
    local MinBtn = Instance.new("TextButton")
    MinBtn.Size = UDim2.new(0,25,0,25)
    MinBtn.Position = UDim2.new(1,-30,0,3)
    MinBtn.Text = "-"
    MinBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
    MinBtn.TextColor3 = Color3.fromRGB(255,255,255)
    MinBtn.Font = Enum.Font.GothamBold
    MinBtn.TextSize = 14
    MinBtn.Parent = MainFrame

    Instance.new("UICorner",MinBtn).CornerRadius = UDim.new(0,6)

    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1,0,1,-30)
    Container.Position = UDim2.new(0,0,0,30)
    Container.BackgroundTransparency = 1
    Container.Parent = MainFrame

    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0,6)
    Layout.Parent = Container

    local minimized = false

    MinBtn.MouseButton1Click:Connect(function()
        if minimized then
            MainFrame.Size = UDim2.new(0,220,0,140)
            Container.Visible = true
            MinBtn.Text = "-"
        else
            MainFrame.Size = UDim2.new(0,220,0,35)
            Container.Visible = false
            MinBtn.Text = "+"
        end
        minimized = not minimized
    end)

    -- Drag
    local dragging = false
    local dragStart
    local startPos

    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)

    MainFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    local Window = {}

    function Window:Button(text,callback)

        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(0.85,0,0,30)
        Btn.Position = UDim2.new(0.075,0,0,0)
        Btn.BackgroundColor3 = Color3.fromRGB(15,15,15)
        Btn.Text = text
        Btn.TextColor3 = Color3.new(1,1,1)
        Btn.Font = Enum.Font.GothamSemibold
        Btn.TextSize = 13
        Btn.Parent = Container

        Instance.new("UICorner",Btn).CornerRadius = UDim.new(0,6)

        Btn.MouseButton1Click:Connect(function()
            if callback then
                callback()
            end
        end)

    end

    function Window:Toggle(text,callback)

        local state = false

        local Toggle = Instance.new("TextButton")
        Toggle.Size = UDim2.new(0.85,0,0,30)
        Toggle.Position = UDim2.new(0.075,0,0,0)
        Toggle.BackgroundColor3 = Color3.fromRGB(15,15,15)
        Toggle.Text = text.." : OFF"
        Toggle.TextColor3 = Color3.new(1,1,1)
        Toggle.Font = Enum.Font.GothamSemibold
        Toggle.TextSize = 13
        Toggle.Parent = Container

        Instance.new("UICorner",Toggle).CornerRadius = UDim.new(0,6)

        Toggle.MouseButton1Click:Connect(function()

            state = not state

            if state then
                Toggle.Text = text.." : ON"
            else
                Toggle.Text = text.." : OFF"
            end

            if callback then
                callback(state)
            end

        end)

    end

    return Window
end

return DybooUI