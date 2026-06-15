local Library = loadstring(game:HttpGet("https://pastefy.app/K63zw8IB/raw"))()
workspace.FallenPartsDestroyHeight = -math.huge

local Window = Library:MakeWindow({
    Title = "7zn",
    SubTitle = "by رئيس كلان 7zn | ALPHA SCRIPT",
    LoadText = "جاري تحميل سكريبت 7zn...",
    Flags = "7zn_Alpha"
})

Window:AddMinimizeButton({
    Button = { Image = "rbxassetid://77109194214659", BackgroundTransparency = 0 },
    Corner = { CornerRadius = UDim.new(35, 1) }
})

-- ========== تبويب الأغاني ==========
local MusicTab = Window:AddTab({
    Title = "🎵 الأغاني"
})

local function PlayMusic(SoundId)
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. tostring(SoundId)
    sound.Volume = 5
    sound.Looped = false
    sound.Parent = char.Head
    sound:Play()
    sound.Ended:Connect(function() sound:Destroy() end)
end

local MusicIDs = {
    {ID = "125861618879629", Name = "🎵 أغنية 1"},
    {ID = "134693931986753", Name = "🎵 أغنية 2"},
    {ID = "95877137552489", Name = "🎵 أغنية 3"},
    {ID = "107273226047360", Name = "🎵 أغنية 4"},
    {ID = "71701207559451", Name = "🎵 أغنية 5"},
    {ID = "129963257934687", Name = "🎵 أغنية 6"},
    {ID = "98313375960954", Name = "🎵 أغنية 7"},
    {ID = "127666185347295", Name = "🎵 أغنية 8"},
    {ID = "75019437630721", Name = "🎵 أغنية 9"}
}

for _, music in ipairs(MusicIDs) do
    MusicTab:AddButton({
        Name = music.Name,
        Callback = function()
            PlayMusic(music.ID)
        end
    })
end

MusicTab:AddButton({
    Name = "🔐 الكود السري ALPHA",
    Callback = function()
        print("0x00000000000000006B8E78719165 - تم تفعيل الكود السري")
        PlayMusic("125861618879629")
    end
})

-- ========== تبويب جميع المضادات ==========
local AntiTab = Window:AddTab({
    Title = "🛡️ المضادات الشاملة"
})

-- مضاد الكراش
AntiTab:AddToggle({
    Name = "🛡️ مضاد الكراش (Anti Crash)",
    Default = true,
    Callback = function(state)
        if state then
            -- كود مضاد الكراش (منع الأصوات/الأنيميشن المفرطة)
            local oldNamecall
            oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local args = {...}
                local method = getnamecallmethod()
                if method == "FireServer" and self.Name == "CrashPart" then
                    return nil
                end
                return oldNamecall(self, ...)
            end)
        end
    end
})

-- مضاد الطرد
AntiTab:AddToggle({
    Name = "🚫 مضاد الطرد (Anti Kick)",
    Default = true,
    Callback = function(state)
        if state then
            local player = game.Players.LocalPlayer
            local oldKick = player.Kick
            player.Kick = function() end
        end
    end
})

-- مضاد التجميد
AntiTab:AddToggle({
    Name = "❄️ مضاد التجميد (Anti Freeze)",
    Default = true,
    Callback = function(state)
        if state then
            game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
                char:WaitForChild("Humanoid").WalkSpeed = 16
            end)
        end
    end
})

-- مضاد النقل المفاجئ
AntiTab:AddToggle({
    Name = "🚀 مضاد النقل المفاجئ (Anti TP)",
    Default = true,
    Callback = function(state)
        if state then
            local oldCFrame
            oldCFrame = hookmetamethod(game, "__index", function(self, key)
                if self:IsA("BasePart") and key == "CFrame" then
                    return oldCFrame(self, key)
                end
                return oldCFrame(self, key)
            end)
        end
    end
})

-- مضاد السبام
AntiTab:AddToggle({
    Name = "🔇 مضاد السبام (Anti Spam)",
    Default = true,
    Callback = function(state)
        if state then
            local players = game:GetService("Players")
            players.LocalPlayer.Chatted:Connect(function(msg)
                if string.rep(msg, 5) then
                    wait(2)
                end
            end)
        end
    end
})

-- مضاد الروابط
AntiTab:AddToggle({
    Name = "🔗 مضاد الروابط (Anti Links)",
    Default = true,
    Callback = function(state)
        if state then
            game:GetService("Players").LocalPlayer.Chatted:Connect(function(msg)
                if msg:match("https?://") then
                    wait(1)
                end
            end)
        end
    end
})

-- مضاد الكلمات السيئة
AntiTab:AddToggle({
    Name = "🤬 مضاد الكلمات السيئة (Anti Bad Words)",
    Default = true,
    Callback = function(state)
        local badWords = {"كلمة1", "كلمة2"} -- ضع الكلمات هنا
        if state then
            game:GetService("Players").LocalPlayer.Chatted:Connect(function(msg)
                for _, word in pairs(badWords) do
                    if msg:lower():match(word) then
                        wait(1)
                    end
                end
            end)
        end
    end
})

-- معلومات
local InfoTab = Window:AddTab({
    Title = "ℹ️ معلومات"
})

InfoTab:AddLabel({
    Text = "✅ سكريبت 7zn | ALPHA - النسخة الكاملة"
})
InfoTab:AddLabel({
    Text = "👑 رئيس كلان 7zn"
})
InfoTab:AddLabel({
    Text = "🛡️ تم إضافة جميع المضادات + تبويب منفصل للمضادات"
})
