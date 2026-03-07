local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local CoreGui = (gethui and gethui()) or game:GetService("CoreGui")

local MinimalLib = {}
MinimalLib.__index = MinimalLib

function MinimalLib.new(title, keybind)
    local self = setmetatable({}, MinimalLib)
    self.Key = keybind or Enum.KeyCode.RightControl
    self.Open = true

    self.Screen = Instance.new("ScreenGui", CoreGui)
    self.Screen.Name = "MinimalLib_UI"

    -- Main Window
    self.Main = Instance.new("Frame", self.Screen)
    self.Main.Size = UDim2.new(0, 300, 0, 400)
    self.Main.Position = UDim2.new(0.5, -150, 0.5, -200)
    self.Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    self.Main.Active = true
    self.Main.Draggable = true -- Fitur Drag Bebas

    local Title = Instance.new("TextLabel", self.Main)
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Text = title
    Title.TextColor3 = Color3.new(1,1,1)
    Title.BackgroundTransparency = 1

    self.Container = Instance.new("ScrollingFrame", self.Main)
    self.Container.Position = UDim2.new(0, 5, 0, 45)
    self.Container.Size = UDim2.new(1, -10, 1, -50)
    self.Container.BackgroundTransparency = 1
    Instance.new("UIListLayout", self.Container).Padding = UDim.new(0, 5)

    -- Toggle UI keybind
    UIS.InputBegan:Connect(function(inp, gpe)
        if not gpe and inp.KeyCode == self.Key then
            self.Open = not self.Open
            self.Main.Visible = self.Open
        end
    end)

    return self
end

function MinimalLib:CreateLabel(text)
    local lbl = Instance.new("TextLabel", self.Container)
    lbl.Size = UDim2.new(1, 0, 0, 30)
    lbl.Text = text
    lbl.TextColor3 = Color3.new(1,1,1)
    lbl.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
end

function MinimalLib:CreateToggle(text, callback)
    local btn = Instance.new("TextButton", self.Container)
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.BackgroundColor3 = active and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(50, 50, 50)
        callback(active)
    end)
end

function MinimalLib:CreateDropdown(text, list, callback)
    local btn = Instance.new("TextButton", self.Container)
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Text = text .. " [V]"
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    local open = false
    btn.MouseButton1Click:Connect(function()
        open = not open
        if open then
            for _, item in pairs(list) do
                local itm = Instance.new("TextButton", self.Container)
                itm.Size = UDim2.new(1, 0, 0, 30)
                itm.Text = item
                itm.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                itm.MouseButton1Click:Connect(function() callback(item) end)
            end
        else
            -- Hapus item list (sederhana)
            for _, child in pairs(self.Container:GetChildren()) do
                if child:IsA("TextButton") and child.Text ~= text .. " [V]" then child:Destroy() end
            end
        end
    end)
end

function MinimalLib:Notify(text)
    local n = Instance.new("TextLabel", self.Screen)
    n.Size = UDim2.new(0, 200, 0, 50)
    n.Position = UDim2.new(1, -210, 0.8, 0)
    n.Text = text
    TS:Create(n, TweenInfo.new(0.5), {Position = UDim2.new(1, -210, 0.9, 0)}):Play()
    task.wait(2)
    n:Destroy()
end

return MinimalLib