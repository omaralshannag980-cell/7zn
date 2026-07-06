-- // AntiAFK Script by ترفكسا | User: 9z_e.1 \\ --
-- // مناسب لـ Delta Executor // --

-- الخدمات
local VirtualUser = game:GetService("VirtualUser")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local plr = Players.LocalPlayer

-- متغيرات التحكم
local startTime = tick()   -- وقت بداية التشغيل
local running = true       -- هل السكربت شغال؟
local gui                  -- لتخزين الواجهة

-- ------------------------------------------------
-- 1. إنشاء الواجهة (GUI) بالألوان المطلوبة
-- ------------------------------------------------
gui = Instance.new("ScreenGui")
gui.Name = "AntiAFK_GUI"
gui.Parent = plr.PlayerGui

-- الإطار الرئيسي (لون أحمر فخم)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 120)
frame.Position = UDim2.new(0.5, -160, 0.5, -60)
frame.BackgroundColor3 = Color3.fromRGB(160, 0, 0)   -- أحمر غامق أنيق
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 255, 255)  -- أبيض للحدود
frame.BackgroundTransparency = 0
frame.Active = true
frame.Draggable = true   -- خاصية السحب والإفلات
frame.Parent = gui

-- نص "by ترفكسا" (أبيض)
local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 150, 0, 30)
title.Position = UDim2.new(0, 10, 0, 10)
title.BackgroundTransparency = 1
title.Text = "by ترفكسا"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

-- زر النسخ "9z_e.1" (خلفية سوداء، نص أبيض)
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 90, 0, 28)
btn.Position = UDim2.new(1, -100, 0, 10)
btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)   -- أسود فخم
btn.BorderSizePixel = 1
btn.BorderColor3 = Color3.fromRGB(255, 255, 255)    -- إطار أبيض
btn.Text = "9z_e.1"
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.TextSize = 14
btn.Font = Enum.Font.Gotham
btn.Parent = frame

-- عداد الوقت (نص أبيض)
local timer = Instance.new("TextLabel")
timer.Size = UDim2.new(0, 300, 0, 40)
timer.Position = UDim2.new(0, 10, 0, 50)
timer.BackgroundTransparency = 1
timer.Text = "الوقت: 0 ثانية"
timer.TextColor3 = Color3.fromRGB(255, 255, 255)
timer.TextSize = 20
timer.Font = Enum.Font.GothamBold
timer.Parent = frame

-- ------------------------------------------------
-- 2. وظيفة زر النسخ
-- ------------------------------------------------
btn.MouseButton1Click:Connect(function()
    -- محاولة النسخ باستخدام الدالة المناسبة للإكزيوكيتر
    local clip = setclipboard or toClipboard or function() end
    local success = pcall(function()
        clip("9z_e.1")
    end)
    
    if success then
        btn.Text = "✅ تم النسخ!"
        task.wait(1)
        btn.Text = "9z_e.1"
    else
        btn.Text = "❌ خطأ!"
        task.wait(1)
        btn.Text = "9z_e.1"
    end
end)

-- ------------------------------------------------
-- 3. تشغيل نظام AntiAFK + عداد الوقت
-- ------------------------------------------------
-- تفعيل خاصية منع الخمول (لـ Roblox)
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())

-- حلقة لانهائية ولكن بتحكم `running`
spawn(function()
    while running do
        task.wait(1) -- تحديث كل ثانية
        
        -- حساب المدة بالثواني
        local elapsed = math.floor(tick() - startTime)
        timer.Text = "الوقت: " .. elapsed .. " ثانية"
        
        -- كل 60 ثانية نضغط زر وهمي لمنع الخمول
        if elapsed % 60 == 0 then
            VirtualUser:ClickButton2(Vector2.new())
        end
    end
end)

-- ------------------------------------------------
-- 4. إيقاف السكربت عند إغلاق الواجهة أو الخروج
-- ------------------------------------------------
gui.AncestryChanged:Connect(function()
    if not gui.Parent then  -- إذا تم إغلاق الواجهة أو خروج اللاعب
        running = false
        print("تم إيقاف AntiAFK Script.")
    end
end)
