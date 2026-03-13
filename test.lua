local UILibrary = {}

local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

if CoreGui:FindFirstChild("DybooUI") then
CoreGui.DybooUI:Destroy()
end

function UILibrary:CreateWindow(title)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DybooUI"
ScreenGui.Parent = CoreGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0,220,0,60)
Main.Position = UDim2.new(0.5,-110,0.5,-100)
Main.BackgroundColor3 = Color3.fromRGB(0,0,0)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

Instance.new("UICorner",Main).CornerRadius = UDim.new(0,10)

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(80,80,80)
Stroke.Thickness = 2
Stroke.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,30)
Title.BackgroundTransparency = 1
Title.Text = title
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Parent = Main

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0,25,0,25)
MinBtn.Position = UDim2.new(1,-30,0,3)
MinBtn.Text = "-"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 14
MinBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
MinBtn.TextColor3 = Color3.fromRGB(255,255,255)
MinBtn.Parent = Main
Instance.new("UICorner",MinBtn).CornerRadius = UDim.new(0,6)

local Container = Instance.new("Frame")
Container.Position = UDim2.new(0,0,0,35)
Container.Size = UDim2.new(1,0,0,0)
Container.BackgroundTransparency = 1
Container.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0,6)
Layout.Parent = Container

local minimized = false

MinBtn.MouseButton1Click:Connect(function()

if minimized then
Container.Visible = true
MinBtn.Text = "-"
else
Container.Visible = false
MinBtn.Text = "+"
end

minimized = not minimized

end)

-- DRAG
local dragging=false
local dragStart
local startPos

Main.InputBegan:Connect(function(input)

if input.UserInputType == Enum.UserInputType.MouseButton1 
or input.UserInputType == Enum.UserInputType.Touch then

dragging=true
dragStart=input.Position
startPos=Main.Position

end

end)

Main.InputEnded:Connect(function(input)

if input.UserInputType == Enum.UserInputType.MouseButton1
or input.UserInputType == Enum.UserInputType.Touch then

dragging=false

end

end)

UserInputService.InputChanged:Connect(function(input)

if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
or input.UserInputType == Enum.UserInputType.Touch) then

local delta=input.Position-dragStart

Main.Position=UDim2.new(
startPos.X.Scale,
startPos.X.Offset+delta.X,
startPos.Y.Scale,
startPos.Y.Offset+delta.Y
)

end

end)

local Window = {}

function Window:Resize()
Main.Size = UDim2.new(0,220,0,Container.UIListLayout.AbsoluteContentSize.Y+45)
Container.Size = UDim2.new(1,0,0,Container.UIListLayout.AbsoluteContentSize.Y)
end

-- BUTTON
function Window:Button(text,callback)

local Btn = Instance.new("TextButton")
Btn.Size = UDim2.new(0.9,0,0,30)
Btn.Position = UDim2.new(0.05,0,0,0)
Btn.BackgroundColor3 = Color3.fromRGB(15,15,15)
Btn.Text = text
Btn.TextColor3 = Color3.fromRGB(255,255,255)
Btn.Font = Enum.Font.GothamSemibold
Btn.TextSize = 13
Btn.Parent = Container
Instance.new("UICorner",Btn).CornerRadius = UDim.new(0,6)

Btn.MouseButton1Click:Connect(function()
callback()
end)

Window:Resize()

end

-- TOGGLE
function Window:Toggle(text,callback)

local state=false

local Btn = Instance.new("TextButton")
Btn.Size = UDim2.new(0.9,0,0,30)
Btn.Position = UDim2.new(0.05,0,0,0)
Btn.BackgroundColor3 = Color3.fromRGB(15,15,15)
Btn.Text = text.." : OFF"
Btn.TextColor3 = Color3.fromRGB(255,255,255)
Btn.Font = Enum.Font.GothamSemibold
Btn.TextSize = 13
Btn.Parent = Container
Instance.new("UICorner",Btn).CornerRadius = UDim.new(0,6)

Btn.MouseButton1Click:Connect(function()

state=not state

Btn.Text=text.." : "..(state and "ON" or "OFF")

callback(state)

end)

Window:Resize()

end

-- TEXTBOX
function Window:Textbox(text,callback)

local Box = Instance.new("TextBox")
Box.Size = UDim2.new(0.9,0,0,30)
Box.Position = UDim2.new(0.05,0,0,0)
Box.BackgroundColor3 = Color3.fromRGB(15,15,15)
Box.PlaceholderText = text
Box.Text=""
Box.TextColor3 = Color3.fromRGB(255,255,255)
Box.Font = Enum.Font.Gotham
Box.TextSize = 13
Box.Parent = Container
Instance.new("UICorner",Box).CornerRadius = UDim.new(0,6)

Box.FocusLost:Connect(function()
callback(Box.Text)
end)

Window:Resize()

end

-- SLIDER
function Window:Slider(text,min,max,callback)

local value=min

local Btn = Instance.new("TextButton")
Btn.Size = UDim2.new(0.9,0,0,30)
Btn.Position = UDim2.new(0.05,0,0,0)
Btn.BackgroundColor3 = Color3.fromRGB(15,15,15)
Btn.Text = text.." : "..min
Btn.TextColor3 = Color3.fromRGB(255,255,255)
Btn.Font = Enum.Font.GothamSemibold
Btn.TextSize = 13
Btn.Parent = Container
Instance.new("UICorner",Btn).CornerRadius = UDim.new(0,6)

Btn.MouseButton1Click:Connect(function()

value=value+1
if value>max then
value=min
end

Btn.Text=text.." : "..value
callback(value)

end)

Window:Resize()

end

-- DROPDOWN
function Window:Dropdown(text,list,callback)

local index=1

local Btn = Instance.new("TextButton")
Btn.Size = UDim2.new(0.9,0,0,30)
Btn.Position = UDim2.new(0.05,0,0,0)
Btn.BackgroundColor3 = Color3.fromRGB(15,15,15)
Btn.Text = text.." : "..list[1]
Btn.TextColor3 = Color3.fromRGB(255,255,255)
Btn.Font = Enum.Font.GothamSemibold
Btn.TextSize = 13
Btn.Parent = Container
Instance.new("UICorner",Btn).CornerRadius = UDim.new(0,6)

Btn.MouseButton1Click:Connect(function()

index=index+1
if index>#list then
index=1
end

Btn.Text=text.." : "..list[index]

callback(list[index])

end)

Window:Resize()

end

return Window

end

return UILibrary