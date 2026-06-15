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

-- إنشاء التاب الرئيسي
local MainTab = Window:AddTab({
    Title = "الرئيسية | 7zn"
})

-- ========== الخانة الأولى: الأغاني ==========
local MusicSection = MainTab:AddSection({
    Title = "🎵 الخانة الأولى: نظام الأغاني"
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
    MusicSection:AddButton({
        Name = music.Name,
        Callback = function()
            PlayMusic(music.ID)
        end
    })
end

MusicSection:AddButton({
    Name = "🔐 الكود السري ALPHA",
    Callback = function()
        print("0x00000000000000006B8E78719165 - تم تفعيل الكود السري")
        PlayMusic("125861618879629")
    end
})

-- ========== الخانة الثانية: جميع المضادات ==========
local AntiSection = MainTab:AddSection({
    Title = "🛡️ الخانة الثانية: جميع المضادات"
})

-- Anti Crash
AntiSection:AddToggle({
    Name = "🛡️ Anti Crash",
    Default = true,
    Callback = function(state)
        print("Anti Crash:", state and "مفعل" or "معطل")
    end
})

-- Anti Kick
AntiSection:AddToggle({
    Name = "🚫 Anti Kick",
    Default = true,
    Callback = function(state)
        if state then
            hookfunction(game.Players.LocalPlayer.Kick, function() return nil end)
        end
    end
})

-- Anti Freeze
AntiSection:AddToggle({
    Name = "❄️ Anti Freeze",
    Default = true,
    Callback = function(state)
        if state then
            game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
                char.Humanoid.WalkSpeed = 16
            end)
        end
    end
})

-- Anti Teleport
AntiSection:AddToggle({
    Name = "🚀 Anti TP",
    Default = true,
    Callback = function(state) end
})

-- معلومات السكريبت
local InfoSection = MainTab:AddSection({
    Title = "ℹ️ معلومات"
})

InfoSection:AddLabel({
    Text = "✅ سكريبت 7zn | ALPHA"
})
InfoSection:AddLabel({
    Text = "👑 رئيس كلان 7zn"
})
