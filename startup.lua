---@diagnostic disable: undefined-global
repeat task.wait() until game:IsLoaded()

shared.VapeRemakeLaunched = true

local official_version = loadstring(game:HttpGet('https://raw.githubusercontent.com/s-xdev/Vape-Remake/main/version.lua', true))()
local local_version = loadstring(readfile('vaperemake/version.lua'))()

local getcustomasset = getsynasset or getcustomasset or function(location) return "rbxasset://"..location end
local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request or function() end 

local HTTPService = game:GetService("HttpService")

if local_version ~= official_version then
    game.Players.LocalPlayer:Kick("Version is invalid, But a new update is available!\nUpdate: "..local_version.." -> "..official_version.."\nSave your configuration files and download the repository.")
end

local MainConfigTable = HTTPService:JSONDecode(readfile('vaperemake/main_config.json'))

if MainConfigTable['commands_enabled'] then
    loadstring(readfile('vaperemake/CommandRegister.lua'))()
end

local function MakeFirstTimeUI()
    local VR_FirstTime = Instance.new("ScreenGui")
    local ModeFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local Ghost = Instance.new("ImageButton")
    local ghost_corner = Instance.new("UICorner")
    local Blatant = Instance.new("ImageButton")
    local blatant_corner = Instance.new("UICorner")
    local GhostLabel = Instance.new("TextLabel")
    local BlatantLabel = Instance.new("TextLabel")

    --Properties:

    VR_FirstTime.Name = "VR_FirstTime"
    VR_FirstTime.Parent = game:GetService("CoreGui")
    VR_FirstTime.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    ModeFrame.Name = "ModeFrame"
    ModeFrame.Parent = VR_FirstTime
    ModeFrame.BackgroundColor3 = Color3.fromRGB(13, 13, 13)
    ModeFrame.BackgroundTransparency = 0.300
    ModeFrame.Position = UDim2.new(0.348450482, 0, 0.316981137, 0)
    ModeFrame.Size = UDim2.new(0, 422, 0, 255)

    UICorner.Parent = ModeFrame

    Ghost.Name = "Ghost"
    Ghost.Parent = ModeFrame
    Ghost.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Ghost.BackgroundTransparency = 0.700
    Ghost.Position = UDim2.new(0.0822942629, 0, 0.117647059, 0)
    Ghost.Size = UDim2.new(0, 153, 0, 157)
    Ghost.Image = getcustomasset("vaperemake/assets/CombatIcon.png")

    ghost_corner.Name = "ghost_corner"
    ghost_corner.Parent = Ghost

    Blatant.Name = "Blatant"
    Blatant.Parent = ModeFrame
    Blatant.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Blatant.BackgroundTransparency = 0.700
    Blatant.Position = UDim2.new(0.541147113, 0, 0.117647059, 0)
    Blatant.Size = UDim2.new(0, 153, 0, 157)
    Blatant.Image = getcustomasset("vaperemake/assets/BlatantIcon.png")

    blatant_corner.Name = "blatant_corner"
    blatant_corner.Parent = Blatant

    GhostLabel.Name = "GhostLabel"
    GhostLabel.Parent = ModeFrame
    GhostLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    GhostLabel.BackgroundTransparency = 1.000
    GhostLabel.BorderSizePixel = 0
    GhostLabel.Position = UDim2.new(0.0900473967, 0, 0.768627465, 0)
    GhostLabel.Size = UDim2.new(0, 149, 0, 50)
    GhostLabel.Font = Enum.Font.GothamBold
    GhostLabel.Text = "Ghost"
    GhostLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    GhostLabel.TextSize = 34.000

    BlatantLabel.Name = "BlatantLabel"
    BlatantLabel.Parent = ModeFrame
    BlatantLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    BlatantLabel.BackgroundTransparency = 1.000
    BlatantLabel.BorderSizePixel = 0
    BlatantLabel.Position = UDim2.new(0.54502368, 0, 0.768627465, 0)
    BlatantLabel.Size = UDim2.new(0, 150, 0, 50)
    BlatantLabel.Font = Enum.Font.GothamBold
    BlatantLabel.Text = "Blatant"
    BlatantLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    BlatantLabel.TextSize = 30.000

    return VR_FirstTime
end

if MainConfigTable['is_first_time'] then
    
    local NewFirstTimeUI = MakeFirstTimeUI()

    -- module mode has to be "ghost" or "blatant"

    local decided_mode;

    local GhostConnection;
    local BlatantConnection;

    GhostConnection = NewFirstTimeUI.ModeFrame.Ghost.MouseButton1Down:Connect(function()
        decided_mode = "ghost";
        doImportantStuff()
        GhostConnection:Disconnect();
    end)

    BlatantConnection = NewFirstTimeUI.ModeFrame.Blatant.MouseButton1Down:Connect(function()
        decided_mode = "blatant";
        doImportantStuff()
        BlatantConnection:Disconnect();
    end)

    function doImportantStuff() 
        MainConfigTable['module_type'] = decided_mode;

        game:GetService("CoreGui"):FindFirstChild("VR_FirstTime"):Destroy()

        MainConfigTable['is_first_time'] = false
        local new_config_table = HTTPService:JSONEncode(MainConfigTable)
    
        writefile('vaperemake/main_config.json', new_config_table)
    end

end


