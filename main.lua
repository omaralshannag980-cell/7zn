-- =====================================================
-- واجهة بنفسجي غامق + أسود (Dark Purple Theme)
-- مع نظام بانق / مص / سريع + إشعار خروج دائم
-- حقوق الواجهة لـ 9z_e.1
-- =====================================================

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")

-- =====================================================
-- 1. تعريف الثيم البنفسجي الغامق
-- =====================================================
local redzlib = {
    Themes = {
        DarkPurple = {
            ["Color Hub 1"] = ColorSequence.new({
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(8, 0, 12)),
                ColorSequenceKeypoint.new(0.50, Color3.fromRGB(18, 0, 25)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(8, 0, 12))
            }),
            ["Color Hub 2"] = Color3.fromRGB(12, 0, 18),
            ["Color Stroke"] = Color3.fromRGB(60, 0, 80),
            ["Color Theme"] = Color3.fromRGB(160, 0, 255),
            ["Color Text"] = Color3.fromRGB(240, 230, 255),
            ["Color Dark Text"] = Color3.fromRGB(180, 150, 200),
            ["Color Dark Purple"] = Color3.fromRGB(120, 0, 180),
            ["Color Dark Greem"] = Color3.fromRGB(160, 0, 255)
        }
    },
    Save = { UISize = {550, 420}, TabSize = 160, Theme = "DarkPurple" },
    Settings = {},
    Connection = {},
    Instances = {},
    Elements = {},
    Options = {},
    Flags = {},
    Tabs = {},
    Icons = {}
}

-- =====================================================
-- 2. دوال مساعدة
-- =====================================================
local function CreateTween(obj, prop, val, t)
    local ts = game:GetService("TweenService")
    local info = TweenInfo.new(t or 0.3, Enum.EasingStyle.Quint)
    local tween = ts:Create(obj, info, {[prop] = val})
    tween:Play()
    return tween
end

local function MakeDrag(frame)
    frame.Active = true
    frame.AutoButtonColor = false
    local dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragStart = input.Position
            startPos = frame.Position
            while game:GetService("UserInputService"):IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                task.wait()
                local delta = game:GetService("UserInputService"):GetMouseLocation() - dragStart
                frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end
    end)
    return frame
end

local function MakeCorner(obj, r)
    local corner = Instance.new("UICorner", obj)
    corner.CornerRadius = r or UDim.new(0, 6)
    return corner
end

local function MakeStroke(obj, color, thick)
    local stroke = Instance.new("UIStroke", obj)
    stroke.Color = color or Color3.fromRGB(60, 0, 80)
    stroke.Thickness = thick or 1
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    return stroke
end

-- =====================================================
-- 3. إنشاء الواجهة الرئيسية
-- =====================================================
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "DarkPurpleUI"

local MainFrame = Instance.new("ImageButton", ScreenGui)
MainFrame.Size = UDim2.new(0, 550, 0, 420)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -210)
MainFrame.BackgroundTransparency = 0.15
MainFrame.Name = "Hub"
MakeDrag(MainFrame)
MakeCorner(MainFrame)

local grad = Instance.new("UIGradient", MainFrame)
grad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 12)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 0, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 0, 12))
})
grad.Rotation = 45

-- =====================================================
-- 4. الشريط العلوي (TopBar)
-- =====================================================
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(0, 250, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "💜 Dark Control"
Title.TextColor3 = Color3.fromRGB(240, 230, 255)
Title.TextSize = 14
Title.Font = Enum.Font.FredokaOne
Title.TextXAlignment = Enum.TextXAlignment.Left

-- النص الفرعي "by Omarshannah1234"
local SubTitle = Instance.new("TextLabel", TopBar)
SubTitle.Size = UDim2.new(0, 180, 1, 0)
SubTitle.Position = UDim2.new(0, 170, 0, 0)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "by Omarshannah1234"
SubTitle.TextColor3 = Color3.fromRGB(160, 0, 255)
SubTitle.TextSize = 10
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.TextYAlignment = Enum.TextYAlignment.Bottom

-- أزرار الإغلاق والتصغير
local CloseBtn = Instance.new("ImageButton", TopBar)
CloseBtn.Size = UDim2.new(0, 16, 0, 16)
CloseBtn.Position = UDim2.new(1, -12, 0.5, 0)
CloseBtn.AnchorPoint = Vector2.new(1, 0.5)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Image = "rbxassetid://10747384394"

local MinBtn = CloseBtn:Clone()
MinBtn.Position = UDim2.new(1, -36, 0.5, 0)
MinBtn.Image = "rbxassetid://10734896206"

local isMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame.Size = UDim2.new(0, 550, 0, 30)
        MinBtn.Image = "rbxassetid://10734924532"
    else
        MainFrame.Size = UDim2.new(0, 550, 0, 420)
        MinBtn.Image = "rbxassetid://10734896206"
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- =====================================================
-- 5. نظام التبويبات (Tabs) - التحكم + حقوق
-- =====================================================
local TabContainer = Instance.new("Frame", MainFrame)
TabContainer.Size = UDim2.new(1, 0, 1, -40)
TabContainer.Position = UDim2.new(0, 0, 0, 35)
TabContainer.BackgroundTransparency = 1

-- شريط التبويبات
local TabBar = Instance.new("Frame", TabContainer)
TabBar.Size = UDim2.new(1, 0, 0, 28)
TabBar.BackgroundTransparency = 1

local function CreateTabButton(name, callback)
    local btn = Instance.new("TextButton", TabBar)
    btn.Size = UDim2.new(0, 80, 1, 0)
    btn.Position = UDim2.new(0, 0, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(18, 0, 25)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(240, 230, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    MakeCorner(btn, UDim.new(0, 4))
    btn.AutoButtonColor = false
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- محتوى التبويبات
local TabContent = Instance.new("Frame", TabContainer)
TabContent.Size = UDim2.new(1, 0, 1, -28)
TabContent.Position = UDim2.new(0, 0, 0, 28)
TabContent.BackgroundTransparency = 1

-- التاب الأول: التحكم
local TabControl = Instance.new("ScrollingFrame", TabContent)
TabControl.Size = UDim2.new(1, 0, 1, 0)
TabControl.BackgroundTransparency = 1
TabControl.ScrollBarThickness = 3
TabControl.ScrollBarImageColor3 = Color3.fromRGB(160, 0, 255)
TabControl.CanvasSize = UDim2.new(0, 0, 0, 0)
TabControl.AutomaticCanvasSize = Enum.AutomaticSize.Y
TabControl.ScrollingDirection = Enum.ScrollingDirection.Y

local UIListControl = Instance.new("UIListLayout", TabControl)
UIListControl.Padding = UDim.new(0, 8)
local UIPadControl = Instance.new("UIPadding", TabControl)
UIPadControl.PaddingTop = UDim.new(0, 10)
UIPadControl.PaddingBottom = UDim.new(0, 10)
UIPadControl.PaddingLeft = UDim.new(0, 10)
UIPadControl.PaddingRight = UDim.new(0, 10)

-- التاب الثاني: حقوق
local TabRights = Instance.new("Frame", TabContent)
TabRights.Size = UDim2.new(1, 0, 1, 0)
TabRights.BackgroundTransparency = 1
TabRights.Visible = false

-- عناصر تاب الحقوق
local RightsLabel = Instance.new("TextLabel", TabRights)
RightsLabel.Size = UDim2.new(1, 0, 0, 30)
RightsLabel.Position = UDim2.new(0, 0, 0, 20)
RightsLabel.BackgroundTransparency = 1
RightsLabel.Text = "جميع الحقوق محفوظة لـ"
RightsLabel.TextColor3 = Color3.fromRGB(240, 230, 255)
RightsLabel.Font = Enum.Font.GothamBold
RightsLabel.TextSize = 14
RightsLabel.TextXAlignment = Enum.TextXAlignment.Center

-- زر ينسخ اسم المستخدم
local CopyBtn = Instance.new("TextButton", TabRights)
CopyBtn.Size = UDim2.new(0, 180, 0, 40)
CopyBtn.Position = UDim2.new(0.5, -90, 0, 60)
CopyBtn.BackgroundColor3 = Color3.fromRGB(160, 0, 255)
CopyBtn.Text = "9z_e.1"
CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyBtn.Font = Enum.Font.GothamBold
CopyBtn.TextSize = 16
MakeCorner(CopyBtn, UDim.new(0, 8))

CopyBtn.MouseButton1Click:Connect(function()
    local success = pcall(function()
        GuiService:SetClipboard("9z_e.1")
    end)
    if not success then
        pcall(function()
            setclipboard("9z_e.1")
        end)
    end
    CopyBtn.Text = "✅ تم النسخ!"
    task.wait(1.5)
    CopyBtn.Text = "9z_e.1"
end)

-- إضافة نص إضافي
local Footer = Instance.new("TextLabel", TabRights)
Footer.Size = UDim2.new(1, 0, 0, 20)
Footer.Position = UDim2.new(0, 0, 1, -30)
Footer.BackgroundTransparency = 1
Footer.Text = "© 2026 - جميع الحقوق محفوظة"
Footer.TextColor3 = Color3.fromRGB(180, 150, 200)
Footer.Font = Enum.Font.Gotham
Footer.TextSize = 10
Footer.TextXAlignment = Enum.TextXAlignment.Center

-- =====================================================
-- 6. وظائف التبويبات
-- =====================================================
local function ShowTab(tab)
    TabControl.Visible = (tab == "control")
    TabRights.Visible = (tab == "rights")
end

local btnControl = CreateTabButton("التحكم", function() ShowTab("control") end)
btnControl.Position = UDim2.new(0, 5, 0, 0)
local btnRights = CreateTabButton("حقوق", function() ShowTab("rights") end)
btnRights.Position = UDim2.new(0, 90, 0, 0)

-- تحديد التاب الافتراضي
ShowTab("control")

-- =====================================================
-- 7. محتوى تبويب التحكم (البحث والأزرار)
-- =====================================================
local TargetPlayer = nil

local function FindPlayerByPrefix(prefix)
    if prefix == nil or prefix == "" then return nil end
    prefix = string.lower(prefix)
    for _, plr in pairs(Players:GetPlayers()) do
        if string.lower(string.sub(plr.Name, 1, 3)) == prefix then
            return plr
        end
    end
    return nil
end

-- حقل إدخال الأحرف الثلاثة
local SearchBox = Instance.new("Frame", TabControl)
SearchBox.Size = UDim2.new(1, 0, 0, 32)
SearchBox.BackgroundColor3 = Color3.fromRGB(18, 0, 25)
MakeCorner(SearchBox, UDim.new(0, 6))
MakeStroke(SearchBox, Color3.fromRGB(60, 0, 80))

local Input = Instance.new("TextBox", SearchBox)
Input.Size = UDim2.new(1, -20, 1, 0)
Input.Position = UDim2.new(0, 10, 0, 0)
Input.BackgroundTransparency = 1
Input.Text = ""
Input.PlaceholderText = "اكتب أول 3 أحرف من اسم الضحية..."
Input.TextColor3 = Color3.fromRGB(240, 230, 255)
Input.Font = Enum.Font.GothamBold
Input.TextSize = 12

local SearchBtn = Instance.new("TextButton", SearchBox)
SearchBtn.Size = UDim2.new(0, 60, 1, -4)
SearchBtn.Position = UDim2.new(1, -65, 0, 2)
SearchBtn.BackgroundColor3 = Color3.fromRGB(160, 0, 255)
SearchBtn.Text = "بحث"
SearchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBtn.Font = Enum.Font.GothamBold
SearchBtn.TextSize = 11
MakeCorner(SearchBtn, UDim.new(0, 4))

local TargetDisplay = Instance.new("TextLabel", TabControl)
TargetDisplay.Size = UDim2.new(1, 0, 0, 18)
TargetDisplay.BackgroundTransparency = 1
TargetDisplay.Text = "🎯 الضحية: (لم يتم اختيار أحد)"
TargetDisplay.TextColor3 = Color3.fromRGB(180, 150, 200)
TargetDisplay.Font = Enum.Font.Gotham
TargetDisplay.TextSize = 11
TargetDisplay.TextXAlignment = Enum.TextXAlignment.Left

local function UpdateTarget()
    local prefix = Input.Text
    if prefix == "" then
        TargetPlayer = nil
        TargetDisplay.Text = "🎯 الضحية: (لم يتم اختيار أحد)"
        return
    end
    local plr = FindPlayerByPrefix(prefix)
    if plr then
        TargetPlayer = plr
        TargetDisplay.Text = "🎯 الضحية: " .. plr.Name .. " (متصل)"
    else
        TargetPlayer = nil
        TargetDisplay.Text = "🎯 الضحية: لم يتم العثور على لاعب!"
    end
end

SearchBtn.MouseButton1Click:Connect(UpdateTarget)
Input.FocusLost:Connect(function(enter)
    if enter then UpdateTarget() end
end)

-- =====================================================
-- 8. أزرار البانق والمص
-- =====================================================
local function CreateActionButton(text, color, isFast)
    local btn = Instance.new("TextButton", TabControl)
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    MakeCorner(btn, UDim.new(0, 6))
    
    btn.MouseEnter:Connect(function()
        CreateTween(btn, "BackgroundTransparency", 0.3, 0.15)
    end)
    btn.MouseLeave:Connect(function()
        CreateTween(btn, "BackgroundTransparency", 0, 0.15)
    end)
    
    btn.MouseButton1Click:Connect(function()
        if not TargetPlayer then
            TargetDisplay.Text = "⚠️ يرجى تحديد ضحية أولاً!"
            task.wait(2)
            UpdateTarget()
            return
        end
        if not TargetPlayer.Parent then
            TargetDisplay.Text = "❌ الضحية غير موجودة حالياً!"
            task.wait(2)
            UpdateTarget()
            return
        end
        
        local success, err = pcall(function()
            local banRemote = ReplicatedStorage:FindFirstChild("BanRemote")
            local kickRemote = ReplicatedStorage:FindFirstChild("KickRemote")
            if text:find("بانق") then
                if banRemote then
                    banRemote:FireServer(TargetPlayer, isFast and "FastBan" or "Ban")
                else
                    TargetPlayer:Kick("تم حظرك بواسطة المشرف")
                end
            elseif text:find("مص") then
                if kickRemote then
                    kickRemote:FireServer(TargetPlayer, isFast and "FastKick" or "Kick")
                else
                    TargetPlayer:Kick("تم طردك بواسطة المشرف")
                end
            end
        end)
        
        if success then
            TargetDisplay.Text = "✅ تم تنفيذ الأمر على " .. TargetPlayer.Name
            if isFast then
                TargetDisplay.Text = "⚡ " .. TargetDisplay.Text .. " (سريع)"
            end
        else
            TargetDisplay.Text = "❌ فشل التنفيذ: " .. tostring(err)
        end
        task.wait(2)
        UpdateTarget()
    end)
    return btn
end

CreateActionButton("🔨 بانق", Color3.fromRGB(160, 0, 255), false)
CreateActionButton("👢 مص", Color3.fromRGB(120, 0, 200), false)
CreateActionButton("⚡ بانق سريع", Color3.fromRGB(200, 50, 255), true)
CreateActionButton("⚡ مص سريع", Color3.fromRGB(180, 0, 200), true)

-- =====================================================
-- 9. إشعار الخروج الدائم (بنفسجي + زر OK)
-- =====================================================
local LeaveNotif = Instance.new("Frame", ScreenGui)
LeaveNotif.Size = UDim2.new(0, 320, 0, 70)
LeaveNotif.Position = UDim2.new(0, 15, 0, 15)
LeaveNotif.BackgroundColor3 = Color3.fromRGB(20, 0, 30)
LeaveNotif.BackgroundTransparency = 0.1
LeaveNotif.Visible = false
LeaveNotif.ZIndex = 100
MakeCorner(LeaveNotif, UDim.new(0, 10))
MakeStroke(LeaveNotif, Color3.fromRGB(160, 0, 255), 2)

local innerBg = Instance.new("Frame", LeaveNotif)
innerBg.Size = UDim2.new(1, 0, 1, 0)
innerBg.BackgroundTransparency = 0.5
innerBg.BackgroundColor3 = Color3.fromRGB(10, 0, 15)
MakeCorner(innerBg, UDim.new(0, 10))

local OKBtn = Instance.new("TextButton", LeaveNotif)
OKBtn.Size = UDim2.new(0, 40, 0, 22)
OKBtn.Position = UDim2.new(0, 8, 0, 8)
OKBtn.BackgroundColor3 = Color3.fromRGB(160, 0, 255)
OKBtn.Text = "OK"
OKBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OKBtn.Font = Enum.Font.GothamBold
OKBtn.TextSize = 11
MakeCorner(OKBtn, UDim.new(0, 4))

local LeaveText = Instance.new("TextLabel", LeaveNotif)
LeaveText.Size = UDim2.new(1, -60, 1, 0)
LeaveText.Position = UDim2.new(0, 50, 0, 0)
LeaveText.BackgroundTransparency = 1
LeaveText.Text = "الضحية ... خرج من السيرفر"
LeaveText.TextColor3 = Color3.fromRGB(240, 230, 255)
LeaveText.Font = Enum.Font.GothamBold
LeaveText.TextSize = 13
LeaveText.TextXAlignment = Enum.TextXAlignment.Left
LeaveText.TextWrapped = true

OKBtn.MouseButton1Click:Connect(function()
    LeaveNotif.Visible = false
end)

Players.PlayerRemoving:Connect(function(player)
    if player == Player then return end
    LeaveText.Text = "🟣 " .. player.Name .. " خرج من السيرفر"
    LeaveNotif.Visible = true
end)

-- =====================================================
-- 10. تحديث تلقائي عند الكتابة
-- =====================================================
Input:GetPropertyChangedSignal("Text"):Connect(function()
    if Input.Text:len() >= 3 then
        UpdateTarget()
    end
end)

UpdateTarget()

print("✅ الواجهة البنفسجية الغامقة تعمل بنجاح!")
print("💜 حقوق الواجهة لـ 9z_e.1")
