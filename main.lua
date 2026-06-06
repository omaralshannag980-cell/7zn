local success, redzlib = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"))()
end)

if not success or not redzlib then
    redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/techwearhubofc/Redz/main/Source.lua"))()
end

local Window = redzlib:MakeWindow({
  Title = "DEMOz HUB [ Beta ] : Brookhaven RP",
  SubTitle = "by : 7zn",
  LoadText = "Demoz Hub Troll version",
  Flags = "Demoz Hub | Example.lua"
})

Window:AddMinimizeButton({
  Image = "rbxassetid://130688450838044",
  UICorner = {true, CornerRadius = UDim.new(0.5, 0)},
  UIStroke = {false, {}}
})

task.wait(2)

redzlib:Notification("Test", "Loaded", "success", 3)

local SongsTab = Window:MakeTab({ Name = "Songs & IDs", Icon = "rbxassetid://4483345998" })
local AntiTab = Window:MakeTab({ Name = "Anti-AFK & Anti-Lag", Icon = "rbxassetid://4483345998" })
local CreditsTab = Window:MakeTab({ Name = "Credits", Icon = "rbxassetid://4483345998" })

local LocalPlayer = game:GetService("Players").LocalPlayer
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

LocalPlayer.CharacterAdded:Connect(function(newChar)
    char = newChar
end)

local function playForEveryone(audioId)
    local cleanId = tostring(audioId):match("%d+")
    if not cleanId then
        redzlib:Notification("Warning", "Invalid ID", "error", 3)
        return
    end

    -- هنا يتم استخدام الفحص الذكي للحقيبة والشخصية والتخطي بدون تأثير
    local radio = LocalPlayer.Backpack:FindFirstChild("Radio") or char:FindFirstChild("Radio") 
               or LocalPlayer.Backpack:FindFirstChild("Boombox") or char:FindFirstChild("Boombox") or LocalPlayer.Backpack:FindFirstChild("Music")
    
    if radio then
        local remote = radio:FindFirstChild("Remote") or radio:FindFirstChild("Server") or radio:FindFirstChildOfClass("RemoteEvent")
        if remote and remote:IsA("RemoteEvent") then
            remote:FireServer(cleanId)
            redzlib:Notification("DEMOz HUB", "Playing via Radio", "success", 3)
        else
            local bkrMusic = game:GetService("ReplicatedStorage"):FindFirstChild("MusicRemote") or game:GetService("ReplicatedStorage"):FindFirstChild("SoundEvent")
            if bkrMusic and bkrMusic:IsA("RemoteEvent") then
                bkrMusic:FireServer(cleanId)
                redzlib:Notification("DEMOz HUB", "Playing via Map System", "success", 3)
            else
                redzlib:Notification("Warning", "Radio found but system mismatch", "warning", 3)
            end
        end
    else
        local localSound = game:GetService("Workspace"):FindFirstChild("TaxGGLocalSound")
        if not localSound then
            localSound = Instance.new("Sound", game:GetService("Workspace"))
            localSound.Name = "TaxGGLocalSound"
        end
        localSound.SoundId = "rbxassetid://" .. cleanId
        localSound.Volume = 2
        localSound:Play()
        redzlib:Notification("DEMOz HUB", "Playing Locally", "warning", 4)
    end
end

SongsTab:AddSection({"Music Control (by 7zn)"})

local customTrackID = ""
SongsTab:AddTextBox({"Custom ID", "", function(value)
    customTrackID = value
end})

SongsTab:AddButton({"Play Custom ID", function()
    if customTrackID ~= "" then
        playForEveryone(customTrackID)
    else
        redzlib:Notification("Warning", "Please enter ID", "error", 3)
    end
end})

SongsTab:AddSection({"Track List"})

local userTracks = {
    "95877137552489", "125861618879629", "134693931986753", "107273226047360", 
    "124123680327164", "73721014572224", "87920916682123", "126581313655066", 
    "12412368037164", "79193631928944", "85822106162452", "7984027399", 
    "129963257934687", "93297302504653", "98313375960954", "3230475415", 
    "71701207559451", "106330590409106", "71373562243752", "127666185347295", 
    "9108676586"
}

for index, id in ipairs(userTracks) do
    SongsTab:AddButton({"Track [" .. tostring(index) .. "]", function()
        playForEveryone(id)
    end})
end

AntiTab:AddSection({"Player Protection (Anti-AFK)"})

local antiAFKEnabled = false
AntiTab:AddToggle({"Anti-AFK Toggle", false, function(state)
    antiAFKEnabled = state
    if antiAFKEnabled then
        redzlib:Notification("DEMOz HUB", "Anti-AFK Enabled", "success", 3)
    end
end})

local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    if antiAFKEnabled then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

AntiTab:AddSection({"Performance (Anti-Lag)"})

AntiTab:AddButton({"Clean Map", function()
    local cleared = 0
    local targets = {game:GetService("Workspace"), game:GetService("Lighting")}
    for _, service in pairs(targets) do
        for _, obj in pairs(service:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                obj.Enabled = false
                cleared = cleared + 1
            elseif obj:IsA("PostEffect") then
                obj.Enabled = false
                cleared = cleared + 1
            end
        end
    end
    redzlib:Notification("DEMOz HUB", "Cleaned " .. tostring(cleared) .. " effects", "success", 4)
end})

AntiTab:AddButton({"Potato Mode", function()
    for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:IsA("MeshPart") then
            v.TextureID = ""
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        end
    end
    redzlib:Notification("DEMOz HUB", "Potato Mode Activated", "success", 4)
end})

CreditsTab:AddSection({"Information"})

CreditsTab:AddButton({"Script: DEMOz HUB", function() end})
CreditsTab:AddButton({"Developer: 7zn", function() end})

CreditsTab:AddSection({"Support"})

CreditsTab:AddButton({"TikTok: 9z_e.1", function() 
    setclipboard("9z_e.1")
    redzlib:Notification("DEMOz HUB", "Copied TikTok to Clipboard", "success", 3)
end})
