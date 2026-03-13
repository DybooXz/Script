local DybooUI = {}

local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

function DybooUI:CreateWindow(title)

    if CoreGui:FindFirstChild("DybooHub") then
        CoreGui.DybooHub:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui",CoreGui)
    ScreenGui.Name = "DybooHub"

    local Main = Instance.new("Frame",ScreenGui)
    Main.Size = UDim2.new(0,220,0,180)
    Main.Position = UDim2.new(0.5,-110,0.5,-90)
    Main.BackgroundColor3 = Color3.fromRGB(0,0,0)
    Main.BorderSizePixel = 0
    Instance.new("UICorner",Main).CornerRadius = UDim.new(0,10)

    local Stroke = Instance.new("UIStroke",Main)
    Stroke.Color = Color3.fromRGB(80,80,80)
    Stroke.Thickness = 2

    local Title = Instance.new("TextLabel",Main)
    Title.Size = UDim2.new(1,0,0,30)
    Title.BackgroundTransparency = 1
    Title.Text = title or "Dyboo Hub"
    Title.TextColor3 = Color3.new(1,1,1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16

    local Scroll = Instance.new("ScrollingFrame",Main)
    Scroll.Size = UDim2.new(1,0,1,-30)
    Scroll.Position = UDim2.new(0,0,0,30)
    Scroll.BackgroundTransparency = 1
    Scroll.ScrollBarThickness = 2
    Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Scroll.CanvasSize = UDim2.new()

    local Layout = Instance.new("UIListLayout",Scroll)
    Layout.Padding = UDim.new(0,6)

    local Pad = Instance.new("UIPadding",Scroll)
    Pad.PaddingLeft = UDim.new(0,10)
    Pad.PaddingRight = UDim.new(0,10)
    Pad.PaddingTop = UDim.new(0,6)

    local Window = {}

    function Window:Button(text,callback)

        local Btn = Instance.new("TextButton",Scroll)
        Btn.Size = UDim2.new(1,0,0,28)
        Btn.BackgroundColor3 = Color3.fromRGB(15,15,15)
        Btn.Text = text
        Btn.TextColor3 = Color3.new(1,1,1)
        Btn.Font = Enum.Font.GothamSemibold
        Btn.TextSize = 13
        Instance.new("UICorner",Btn).CornerRadius = UDim.new(0,6)

        Btn.MouseButton1Click:Connect(function()
            if callback then callback() end
        end)

    end

    function Window:Toggle(text,callback)

        local state = false

        local Toggle = Instance.new("TextButton",Scroll)
        Toggle.Size = UDim2.new(1,0,0,28)
        Toggle.BackgroundColor3 = Color3.fromRGB(15,15,15)
        Toggle.Text = text.." : OFF"
        Toggle.TextColor3 = Color3.new(1,1,1)
        Toggle.Font = Enum.Font.GothamSemibold
        Toggle.TextSize = 13
        Instance.new("UICorner",Toggle).CornerRadius = UDim.new(0,6)

        Toggle.MouseButton1Click:Connect(function()

            state = not state
            Toggle.Text = text.." : "..(state and "ON" or "OFF")

            if callback then
                callback(state)
            end

        end)

    end

    function Window:Textbox(text,callback)

        local Box = Instance.new("TextBox",Scroll)
        Box.Size = UDim2.new(1,0,0,28)
        Box.BackgroundColor3 = Color3.fromRGB(15,15,15)
        Box.PlaceholderText = text
        Box.Text = ""
        Box.TextColor3 = Color3.new(1,1,1)
        Box.Font = Enum.Font.Gotham
        Box.TextSize = 13
        Instance.new("UICorner",Box).CornerRadius = UDim.new(0,6)

        Box.FocusLost:Connect(function()
            if callback then
                callback(Box.Text)
            end
        end)

    end

    function Window:Slider(text,min,max,default,callback)

        local value = default

        local Slider = Instance.new("TextButton",Scroll)
        Slider.Size = UDim2.new(1,0,0,28)
        Slider.BackgroundColor3 = Color3.fromRGB(15,15,15)
        Slider.Text = text.." : "..value
        Slider.TextColor3 = Color3.new(1,1,1)
        Slider.Font = Enum.Font.GothamSemibold
        Slider.TextSize = 13
        Instance.new("UICorner",Slider).CornerRadius = UDim.new(0,6)

        Slider.MouseButton1Click:Connect(function()

            value += 1
            if value > max then value = min end

            Slider.Text = text.." : "..value

            if callback then
                callback(value)
            end

        end)

    end

    function Window:Dropdown(text,list,callback)

        local index = 1

        local Drop = Instance.new("TextButton",Scroll)
        Drop.Size = UDim2.new(1,0,0,28)
        Drop.BackgroundColor3 = Color3.fromRGB(15,15,15)
        Drop.Text = text.." : "..list[index]
        Drop.TextColor3 = Color3.new(1,1,1)
        Drop.Font = Enum.Font.GothamSemibold
        Drop.TextSize = 13
        Instance.new("UICorner",Drop).CornerRadius = UDim.new(0,6)

        Drop.MouseButton1Click:Connect(function()

            index += 1
            if index > #list then index = 1 end

            Drop.Text = text.." : "..list[index]

            if callback then
                callback(list[index])
            end

        end)

    end

    return Window
end

return DybooUI