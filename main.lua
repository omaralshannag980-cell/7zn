-- =====================================================
-- واجهة Dark Control للجوال (بنفسجي غامق)
-- حقوق الواجهة لـ 9z_e.1 | by Omarshannah1234
-- =====================================================

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")

-- =====================================================
-- 1. إنشاء الواجهة الرئيسية (مبسطة)
-- =====================================================
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "DarkControl"

-- الخلفية الرئيسية
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 450, 0, 420)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 0, 18)
MainFrame.BackgroundTransparency = 0.1
MainFrame.Active = true

-- زوايا دائرية
local Corner = Instance.new("UICorner", MainFrame)
Corner.CornerRadius = UDim.new(0, 10)

-- شريط علوي
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 28)
TopBar.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "💜 Dark Control"
Title.TextColor3 = Color3.fromRGB(240, 230, 255)
Title.TextSize = 14
Title.Font = Enum.Font.FredokaOne
Title.TextXAlignment = Enum.TextXAlignment.Left

-- النص الفرعي
local SubTitle = Instance.new("TextLabel", TopBar)
SubTitle.Size = UDim2.new(0, 150, 1, 0)
SubTitle.Position = UDim2.new(0, 130, 0, 0)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "by Omarshannah1234"
SubTitle.TextColor3 = Color3.fromRGB(160, 0, 255)
SubTitle.TextSize = 9
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
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- =====================================================
-- 2. التاب الأول: الاستهداف
-- =====================================================
local TabControl = Instance.new("Frame", MainFrame)
TabControl.Size = UDim2.new(1, -20, 1, -40)
TabControl.Position = UDim2.new(0, 10, 0, 38)
TabControl.BackgroundTransparency = 1

-- حقل الإدخال
local SearchBox = Instance.new("Frame", TabControl)
SearchBox.Size = UDim2.new(1, 0, 0, 32)
SearchBox.BackgroundColor3 = Color3.fromRGB(18, 0, 25)

local Input = Instance.new("TextBox", SearchBox)
Input.Size = UDim2.new(1, -70, 1, 0)
Input.Position = UDim2.new(0, 10, 0, 0)
Input.BackgroundTransparency = 1
Input.PlaceholderText = "أول 3 أحرف..."
Input.TextColor3 = Color3.fromRGB(240, 230, 255)
Input.Font = Enum.Font.GothamBold
Input.TextSize = 12

local SearchBtn = Instance.new("TextButton", SearchBox)
SearchBtn.Size = UDim2.new(0, 55, 1, -4)
SearchBtn.Position = UDim2.new(1, -60, 0, 2)
SearchBtn.BackgroundColor3 = Color3.fromRGB(160, 0, 255)
SearchBtn.Text = "بحث"
SearchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBtn.Font = Enum.Font.GothamBold
SearchBtn.TextSize = 11

-- عرض الضحية المختارة
local TargetDisplay = Instance.new("TextLabel", TabControl)
TargetDisplay.Size = UDim2.new(1, 0, 0, 18)
TargetDisplay.Position = UDim2.new(0, 0, 0, 40)
TargetDisplay.BackgroundTransparency = 1
TargetDisplay.Text = "🎯 الضحية: (لم يتم اختيار أحد)"
TargetDisplay.TextColor3 = Color3.fromRGB(180, 150, 200)
TargetDisplay.Font = Enum.Font.Gotham
TargetDisplay.TextSize = 11
TargetDisplay.TextXAlignment = Enum.TextXAlignment.Left

-- متغيرات
local TargetPlayer = nil
local TargetPrefix = ""

-- دالة البحث
local function FindPlayer(prefix)
    if prefix == nil or #prefix < 1 then return nil end
    prefix = string.lower(prefix)
    for _, plr in pairs(Players:GetPlayers()) do
        if string.lower(string.sub(plr.Name, 1, 3)) == prefix then
            return plr
        end
    end
    return nil
end

-- البحث عند الضغط
SearchBtn.MouseButton1Click:Connect(function()
    local plr = FindPlayer(Input.Text)
    if plr then
        TargetPlayer = plr
        TargetDisplay.Text = "🎯 الضحية: " .. plr.Name
    else
        TargetPlayer = nil
        TargetDisplay.Text = "🎯 الضحية: لم يتم العثور على لاعب!"
    end
end)

-- =====================================================
-- 3. الأزرار (بانق سريع + مص سريع)
-- =====================================================
local function CreateActionButton(text, color, isKick)
    local btn = Instance.new("TextButton", TabControl)
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Position = UDim2.new(0, 0, 0, 68 + (#TabControl:GetChildren() - 2) * 34)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    
    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0, 6)
    
    btn.MouseButton1Click:Connect(function()
        if not TargetPlayer or not TargetPlayer.Parent then
            TargetDisplay.Text = "⚠️ يرجى تحديد ضحية أولاً!"
            task.wait(2)
            TargetDisplay.Text = "🎯 الضحية: (لم يتم اختيار أحد)"
            return
        end
        
        -- تنفيذ الطرد مباشرة (للجوال)
        local success, err = pcall(function()
            if isKick then
                TargetPlayer:Kick("⚡ تم طردك بسرعة بواسطة المشرف!")
            else
                TargetPlayer:Kick("⚡ تم حظرك بسرعة بواسطة المشرف!")
            end
        end)
        
        if success then
            TargetDisplay.Text = "✅ تم تنفيذ الأمر على " .. TargetPlayer.Name
        else
            TargetDisplay.Text = "❌ فشل: " .. tostring(err)
        end
        task.wait(2)
        TargetDisplay.Text = "🎯 الضحية: (لم يتم اختيار أحد)"
        TargetPlayer = nil
    end)
    return btn
end

-- أزرار
CreateActionButton("⚡ بانق سريع", Color3.fromRGB(160, 0, 255), false)
CreateActionButton("⚡ مص سريع", Color3.fromRGB(120, 0, 200), true)

-- =====================================================
-- 4. زر الحقوق (في الأسفل)
-- =====================================================
local RightsBtn = Instance.new("TextButton", TabControl)
RightsBtn.Size = UDim2.new(1, 0, 0, 30)
RightsBtn.Position = UDim2.new(0, 0, 0, 176)
RightsBtn.BackgroundColor3 = Color3.fromRGB(60, 0, 80)
RightsBtn.Text = "📋 حقوق: 9z_e.1 (اضغط للنسخ)"
RightsBtn.TextColor3 = Color3.fromRGB(240, 230, 255)
RightsBtn.Font = Enum.Font.GothamBold
RightsBtn.TextSize = 11

local RightsCorner = Instance.new("UICorner", RightsBtn)
RightsCorner.CornerRadius = UDim.new(0, 6)

RightsBtn.MouseButton1Click:Connect(function()
    local success = pcall(function()
        GuiService:SetClipboard("9z_e.1")
    end)
    if not success then
        pcall(function()
            setclipboard("9z_e.1")
        end)
    end
    RightsBtn.Text = "✅ تم النسخ!"
    task.wait(1.5)
    RightsBtn.Text = "📋 حقوق: 9z_e.1 (اضغط للنسخ)"
end)

-- =====================================================
-- 5. إشعار الخروج الدائم (أعلى اليسار)
-- =====================================================
local LeaveNotif = Instance.new("Frame", ScreenGui)
LeaveNotif.Size = UDim2.new(0, 300, 0, 60)
LeaveNotif.Position = UDim2.new(0, 10, 0, 10)
LeaveNotif.BackgroundColor3 = Color3.fromRGB(20, 0, 30)
LeaveNotif.BackgroundTransparency = 0.1
LeaveNotif.Visible = false
LeaveNotif.ZIndex = 100

local NotifCorner = Instance.new("UICorner", LeaveNotif)
NotifCorner.CornerRadius = UDim.new(0, 10)

local NotifStroke = Instance.new("UIStroke", LeaveNotif)
NotifStroke.Color = Color3.fromRGB(160, 0, 255)
NotifStroke.Thickness = 2

-- زر OK (أعلى اليسار)
local OKBtn = Instance.new("TextButton", LeaveNotif)
OKBtn.Size = UDim2.new(0, 40, 0, 22)
OKBtn.Position = UDim2.new(0, 8, 0, 8)
OKBtn.BackgroundColor3 = Color3.fromRGB(160, 0, 255)
OKBtn.Text = "OK"
OKBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OKBtn.Font = Enum.Font.GothamBold
OKBtn.TextSize = 11

local OKCorner = Instance.new("UICorner", OKBtn)
OKCorner.CornerRadius = UDim.new(0, 4)

OKBtn.MouseButton1Click:Connect(function()
    LeaveNotif.Visible = false
end)

-- نص الإشعار
local LeaveText = Instance.new("TextLabel", LeaveNotif)
LeaveText.Size = UDim2.new(1, -60, 1, 0)
LeaveText.Position = UDim2.new(0, 50, 0, 0)
LeaveText.BackgroundTransparency = 1
LeaveText.Text = "🟣 الضحية ... خرج من السيرفر"
LeaveText.TextColor3 = Color3.fromRGB(240, 230, 255)
LeaveText.Font = Enum.Font.GothamBold
LeaveText.TextSize = 12
LeaveText.TextXAlignment = Enum.TextXAlignment.Left
LeaveText.TextWrapped = true

-- مراقبة الخروج
Players.PlayerRemoving:Connect(function(player)
    if player == Player then return end
    LeaveText.Text = "🟣 " .. player.Name .. " خرج من السيرفر"
    LeaveNotif.Visible = true
end)

-- =====================================================
-- 6. جعل النافذة قابلة للسحب (للجوال)
-- =====================================================
local dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragStart = input.Position
        startPos = MainFrame.Position
        while game:GetService("UserInputService"):IsTouchInProgress() do
            task.wait()
            local delta = game:GetService("UserInputService"):GetMouseLocation() - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end
end)

print("✅ واجهة Dark Control للجوال تعمل بنجاح!")
print("💜 حقوق الواجهة لـ 9z_e.1 | by Omarshannah1234")
