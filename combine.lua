----------------------------ShorterGetServices-----------------------------

local gs = setmetatable({},{
    __index = function(self, key)
        return game:GetService(key)
    end
})

----------------------------Services-----------------------------

local CoreGui = gs.CoreGui
local Players = gs.Players
local Workspace = gs.Workspace
local RunService = gs.RunService
local StarterGui = gs.StarterGui
local HttpService = gs.HttpService
local TweenService = gs.TweenService
local UserInputService = gs.UserInputService
local ReplicatedStorage = gs.ReplicatedStorage
local MarketplaceService = gs.MarketplaceService
local VirtualInputManager = gs.VirtualInputManager

----------------------------LoadServerData-----------------------------

local SvrData = {country = "twist", city = "v5.2"}
gs.NetworkClient.ConnectionAccepted:Connect(function(peer, replicator)
    local ip = peer:sub(1, peer:find("|")-1)
    SvrData = gs.HttpService:JSONDecode(game:HttpGet("http://ip-api.com/json/" .. ip))
end)

----------------------------LoadingBuffer-----------------------------

local networkClient = game:FindService('NetworkClient')
local localPlayer = game.Players.LocalPlayer
local character = localPlayer and localPlayer.Character

local playerGui = localPlayer:WaitForChild('PlayerGui')
local worldTeleportGui1 = playerGui:WaitForChild('WorldTeleport')
local worldTeleportGui2 = worldTeleportGui1:WaitForChild('WorldTeleport')
local isWorldTeleportVisible = worldTeleportGui2.Visible

repeat wait()
until game:IsLoaded() and networkClient and character and localPlayer and not isWorldTeleportVisible

----------------------------LocalVariable-----------------------------

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HRP = Character:WaitForChild('HumanoidRootPart', 180)
local Humanoid = Character:WaitForChild("Humanoid") or Character:FindFirstChildOfClass("Humanoid")


----------------------------ModPath-----------------------------

local MobsMod = require(ReplicatedStorage.Shared.Mobs)
local ItemsMod = require(ReplicatedStorage.Shared.Items)
local DropsMod = require(ReplicatedStorage.Shared.Drops)
local SkillsMod = require(ReplicatedStorage.Shared.Skills)
local CameraMod = require(ReplicatedStorage.Client.Camera)
local CombatMod = require(ReplicatedStorage.Shared.Combat)
local ActionsMod = require(ReplicatedStorage.Client.Actions)
local MissionsMod = require(ReplicatedStorage.Shared.Missions)
local GearPerksMod = require(ReplicatedStorage.Shared.Gear.GearPerks)
local HotbarMod = require(ReplicatedStorage.Client.Gui.GuiScripts.Hotbar)
local WorldDataMod = require(ReplicatedStorage.Shared.Teleport.WorldData)
local WarlordMod = require(ReplicatedStorage.Shared.Combat.Skillsets.Warlord)
local SummonerMod = require(ReplicatedStorage.Shared.Combat.Skillsets.Summoner)

----------------------------PopUpWindow-----------------------------

local funcs = {
    ["createUi"] = function(name, callback)
        local strings = {
            "Loading...",
            "Verified!",
            "twist\nWorld Zero"
        }
        local icons = {
            {
                ["Image"] = "rbxassetid://3926305904",
                ["RectOffset"] = Vector2.new(204, 844),
                ["RectSize"] = Vector2.new(36, 36)
            },
            {
                ["Image"] = "rbxassetid://3926305904",
                ["RectOffset"] = Vector2.new(644, 204),
                ["RectSize"] = Vector2.new(36, 36)
            },
            {
                ["Image"] = "rbxassetid://3926305904",
                ["RectOffset"] = Vector2.new(324, 244),
                ["RectSize"] = Vector2.new(36, 36)
            }
        }
        local screengui = Instance.new("ScreenGui", game.CoreGui)
        local frame = Instance.new("ImageLabel", screengui)
        local text = Instance.new("TextLabel", frame)
        local icon = Instance.new("ImageLabel", frame)
        screengui.Name = "ui"..tostring(math.random(1, 1000))
        frame.Size = UDim2.new(0, 0, 0, 0)
        frame.Position = UDim2.new(0.5, 0, 0.75, 0)
        frame.Image = "rbxassetid://3570695787"
        frame.ImageColor3 = Color3.fromRGB(25, 25, 25)
        frame.BackgroundTransparency = 1
        frame.SliceCenter = Rect.new(100, 100, 100, 100)
        frame.ScaleType = Enum.ScaleType.Slice
        frame.SliceScale = 0.12

        text.Font = Enum.Font.LuckiestGuy
        text.TextColor3 = Color3.fromRGB(255, 255, 255)
        text.TextSize = 20
        text.Text = ""
        text.TextWrapped = true
        text.Size = UDim2.new(1, -50, 1, 0)
        text.Position = UDim2.new(0, 50, 0, 0)
        text.BackgroundTransparency = 1

        icon.Size = UDim2.new(0, 50, 0, 50)
        icon.ImageColor3 = Color3.fromRGB(38, 255, 0)
        icon.Position = UDim2.new(0, 15, 0.5, -25)
        icon.BackgroundTransparency = 1
        icon.Image = ""

        frame:TweenSize(UDim2.new(0, 250, 0, 70))
        frame:TweenPosition(UDim2.new(0.5, -125, 0.75, -35))
        wait(1/3)
        for i,v in pairs(strings) do
            icon.Image = icons[i]["Image"]
            icon.ImageRectOffset = icons[i]["RectOffset"]
            icon.ImageRectSize = icons[i]["RectSize"]
            for i2 = 1, #strings[i] do
                text.Text = string.sub(strings[i], 0, i2)
                wait(0.05)
            end
            wait(1/5)
            for i2 = 1, #strings[i] do
                text.Text = string.sub(strings[i], 0, #strings[i] - i2)
                wait(0.05)
            end
            if i ~= #strings then
                wait(0.5)
            end
        end
        icon.Visible = false
        frame:TweenSize(UDim2.new(0, 0, 0, 0))
        frame:TweenPosition(UDim2.new(0.5, 0, 0.75, 0))
        wait(1/5)
        screengui:Destroy()
        pcall(callback)
    end
}

pcall(funcs.createUi, "Twist", function() end)

repeat wait() until ReplicatedStorage:WaitForChild('Profiles'):FindFirstChild(Player.Name)

----------------------------DungeonID-----------------------------

local dID = {
    [1.1] = 2978696440, 
    [1.2] = 4310464656, 
    [1.3] = 4310476380, 
    [1.4] = 4310478830, 
    [1] = 3383444582, 
    [2.1] = 3885726701, 
    [2.2] = 3994953548, 
    [2.3] = 4050468028, 
    [2] = 3165900886, 
    [3.1] = 4465988196, 
    [3.2] = 4465989351, 
    [3] = 4465989998, 
    [4.1] = 4646473427, 
    [4.2] = 4646475342, 
    [4] = 4646475570, 
    [5.1] = 6386112652, 
    [5.2] = 11466514043, 
    [6.1] = 6510862058, 
    [6.2] = 11533444995, 
    [7.1] = 6847034886,
    [7.2] = 11644048314,
    [8.1] = 9944263348, 
    [8.2] = 10014664329, 
    [9.1] = 10651527284, 
    [9.2] = 10727165164,
    ["HalloweenHub"] = 5862277651,
    ["HolidayEventDungeon"] = 4526768588,
}

----------------------------TowerID-----------------------------

local tID = {
    [1] = 5703353651, 
    [2] = 6075085184, 
    [3] = 7071564842, 
    [4] = 10089970465, 
    [5] = 10795158121, 
}

----------------------------OpenWorldID-----------------------------

local oID = {
    [1] = 4310463616,
    [2] = 4310463940,
    [3] = 4465987684,
    [4] = 4646472003,
    [5] = 5703355191,
    [6] = 6075083204,
    [7] = 6847035264,
    [8] = 9944262922,
    [9] = 10651517727,
}

----------------------------WorldID-----------------------------

local wID = {
    [2978696440] = 1, -- 1-1
    [4310464656] = 3, -- 1-2
    [4310476380] = 2, -- 1-3
    [4310478830] = 4, -- 1-4
    [3383444582] = 6, -- W1 Final
    [3885726701] = 11, -- 2-1
    [3994953548] = 12, -- 2-2
    [4050468028] = 13, -- 2-3
    [3165900886] = 7, --W2 Final
    [4465988196] = 14, -- 3-1
    [4465989351] = 15, -- 3-2
    [4465989998] = 16, --W3 Final
    [4646473427] = 20, -- 4-1
    [4646475342] = 19, -- 4-2
    [4646475570] = 18, -- W4 Final
    [6386112652] = 24, -- 5-1
    [11466514043] = 35, -- 5-2
    [6510862058] = 25, -- 6-1
    [11533444995] = 36, -- 6-2
    [6847034886] = 26, -- 7-1
    [11644048314] = 37, -- 7-2
    [9944263348] = 30, -- 8-1
    [10014664329] = 31, -- 8-2
    [10651527284] = 32, -- 9-1
    [10727165164] = 33, -- 9-2

    [5703353651] = 21, -- T1
    [6075085184] = 23, -- T2
    [7071564842] = 27, -- T3
    [10089970465] = 29, -- T4
    [10795158121] = 34, -- T5

    [5862277651] = 22, -- Halloween
    [4526768588] = 17, -- Holiday
}

----------------------------EggTable-----------------------------

local eggID = {
    'MoltenEgg',
    'OceanEgg',
    'CatEgg',
    'AlligatorEgg',
    'FairyEgg',
}

----------------------------MobWhiteListTab-----------------------------

local mobWL = {
    'SummonerSummonWeak',
    'SummonerSummonStrong',
    'CorruptedGreaterTree',
    'DavyJones',
    'BOSSHogRider',
    'BOSSAnubis',
    --'BOSSKrakenMain',--
    'BOSSKrakenArm3-Arm#1',
    'BOSSKrakenArm3-Arm#2',
    'BOSSKrakenArm3-Arm#3',
    'BOSSKrakenArm3-Arm#4',
    'BOSSKrakenArm3-Arm#5',
    'BOSSKrakenArm3-Arm#6',
    'BOSSKrakenArm3-Arm#7',
    'BOSSKrakenArm3-Arm#8',
}

----------------------------UpValues-----------------------------

local iKey = 0 -- combat numbers like Mage1,Mage2,Mage3 don't change this
local ts = 9/64 -- tweening speed
local timer = 0 -- specific skill delay timer don't change unless you know
local yAxis = 0 -- height of character above mobs
local zAxis = 0 -- front/back distance from mobs
local Circle = 360 -- make this 1 will farm at straight line
local Duration = 5 -- tweening duration
local lastSklUse = 0 -- fireserver remote seperator don't not change
local AttackRange = 0 -- this will later reassign to each class
local uniCooldown = 5/64 -- fireserver remote seperator delay

----------------------------GetChar-----------------------------

local PlayerClass = Character.Properties.Class.Value
local PrimarySkill = {
    ['DualWielder'] = {
        'DualWield1',
        'DualWield2',
        'DualWield3',
        'DualWield4',
        'DualWield5',
        'DualWield6',
        'DualWield7',
        'DualWield8',
        'DualWield9',
        'DualWield10',
    };
    ['Guardian'] = {
        'Guardian1',
        'Guardian2',
        'Guardian3',
        'Guardian4',
    };
    ['Dragoon'] = {
        'Dragoon1',
        'Dragoon2',
        'Dragoon3',
        'Dragoon4',
        'Dragoon5',
        'Dragoon6',
    };
    ['Demon'] = {
        'Demon1',
        'Demon2',
        'Demon3',
        'Demon4',
        'Demon5',
        'Demon6',
        'Demon7',
        'Demon8',
        'Demon9',
        'Demon10',
        'Demon11',
        'Demon12',
        'Demon13',
        'Demon14',
        'Demon15',
        'Demon16',
        'Demon17',
        'Demon18',
        'Demon19',
        'Demon20',
        'Demon21',
        'Demon22',
        'Demon23',
        'Demon24',
        'Demon25',
    };
    ['Warlord'] = {
        'Warlord1',
        'Warlord2',
        'Warlord3',
        'Warlord4',
    };
}

local pSkl = PrimarySkill[PlayerClass]

----------------------------Save&Load Data-----------------------------

local isfile = isfile or is_file
local isfolder = isfolder or is_folder
local writefile = writefile or write_file
local makefolder = makefolder or make_folder or createfolder or create_folder

if makefolder then
    if not isfolder("WorldZero") then
        makefolder("WorldZero")
    end
end
local function LoadData(Name, Table)
    if isfile("WorldZero//"..Name..'.txt') then
        local NewTable = HttpService:JSONDecode(readfile("WorldZero//"..Name..'.txt'))
        table.clear(Table)
        for i,v in pairs(NewTable) do
            Table[i] = v
        end
    else
        writefile("WorldZero//"..Name..'.txt', HttpService:JSONEncode(Table))
    end
end
local function SaveData(Name, Table)
    writefile("WorldZero//"..Name..'.txt', HttpService:JSONEncode(Table))
end

----------------------------Tables-----------------------------

local Toggles = {
    KillAura,
    PetSkill,
    AutoFarm,
    GetDrop,
    NoClip,
    InfJump,
    ReLoadOnHop,
    ReduceLag,
    RepeatRaid,
    NoCutScene,
    DelEgg,
    SellNonLegend,
    AutoSwitch,
    SellLegend,
    AiPing,
    MoLPass,
    MaxPerk,
    HPHalf,
    KlausDown
}
LoadData('WZ_Toggles', Toggles)
local MoreFlag = {
    Webhook = ''
}
LoadData('WZwebhook', MoreFlag)

----------------------------QuequeTeleport-----------------------------


local quequeTeleport = (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport) or queue_on_teleport
local ScriptLink = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/HeiKe2022/wz-v5.2/main/combine.lua"))()'

----------------------------KickRejoin-----------------------------

local Kick = {
    DungeonID = wID[game.PlaceId],
    DifficultyID = MissionsMod.GetDifficulty(),
    ProfileGUID = ReplicatedStorage.Profiles[Player.Name].GUID.Value,
}
SaveData('WZ_Kick', Kick)

----------------------------DetailedCDs-----------------------------

local Melee = {
    ['Swordmaster'] = {
        Swordmaster1 = {last = 0, cooldown = .26},
        Swordmaster2 = {last = 0, cooldown = .26},
        Swordmaster3 = {last = 0, cooldown = .26},
        Swordmaster4 = {last = 0, cooldown = .26},
        Swordmaster5 = {last = 0, cooldown = .26},
        Swordmaster6 = {last = 0, cooldown = .26},
    };
    ['Defender'] = {
        Defender1 = {last = 0, cooldown = .6},
        Defender2 = {last = 0, cooldown = .6},
        Defender3 = {last = 0, cooldown = .6},
        Defender4 = {last = 0, cooldown = .6},
        Defender5 = {last = 0, cooldown = .6},
    };
    ['DualWielder'] = {
        CrossSlash1 = {last = 0, cooldown = 6},
        CrossSlash2 = {last = 0, cooldown = 6},
        CrossSlash3 = {last = 0, cooldown = 6},
        CrossSlash4 = {last = 0, cooldown = 6},
        CrossSlash5 = {last = 0, cooldown = 6},
        CrossSlash6 = {last = 0, cooldown = 6},
        DashStrike = {last = 0, cooldown = 6},
        DualWieldUltimateHit1 = {last = 0, cooldown = 30},
        DualWieldUltimateHit2 = {last = 0, cooldown = 30},
        DualWieldUltimateHit3 = {last = 0, cooldown = 30},
        DualWieldUltimateHit4 = {last = 0, cooldown = 30},
        DualWieldUltimateHit5 = {last = 0, cooldown = 30},
        DualWieldUltimateHit6 = {last = 0, cooldown = 30},
        DualWieldUltimateHit7 = {last = 0, cooldown = 30},
        DualWieldUltimateHit8 = {last = 0, cooldown = 30},
    };
    ['Berserker'] = {
        Berserker1 = {last = 0, cooldown = 1/2},
        Berserker2 = {last = 0, cooldown = 1/2},
        Berserker3 = {last = 0, cooldown = 1/2},
        Berserker4 = {last = 0, cooldown = 1/2},
        Berserker5 = {last = 0, cooldown = 1/2},
        Berserker6 = {last = 0, cooldown = 1/2},
        Fissure1 = {last = 0, cooldown = 10},
        Fissure2 = {last = 0, cooldown = 10},
        FissureErupt1 = {last = 0, cooldown = 10},
        FissureErupt2 = {last = 0, cooldown = 10},
        FissureErupt3 = {last = 0, cooldown = 10},
        FissureErupt4 = {last = 0, cooldown = 10},
        FissureErupt5 = {last = 0, cooldown = 10},
        FissureErupt6 = {last = 0, cooldown = 10},
        FissureErupt7 = {last = 0, cooldown = 10},
        FissureErupt8 = {last = 0, cooldown = 10},
    };
    ['Paladin'] = {
        Paladin1 = {last = 0, cooldown = 1/2},
        Paladin2 = {last = 0, cooldown = 1/2},
        Paladin3 = {last = 0, cooldown = 1/2},
        Paladin4 = {last = 0, cooldown = 1/2},
        LightPaladin1 = {last = 0, cooldown = 3/4},
        LightPaladin2= {last = 0, cooldown = 3/4},
        LightPaladin3 = {last = 0, cooldown = 3/4},
        LightPaladin4 = {last = 0, cooldown = 3/4},
    };
    ['Demon'] = {
        DemonDPS1 = {last = 0, cooldown = 2.8},
        DemonDPS2 = {last = 0, cooldown = 2.8},
        DemonDPS3 = {last = 0, cooldown = 2.8},
        DemonDPS4 = {last = 0, cooldown = 2.8},
        DemonDPS5 = {last = 0, cooldown = 2.8},
        DemonDPS6 = {last = 0, cooldown = 2.8},
        DemonDPS7 = {last = 0, cooldown = 2.8},
        DemonDPS8 = {last = 0, cooldown = 2.8},
        DemonDPS9 = {last = 0, cooldown = 2.8},
    };
}
local Range = {
    ['Mage'] = {
        Mage1 = {last = 0, cooldown = .3},
        Mage2 = {last = 0, cooldown = .3},
        Mage3 = {last = 0, cooldown = .3},
        ArcaneBlast = {last = 0, cooldown = 5},
        ArcaneWave1 = {last = 0, cooldown = 8},
        ArcaneWave2 = {last = 0, cooldown = 8},
        ArcaneWave3 = {last = 0, cooldown = 8},
        ArcaneWave4 = {last = 0, cooldown = 8},
        ArcaneWave5 = {last = 0, cooldown = 8},
        ArcaneWave6 = {last = 0, cooldown = 8},
        ArcaneWave7 = {last = 0, cooldown = 8},
        ArcaneWave8 = {last = 0, cooldown = 8},
        ArcaneWave9 = {last = 0, cooldown = 8},
        ArcaneBlastAOE = {last = 0, cooldown = 15},
    };
    ['IcefireMage'] = {
        IcefireMage1 = {last = 0, cooldown = .3},
        IcefireMage2 = {last = 0, cooldown = .3},
        IcefireMage3 = {last = 0, cooldown = .3},
        IcySpikes1 = {last = 0, cooldown = 6},
        IcySpikes2 = {last = 0, cooldown = 6},
        IcySpikes3 = {last = 0, cooldown = 6},
        IcySpikes4 = {last = 0, cooldown = 6},
        IcySpikes5 = {last = 0, cooldown = 6},
        IcefireMageFireball = {last = 0, cooldown = 10},
        IcefireMageFireballBlast = {last = 0, cooldown = 10},
        LightningStrike1 = {last = 0, cooldown = 15},
        LightningStrike2 = {last = 0, cooldown = 15},
        LightningStrike3 = {last = 0, cooldown = 15},
        LightningStrike4 = {last = 0, cooldown = 15},
        LightningStrike5 = {last = 0, cooldown = 15},
        IcefireMageUltimateFrost = {last = 0, cooldown = 20},
        IcefireMageUltimateMeteor1 = {last = 0, cooldown = 20},
        IcefireMageUltimateMeteor2 = {last = 0, cooldown = 20},
        IcefireMageUltimateMeteor3 = {last = 0, cooldown = 20},
        IcefireMageUltimateMeteor4 = {last = 0, cooldown = 20},
    };
    ['DualWielder'] = {
        DualWieldUltimateSlam = {last = 0, cooldown = 30},
        DualWieldUltimateSlam1 = {last = 0, cooldown = 30},
        DualWieldUltimateSlam2 = {last = 0, cooldown = 30},
        DualWieldUltimateSlam3 = {last = 0, cooldown = 30},
        DualWieldUltimateSword1 = {last = 0, cooldown = 30},
        DualWieldUltimateSword2 = {last = 0, cooldown = 30},
        DualWieldUltimateSword3 = {last = 0, cooldown = 30},
        DualWieldUltimateSword4 = {last = 0, cooldown = 30},
        DualWieldUltimateSword5 = {last = 0, cooldown = 30},
        DualWieldUltimateSword6 = {last = 0, cooldown = 30},
        DualWieldUltimateSword7 = {last = 0, cooldown = 30},
        DualWieldUltimateSword8 = {last = 0, cooldown = 30},
        DualWieldUltimateSword9 = {last = 0, cooldown = 30},
        DualWieldUltimateSword10 = {last = 0, cooldown = 30},
        DualWieldUltimateSword11 = {last = 0, cooldown = 30},
        DualWieldUltimateSword12 = {last = 0, cooldown = 30},
        DualWieldUltimateSword13 = {last = 0, cooldown = 30},
        DualWieldUltimateSword14 = {last = 0, cooldown = 30},
        DualWieldUltimateSword15 = {last = 0, cooldown = 30},
        DualWieldUltimateSword16 = {last = 0, cooldown = 30},
    };
    ['Guardian'] = {
        RockSpikes1 = {last = 0, cooldown = 6},
        RockSpikes2 = {last = 0, cooldown = 6},
        RockSpikes3 = {last = 0, cooldown = 6},
        RockSpikes4 = {last = 0, cooldown = 6},
        RockSpikes5 = {last = 0, cooldown = 6},
        SlashFury1 = {last = 0, cooldown = 8},
        SlashFury2 = {last = 0, cooldown = 8},
        SlashFury3 = {last = 0, cooldown = 8},
        SlashFury4 = {last = 0, cooldown = 8},
        SlashFury5 = {last = 0, cooldown = 8},
        SlashFury6 = {last = 0, cooldown = 8},
        SlashFury7 = {last = 0, cooldown = 8},
        SlashFury8 = {last = 0, cooldown = 8},
        SlashFury9 = {last = 0, cooldown = 8},
        SlashFury10 = {last = 0, cooldown = 8},
        SlashFury11 = {last = 0, cooldown = 8},
        SlashFury12 = {last = 0, cooldown = 8},
        SlashFury13 = {last = 0, cooldown = 8},
        SlashFury14 = {last = 0, cooldown = 8},
        SlashFury15 = {last = 0, cooldown = 8},
        SlashFury16 = {last = 0, cooldown = 8},
    };
    ['Berserker'] = {
        AggroSlam = {last = 0, cooldown = 5},
        GigaSpin1= {last = 0, cooldown = 7},
        GigaSpin2= {last = 0, cooldown = 7},
        GigaSpin3= {last = 0, cooldown = 7},
        GigaSpin4= {last = 0, cooldown = 7},
        GigaSpin5= {last = 0, cooldown = 7},
        GigaSpin6= {last = 0, cooldown = 7},
        GigaSpin7= {last = 0, cooldown = 7},
        GigaSpin8= {last = 0, cooldown = 7},
    };
    ['Paladin'] = {
        LightThrust1 = {last = 0, cooldown = 11},
        LightThrust2 = {last = 0, cooldown = 11},
    };
    ['MageOfLight'] = {
        MageOfLight = {last = 0, cooldown = 1/4},
        MageOfLightBlast = {last = 0, cooldown = .3},
        MageOfLightCharged = {last = 0, cooldown = .2},
        MageOfLightBlastCharged = {last = 0, cooldown = .1},
    };
    ['Demon'] = {
        ScytheThrowDPS1 = {last = 0, cooldown = 10},
        ScytheThrowDPS2 = {last = 0, cooldown = 10},
        ScytheThrowDPS3 = {last = 0, cooldown = 10},
        DemonSoulAOE1 = {last = 0, cooldown = 15},
        DemonSoulAOE2 = {last = 0, cooldown = 15},
        DemonSoulAOE3 = {last = 0, cooldown = 15},
        DemonSoulAOE4 = {last = 0, cooldown = 15},
        DemonLifeStealDPS = {last = 0, cooldown = 16},
        DemonLifeStealAOE = {last = 0, cooldown = 16},
    };
    ['Archer'] = {
        Archer = {last = 0, cooldown = 1/2},
        PiercingArrow1 = {last = 0, cooldown = 5},
        PiercingArrow2 = {last = 0, cooldown = 5},
        PiercingArrow3 = {last = 0, cooldown = 5},
        PiercingArrow4 = {last = 0, cooldown = 5},
        PiercingArrow5 = {last = 0, cooldown = 5},
        SpiritBomb = {last = 0, cooldown = 10},
        MortarStrike1 = {last = 0, cooldown = 12},
        MortarStrike2 = {last = 0, cooldown = 12},
        MortarStrike3 = {last = 0, cooldown = 12},
        MortarStrike4 = {last = 0, cooldown = 12},
        MortarStrike5 = {last = 0, cooldown = 12},
        HeavenlySword = {last = 0, cooldown = 20},
    };
    ['Dragoon'] = {
        DragoonCross1 = {last = 0, cooldown = 5.5},
        DragoonCross2 = {last = 0, cooldown = 5.5},
        DragoonCross3 = {last = 0, cooldown = 5.5},
        DragoonCross4 = {last = 0, cooldown = 5.5},
        DragoonCross5 = {last = 0, cooldown = 5.5},
        DragoonCross6 = {last = 0, cooldown = 5.5},
        DragoonCross7 = {last = 0, cooldown = 5.5},
        DragoonCross8 = {last = 0, cooldown = 5.5},
        DragoonCross9 = {last = 0, cooldown = 5.5},
        DragoonCross10 = {last = 0, cooldown = 5.5},
        DragoonDash = {last = 0, cooldown = 10},
        MultiStrikeDragon1 = {last = 0, cooldown = 12},
        MultiStrikeDragon2 = {last = 0, cooldown = 12},
        MultiStrikeDragon3 = {last = 0, cooldown = 12},
        MultiStrikeDragon4 = {last = 0, cooldown = 12},
        MultiStrikeDragon5 = {last = 0, cooldown = 12},
        MultiStrikeDragon6 = {last = 0, cooldown = 13},
        DragoonFall = {last = 0, cooldown = 12},
        DragoonUltimate = {last = 0, cooldown = 30},
    };
    ['Summoner'] = {
        Summoner1 = {last = 0, cooldown = .01},
        Summoner2 = {last = 0, cooldown = .01},
        Summoner3 = {last = 0, cooldown = .01},
        Summoner4 = {last = 0, cooldown = .01},
    };
    ['Warlord'] = {
        Piledriver1 = {last = 0, cooldown = 3},
        Piledriver2 = {last = 0, cooldown = 3},
        Piledriver3 = {last = 0, cooldown = 3},
        Piledriver4 = {last = 0, cooldown = 3},
        ChainsOfWar = {last = 0, cooldown = 6},
        BlockingWarlord = {last = 0, cooldown = 10},
        WarlordUltimate1 = {last = 0, cooldown = 15},
        WarlordUltimate2 = {last = 0, cooldown = 15},
        WarlordUltimate3 = {last = 0, cooldown = 15},
        WarlordUltimate4 = {last = 0, cooldown = 15},
        WarlordUltimate5 = {last = 0, cooldown = 15},
    };
}

----------------------------Function-----------------------------

local function pressKey(key)
    VirtualInputManager:SendKeyEvent(true, key, false, game)
end
local function releaseKey(key)
    VirtualInputManager:SendKeyEvent(false, key, false, game)
end

local function ReadableNumber(Number)
    local Suffixes = {"K", "M", "B", "T", "Q", "Qu", "S", "Se", "O", "N", "D"}
    Number = tostring(Number):match("$.*") and tostring(Number):sub(2) or tostring(Number)
    local i = math.floor(math.log(Number, 1e3))
    local v = math.pow(10, i * 3)
    return ("%s%s"):format(("%.1f"):format(Number / v):gsub("%.?0+$", ""), (Suffixes[i] or ""))
end

local function IsAMelee()
    local melee_classes = {
      'Swordmaster',
      'Defender',
      'DualWielder',
      'Berserker',
      'Guardian',
      'Paladin',
      'Dragoon',
      'Demon',
      'Warlord',
    }
    for _, class in ipairs(melee_classes) do
      if PlayerClass == class then
        return true
      end
    end
    return false
end

local function IsARange()
    local range_classes = {
      'Mage',
      'IcefireMage',
      'MageOfLight',
      'Archer',
      'Summoner',
    }
    for _, class in ipairs(range_classes) do
      if PlayerClass == class then
        return true
      end
    end
    return false
  end
  

local function skillReady(lastSklUse)
    return os.clock() - lastSklUse > uniCooldown
end

local function HasOffhand()
    local offhand_folder = ReplicatedStorage.Profiles[Player.Name].Equip.Offhand
    return not offhand_folder:IsEmpty()
end

function IsAlive()
    local hrp = game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart')
    return hrp ~= nil
end

local function noClip(State)
    if IsAlive() then
        HRP.CanCollide = State
    end
end

local function bvCreate()
    if not HRP:FindFirstChild('BodyVelocity') then
        local BodyVelocity = Instance.new'BodyVelocity'
        BodyVelocity.Velocity = Vector3.new(0, 0, 0)
        BodyVelocity.MaxForce = Vector3.new(900000, 900000, 900000)
        BodyVelocity.P = 9000
        BodyVelocity.Parent = HRP
    end
end
local function bvDelete()
    for _,v in pairs(HRP:GetChildren()) do
        if v:IsA('BodyVelocity') then
            v:Destroy()
        end
    end
end

local function StartRaid()
    for _,ow in pairs(oID) do
        if game.PlaceId ~= ow then
            if Workspace:WaitForChild('MissionObjects'):FindFirstChild('MissionStart') then
                for _,v in pairs(Workspace.MissionObjects.MissionStart:GetDescendants()) do
                    if v:IsA('TouchTransmitter') and v.Parent then
                        v.Parent.CFrame = HRP.CFrame
                    end
                end
            end
        end
    end
end

local function TouchTrans()
    if IsAlive() then
        for _,v in pairs(Character:GetChildren()) do
            if v:IsA('BasePart') and v.Name == ('Collider') then
                v.Touched:Connect(function(part)
                    if part:IsA('BasePart') and part.Transparency ~= 1 then
                        if part.Parent ~= Character then
                            local newtrans = .3
                            part.Transparency = newtrans
                            local newcolor = Color3.fromRGB(140,140,140)
                            part.Color = newcolor
                        end
                    end
                end)
            end
        end
    end
end

local IsExtraDrop = ReplicatedStorage.Shared.VIP.IsExtraDrop:InvokeServer()

local function click(Button)
    VirtualInputManager:SendMouseButtonEvent(Button.AbsolutePosition.X+Button.AbsoluteSize.X/2,Button.AbsolutePosition.Y+50,0,true,Button,1)
    VirtualInputManager:SendMouseButtonEvent(Button.AbsolutePosition.X+Button.AbsoluteSize.X/2,Button.AbsolutePosition.Y+50,0,false,Button,1)
end

local function SwitchToPerk(Target)
    local OffhandWeapon = ReplicatedStorage.Profiles[Player.Name].Equip.Offhand:FindFirstChildOfClass("Folder")
    local HealthProperties = Target.HealthProperties
    local MaxHealth = HealthProperties.MaxHealth
    local EliteCheck = require(ReplicatedStorage.Shared.Mobs).IsElite
    local MobMod = require(ReplicatedStorage.Shared.Mobs.Mobs[Target.Name])
    local Perks2Use = ''
    if MobMod.BossTag ~= false then
        Perks2Use = 'TestTier5'
    elseif MobMod.BossTag == false then
        if EliteCheck(Target) then
            Perks2Use = 'EliteBoss'
        else
            Perks2Use = 'MobBoss'
        end
    end
    if math.floor(HealthProperties.Health.Value / MaxHealth.Value * 100) >= 75 then      
        if OffhandWeapon and OffhandWeapon:FindFirstChild("Perk3") and OffhandWeapon:FindFirstChild("Perk3").Value == 'OpeningStrike' then
            ReplicatedStorage.Shared.Settings.OffhandPerksActive:FireServer(true)
            repeat wait() until math.floor(HealthProperties.Health / MaxHealth * 100) < 75
        else
            ReplicatedStorage.Shared.Settings.OffhandPerksActive:FireServer(false)
        end
    end
    if OffhandWeapon and OffhandWeapon:FindFirstChild("Perk3") and OffhandWeapon:FindFirstChild("Perk3").Value == Perks2Use then
        ReplicatedStorage.Shared.Settings.OffhandPerksActive:FireServer(true)
    else
        ReplicatedStorage.Shared.Settings.OffhandPerksActive:FireServer(false)
    end
end

local TeleportSpeed = 100
local NextFrame = RunService.Heartbeat
local function Teleport(Target)
    if (typeof(Target) == "Instance" and Target:IsA("BasePart")) then Target = Target.Position end
    if (typeof(Target) == "CFrame") then Target = Target.p end
    if (not HRP) then return end
    local StartingPosition = HRP.Position
    local PositionDelta = (Target - StartingPosition)
    local StartTime = tick()
    local TotalDuration = (StartingPosition - Target).magnitude / TeleportSpeed
    repeat NextFrame:Wait()
        local Delta = tick() - StartTime
        local Progress = math.min(Delta / TotalDuration, 1)
        local MappedPosition = StartingPosition + (PositionDelta * Progress)
        HRP.Velocity = Vector3.new()
        HRP.CFrame = CFrame.new(MappedPosition)
    until (HRP.Position - Target).magnitude <= TeleportSpeed / 2
    HRP.Anchored = false
    local xOffset, yOffset, zOffset = 0, 0, 12
    HRP.CFrame = CFrame.new(Target) + Vector3.new(xOffset, yOffset, zOffset)
end

local function NetworkOffset(GlobalCD)
    GlobalCD = 0
    task.spawn(function()
        while Toggles.KillAura do
            local Ping = math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
            if Ping > 150 and Toggles.AiPing then
                GlobalCD = Ping / 1200
            else
                GlobalCD = 0
            end
            task.wait()
        end
    end)
    return GlobalCD
end

----------------------------TargetLocator-----------------------------

local function TargetLocator(Target)
    local Distance = math.huge
    for _,v in pairs(Workspace.Mobs:GetChildren()) do
        if not table.find(mobWL, v.Name) then
            if v:FindFirstChild('Collider') and v:FindFirstChild('HealthProperties') and not v:FindFirstChild('NoHealthbar') then
                local Delta = math.floor((HRP.Position - v.WorldPivot.Position).Magnitude)
                if Delta <= Distance and v.HealthProperties.Health.Value > 0 then
                    Distance = Delta
                    Target = v.Collider
                end
            end
        end
    end
    if game.PlaceId == dID[1] then
        if Workspace.Mobs:FindFirstChild('BOSSTreeEnt') and Workspace.Mobs.BOSSTreeEnt.HealthProperties.Health.Value/Workspace.Mobs.BOSSTreeEnt.HealthProperties.MaxHealth.Value*100<=50 then
            for i = 1, 3 do
                local Pillar = Workspace:WaitForChild('Pillar' .. i)
                if Pillar:FindFirstChild('HealthProperties') and Pillar.HealthProperties.Health.Value ~= 0 then
                    Target = Pillar.Base
                end
            end
        end
    end
    if game.PlaceId == dID[3.2] then
        if Player.PlayerGui.MissionObjective.MissionObjective.Label.Text == 'Destroy the Ice Barricade!' then
            if Workspace.MissionObjects.IceBarricade:FindFirstChild('HealthProperties') and Workspace.MissionObjects.IceBarricade.HealthProperties.Health.Value ~= 0 then
                Target = Workspace.MissionObjects.IceBarricade.Part
            end
        end
    end
    if game.PlaceId == dID[3] then
        if game.PlaceId == dID[3] then
            for i = 1, 3 do
                local Spike = Workspace.MissionObjects.SpikeCheckpoints:WaitForChild('Blocker' .. i)
                if Spike:FindFirstChild('HealthProperties') and Spike.HealthProperties.Health.Value ~= 0 then
                    Target = Spike.Part
                end
            end
        end
        if Workspace.Mobs:FindFirstChild('BOSSWinterfallIceDragon') and Workspace.Mobs.BOSSWinterfallIceDragon.Collider.Position.y > 300 then
            Target = nil
        end
    end
    if game.PlaceId == dID[4.1] then
        if Workspace.MissionObjects.TowerLegs:FindFirstChild('Model') and Workspace.MissionObjects.TowerLegs.Model:FindFirstChild('HealthProperties') then
            Target = Workspace.MissionObjects.TowerLegs.Model.hitbox
        end
        if Workspace.Mobs:FindFirstChild('BOSSHogRider') and Workspace.Mobs.BOSSHogRider.Collider.Position.y < 380 then
            Target = Workspace.Mobs.BOSSHogRider.Collider
        end
    end
    if game.PlaceId == dID[4] then
        if Workspace.Mobs:FindFirstChild('BOSSAnubis') then
            if not Workspace.Mobs.BOSSAnubis.MobProperties.Busy:FindFirstChild('Shield') then
                Target = Workspace.Mobs.BOSSAnubis.Collider
            end
        end
    end
    if game.PlaceId == dID[5.1] and Workspace.Mobs:FindFirstChild('CorruptedGreaterTree') then
        if not Workspace:FindFirstChild('GreaterTreeShield') then
            Target = Workspace.Mobs.CorruptedGreaterTree.Collider
        end
    end
    if game.PlaceId == dID[6.1] then
        if Workspace.Mobs:FindFirstChild('DavyJones') and not Target then
            Target = Workspace.Mobs.DavyJones.Collider
        end
        if Workspace:FindFirstChild('TriggerBarrel') then
            Target = Workspace.TriggerBarrel.Collision
        end
    end
    if game.PlaceId == tID[2] then
        if Workspace.Mobs:FindFirstChild('BOSSKrakenMain') then
            for i = 1, 8 do
                local KrakenArm = workspace.Mobs:FindFirstChild('BOSSKrakenArm3-Arm#' .. i)
                if KrakenArm and KrakenArm.HealthProperties.Health.Value ~= 0 then
                    Target = KrakenArm.Subcollider.SubPrimaryPart
                end
            end
        end
    end
    return Target
end

local function MobLocator(Mob)
    local Distance = math.huge
    for _,v in pairs(Workspace.Mobs:GetChildren()) do
        if not table.find(mobWL, v.Name) then
            if v:FindFirstChild('Collider') and v:FindFirstChild('HealthProperties') and not v:FindFirstChild('NoHealthbar') then
                local Delta = math.floor((HRP.Position - v.WorldPivot.Position).Magnitude)
                if Delta <= Distance and v.HealthProperties.Health.Value > 0 then
                    Distance = Delta
                    Mob = v
                end
            end
        end
    end
    return Mob
end

local function ExplosionLocator(Victim)
    local Distance = math.huge
    if Workspace.Mobs:FindFirstChild('SummonerSummonWeak') then
        for _,v in pairs(Workspace.Mobs:GetChildren()) do
            if not table.find(mobWL, v.Name) then
                if v:FindFirstChild('Collider') and v:FindFirstChild('HealthProperties') then
                    local Delta = (Workspace.Mobs.SummonerSummonWeak.WorldPivot.Position - v.WorldPivot.Position).Magnitude
                    if Delta <= Distance and v.HealthProperties.Health.Value>8000 then
                        Distance = Delta
                        Victim = v.Collider
                    end
                end
            end
        end
    end
    return Victim
end

----------------------------AtkRange&CDs-----------------------------

if PlayerClass == 'Mage' then
    AttackRange = 60; uniCooldown = uniCooldown + NetworkOffset()
elseif PlayerClass == 'Swordmaster' then
    AttackRange = 15; uniCooldown = uniCooldown + NetworkOffset()
elseif PlayerClass == 'Defender' then
    AttackRange = 15; uniCooldown = uniCooldown + NetworkOffset()
elseif PlayerClass == 'DualWielder' then
    AttackRange = 15; timer = 9/64 + NetworkOffset()
elseif PlayerClass == 'Berserker' then
    AttackRange = 15; uniCooldown = uniCooldown + NetworkOffset()
elseif PlayerClass == 'Guardian' then
    AttackRange = 15; timer = 1/3 + NetworkOffset()
elseif PlayerClass == 'Paladin' then
    AttackRange = 20; uniCooldown = uniCooldown + NetworkOffset()
elseif PlayerClass == 'IcefireMage' then
    AttackRange = 95; uniCooldown = uniCooldown + NetworkOffset()
elseif PlayerClass == 'MageOfLight' then
    AttackRange = 95; uniCooldown = uniCooldown + NetworkOffset()
elseif PlayerClass == 'Dragoon' then
    AttackRange = 15; timer = 9/64 + NetworkOffset()
elseif PlayerClass == 'Demon' then
    AttackRange = 15; timer = .5 + NetworkOffset()
elseif PlayerClass == 'Archer' then
    AttackRange = 80; uniCooldown = uniCooldown + NetworkOffset()
elseif PlayerClass == 'Summoner' then
    AttackRange = 80; uniCooldown = 1/2 + NetworkOffset()
elseif PlayerClass == 'Warlord' then
    AttackRange = 15; timer = 5/64 + NetworkOffset()
end

----------------------------KillAuras-----------------------------

local function RangeKA()
    task.spawn(function()
      while Toggles.KillAura and IsAlive() do
        local Target = TargetLocator()
        if Target and Target.Parent:FindFirstChild("HealthProperties") and Target.Parent.HealthProperties.Health.Value < 1 then break end
        if Target and (HRP.Position - Target.Position).Magnitude < AttackRange then
          for Ability, v in pairs(Range[PlayerClass]) do
            if os.clock() - v.last > v.cooldown and skillReady(lastSklUse) then
              CombatMod:AttackWithSkill(Ability, Target.Position)
              v.last = os.clock()
              lastSklUse = os.clock()
            end
          end
        end
        task.wait()
      end
    end)
end
  
local function MeleeKA()
    task.spawn(function()
      while Toggles.KillAura and IsAlive() do
        local Target = TargetLocator()
        if Target and Target.Parent:FindFirstChild("HealthProperties") and Target.Parent.HealthProperties.Health.Value < 1 then break end
        if Target and (HRP.Position - Target.Position).Magnitude < AttackRange then
          for Ability, v in pairs(Melee[PlayerClass]) do
            if os.clock() - v.last > v.cooldown and skillReady(lastSklUse) then
              CombatMod:AttackWithSkill(Ability, HRP.Position, HRP.CFrame.lookVector)
              v.last = os.clock()
              lastSklUse = os.clock()
              break
            end
          end
        end
        task.wait()
      end
    end)
end
  
local function HiKA()
    task.spawn(function()
      local DeBounce = os.clock()
      while Toggles.KillAura and IsAlive() do
        local Target = TargetLocator()
        if Target and Target.Parent:FindFirstChild("HealthProperties") and Target.Parent.HealthProperties.Health.Value < 1/6 then break end
        if Target and (HRP.Position - Target.Position).Magnitude < AttackRange and os.clock() - DeBounce >= timer then
          DeBounce = os.clock()
          iKey = iKey + 1
          CombatMod:AttackWithSkill(pSkl[iKey], HRP.Position, HRP.CFrame.lookVector)
          RunService.RenderStepped:Wait()
          if iKey >= #pSkl then iKey = 0 end
        end
        RunService.RenderStepped:Wait()
      end
    end)
end
  
----------------------------DetailedKillAura-----------------------------

local function DWRythm()
    task.spawn(function()
        local DeBounce = os.clock()
        while Toggles.KillAura and IsAlive() do
            local Target = TargetLocator()
            if Target and Target.Parent:FindFirstChild'HealthProperties' and Target.Parent.HealthProperties.Health.Value < 1 then break end
            if Target and (HRP.Position - Target.Position).Magnitude < 500 and os.clock() - DeBounce >= 12 then
                DeBounce = os.clock()
                ReplicatedStorage.Shared.Combat.Skillsets.DualWielder.AttackBuff:FireServer()
                ReplicatedStorage.Shared.Combat.Skillsets.DualWielder.UpdateSpeed:FireServer(0)
            end
            task.wait(12)
        end
    end)
end

local function Guardian()
    task.spawn(function()
        local Skill = HotbarMod.GetHotbarSkillTile('', 'Ultimate')
        while Toggles.KillAura and IsAlive() do
            if Skill.cooling and not Toggles.KillAura then break end
            local Target = MobLocator()
            if Target and IsAlive() then
            if Target and Target:FindFirstChild'HealthProperties' and Target.HealthProperties.Health.Value < 1 then break end
                VirtualInputManager:SendKeyEvent(true, 'X', false, game) wait(1/2)
                VirtualInputManager:SendKeyEvent(false, 'X', false, game)
            end
            task.wait(30)
        end
    end)
end

local function Demon()
     task.spawn(function()
        DeBounce = os.clock()
        local Skill = HotbarMod.GetHotbarSkillTile('', 'Ultimate')
        while Toggles.KillAura and IsAlive() do
            if Skill.cooldownTimer > 20 and not Toggles.KillAura then break end
            if os.clock() - DeBounce >= 2 then DeBounce = os.clock()
                ReplicatedStorage.Shared.Combat.Skillsets.Demon.Demonic:FireServer()
                ReplicatedStorage.Shared.Combat.Skillsets.Demon.Demonic:FireServer()
                ReplicatedStorage.Shared.Combat.Skillsets.Demon.Demonic:FireServer()
                ReplicatedStorage.Shared.Combat.Skillsets.Demon.Demonic:FireServer()
                ReplicatedStorage.Shared.Combat.Skillsets.Demon.Demonic:FireServer()
                ReplicatedStorage.Shared.Combat.Skillsets.Demon.Demonic:FireServer() wait()
            if Skill.cooldownTimer > 1 and not Toggles.KillAura then break end
                ReplicatedStorage.Shared.Combat.Skillsets.Demon.Ultimate:FireServer()
            end
            task.wait(30)
        end
    end)
end

local function Archer()
    yAxis, zAxis, Duration = 30, 26, 6
    task.spawn(function()
        while Toggles.KillAura and IsAlive() do
            local Target = MobLocator()
            local coolDown = ActionsMod:IsOnCooldown('Ultimate')
            if Target and (HRP.Position - Target.Collider.Position).Magnitude < 80 and Workspace.Characters[Player.Name].Properties.BackSwordCount.Value == 6 then
            if Target and Target.HealthProperties.Health.Value < 1/6 or coolDown then break end
                DeBounce = os.clock()
                yAxis, zAxis, Duration = 3/64, 16, 66 task.wait(1)
                ReplicatedStorage.Shared.Combat.Skillsets.Archer.Ultimate:FireServer(Target.Collider.Position)
                task.wait(1) yAxis, zAxis, Duration = 26, 26, 6
            end
            task.wait(30)
        end
    end)
end

local function Summoner()
    task.spawn(function()
        local DeBounce = os.clock()
        while Toggles.KillAura and IsAlive() do
            local Target = MobLocator()
            if Target and Target:FindFirstChild'HealthProperties' and Target.HealthProperties.Health.Value < 1/6 then break end
               if Target and Workspace.Characters[Player.Name].Properties.SummonCount.Value == 5 and os.clock() - DeBounce >= 8 then
                DeBounce = os.clock()
                SummonerMod:Summon(Target.Collider.Position)
            end
            task.wait(8)
        end
    end)
    task.spawn(function()
        local DeBounce = os.clock()
        while Toggles.KillAura and IsAlive() do
            local Target = TargetLocator()
            if Target and Target.Parent:FindFirstChild'HealthProperties' and Target.Parent.HealthProperties.Health.Value < 1/6 then break end
            if Target and (HRP.Position - Target.Position).Magnitude < 50 and os.clock() - DeBounce >= 10 then
                DeBounce = os.clock()
                ReplicatedStorage.Shared.Combat.Skillsets.Summoner.SoulHarvest:FireServer(Target.Position)
            end
            task.wait(10)
        end
    end)
    task.spawn(function()
        local DeBounce = os.clock()
        while Toggles.KillAura and IsAlive() do
            local Target = MobLocator()
            if Target and os.clock() - DeBounce >= 30 then
            if Target and Target:FindFirstChild'HealthProperties' and Target.HealthProperties.Health.Value < 1/6 then break end
                DeBounce = os.clock()
                SummonerMod:Ultimate(Target.Collider.Position)
            end
            task.wait(30)
        end
    end)
    task.spawn(function()
        local DeBounce = os.clock()
        while Toggles.KillAura and IsAlive() do
            local Target = ExplosionLocator()
            if Target and Workspace.Mobs:FindFirstChild('SummonerSummonWeak') then
            if not IsAlive() then break end
                local Delta = (Workspace.Mobs.SummonerSummonWeak.Collider.Position - Target.Position).Magnitude
                if Delta < 8 and HRP and os.clock() - DeBounce >= 2 then
                    DeBounce = os.clock()
                    SummonerMod:ExplodeSummons()
                end
            end
            task.wait(2)
        end
    end)
end

local function Warlord()
    task.spawn(function()
        local DeBounce = os.clock()
        while Toggles.KillAura and IsAlive() do
            if not IsAlive() then break end
            if os.clock() - DeBounce >= 1/3 then
                DeBounce = os.clock()
                ReplicatedStorage.Shared.Combat.Skillsets.Warlord.Block:FireServer()
            end
            task.wait(1/3)
        end
    end)
end

----------------------------FleetheDamage-----------------------------

local connection = nil
connection = Workspace.ChildAdded:Connect(function(Radial)
    if Radial.Name == 'RadialIndicator' then
        local Mob = MobLocator()
        if Mob and not MobsMod:GetBossTag(Mob) and Workspace.RadialIndicator.Inner.Size.y > 20 then
            Circle = 1
        end
    end
end)
Workspace.ChildRemoved:Connect(function(Radial)
    if Radial.Name == 'RadialIndicator' then
        if connection then
            connection:Disconnect()
        end
        Circle = 360
    end
end)


----------------------------UI Library-----------------------------

Library = loadstring(game:HttpGet("https://bitbucket.org/cat__/turtle-ui/raw/main/Module%20v2"), "Turtle UI")()

local WinA = Library:Window({   
    Title = game:GetService('MarketplaceService'):GetProductInfo(game.PlaceId).Name,
    TextSize = 18,
    Font = Enum.Font.LuckiestGuy,
    TextColor = Color3.fromRGB(222, 248, 107),
    FrameColor = Color3.fromRGB(63, 72, 80),
    BackgroundColor = Color3.fromRGB(35, 35, 35),
})

local WinB = Library:Window({
    Title = "Start: "..os.date("%I:%M %p"),
    TextSize = 18,
    Font = Enum.Font.LuckiestGuy,
    TextColor = Color3.fromRGB(222, 248, 107),
    FrameColor = Color3.fromRGB(63, 72, 80),
    BackgroundColor = Color3.fromRGB(35, 35, 35),
})

local WinC = Library:Window({
    Title = (SvrData.country.." | "..SvrData.city),
    TextSize = 20,
    Font = Enum.Font.LuckiestGuy,
    TextColor = Color3.fromRGB(222, 248, 107),
    FrameColor = Color3.fromRGB(63, 72, 80),
    BackgroundColor = Color3.fromRGB(35, 35, 35),
})

local WinD = Library:Window({
    Title = "Gold: "..ReadableNumber(game.ReplicatedStorage.Profiles[Player.Name].Currency.Gold.Value),
    TextSize = 18,
    Font = Enum.Font.LuckiestGuy,
    TextColor = Color3.fromRGB(222, 248, 107),
    FrameColor = Color3.fromRGB(63, 72, 80),
    BackgroundColor = Color3.fromRGB(35, 35, 35),
})

local WinE = Library:Window({
    Title = "Running",
    TextSize = 20,
    Font = Enum.Font.LuckiestGuy,
    TextColor = Color3.fromRGB(222, 248, 107),
    FrameColor = Color3.fromRGB(63, 72, 80),
    BackgroundColor = Color3.fromRGB(35, 35, 35),
})

local WinF = Library:Window({
    Title = "Ping: "..math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue()),
    TextSize = 18,
    Font = Enum.Font.LuckiestGuy,
    TextColor = Color3.fromRGB(222, 248, 107),
    FrameColor = Color3.fromRGB(63, 72, 80),
    BackgroundColor = Color3.fromRGB(35, 35, 35),
})

local WinG = Library:Window({
    Title = "Misc",
    TextSize = 18,
    Font = Enum.Font.LuckiestGuy,
    TextColor = Color3.fromRGB(222, 248, 107),
    FrameColor = Color3.fromRGB(63, 72, 80),
    BackgroundColor = Color3.fromRGB(35, 35, 35),
})

local KillAura = WinA:Toggle({
    Text = "KillAura",
    TextSize = 22,
    TextColor = Color3.fromRGB(255, 187, 109),
    Font = Enum.Font.FredokaOne,
    Disable = true,
    Enabled = Toggles.KillAura,
    Callback = function(State)
    task.spawn(function()
        Toggles.KillAura = State
        if Toggles.KillAura then
            SaveData('WZ_Toggles', Toggles)
            if PlayerClass == 'Guardian' then
                Guardian()
            elseif PlayerClass == 'Demon' then
                Demon()
            elseif PlayerClass == 'Archer' then
                Archer()
            elseif PlayerClass == 'Summoner' then
                Summoner()
            elseif PlayerClass == 'Warlord' then
                Warlord()
            end
            for craft in pairs(Range) do
                if craft == PlayerClass then
                    RangeKA()
                    DWRythm()
                end
            end
            for craft in pairs(Melee) do
                if craft == PlayerClass then
                    MeleeKA()
                    DWRythm()
                end
            end
            for craft in pairs(PrimarySkill) do
                if craft == PlayerClass then
                    HiKA()
                end
            end
        end
    end)
end})

local PetSkill = WinA:Toggle({
    Text = "PetSkill",
    TextSize = 22,
    TextColor = Color3.fromRGB(255, 187, 109),
    Font = Enum.Font.FredokaOne,
    Disable = true,
    Enabled = Toggles.PetSkill,
    Callback = function(State)
    task.spawn(function()
        Toggles.PetSkill = State
        SaveData('WZ_Toggles', Toggles)
        while Toggles.PetSkill do
            pressKey(Enum.KeyCode.One)
            wait()
            releaseKey(Enum.KeyCode.One)
            wait(15)
        end
    end)
end})


----------------------------HP<1/2Protection-----------------------------

local HPHalf = WinE:Toggle({
    Text = "HP-Half Fly",
    TextSize = 22,
    TextColor = Color3.fromRGB(255, 187, 109),
    Font = Enum.Font.FredokaOne,
    Enabled = Toggles.HPHalf,
    Callback = function(State)
    Toggles.HPHalf = State
    task.spawn(function()
        SaveData('WZ_Toggles', Toggles)
        for _,v in pairs(oID) do
            if game.PlaceId ~= v and Toggles.HPHalf then
                Player.Character.HealthProperties.Health:GetPropertyChangedSignal('Value'):Connect(function()
                    pcall(function()
                    if IsAlive() and Player.Character.HealthProperties.Health.Value/Player.Character.HealthProperties.MaxHealth.Value*100<50 then
                        yAxis, zAxis, ts, Duration = 50, 40, 1, 3
                        repeat wait(1)
                        until Player.Character.HealthProperties.Health.Value/Player.Character.HealthProperties.MaxHealth.Value*100>90
                        if IsARange() then
                            yAxis, zAxis, Duration = 36, 30, 6
                        elseif IsAMelee() then
                            yAxis, zAxis, Duration = .1, 14, 5
                        end
                    end
                    if Toggles.HPHalf == false then
                        Player.Character.HealthProperties.Health:GetPropertyChangedSignal('Value'):Disconnect()
                    end
                    end)
                end)
            end
        end
    end)
end})


local AutoFarm = WinA:Toggle({
    Text = "AutoFarm",
    TextSize = 22,
    TextColor = Color3.fromRGB(255, 187, 109),
    Font = Enum.Font.FredokaOne,
    Disable = true,
    Enabled = Toggles.AutoFarm,
    Callback = function(State)
    Toggles.AutoFarm = State
    task.spawn(function()
        SaveData('WZ_Toggles', Toggles)
        if IsARange() then
            yAxis, zAxis, Duration = 36, 30, 6
        elseif IsAMelee() then
            yAxis, zAxis, Duration = .1, 14, 5
        end
        if Toggles.AutoFarm then
            bvCreate(); TouchTrans(); noClip(false); StartRaid()
        end
        if not Toggles.AutoFarm then
            noClip(true); bvDelete()
        end
    end)
    task.spawn(function()
        local Tween
        local TweeningInfo = TweenInfo.new(ts, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
        while Toggles.AutoFarm do
            local Target = TargetLocator()
            if Target and Target.Parent:FindFirstChild('HealthProperties') and Target.Parent.HealthProperties.Health.Value < 1/6 then break end
            if Target then
                local Degree = Circle * (tick() % Duration)/Duration
                Tween = TweenService:Create(HRP, TweeningInfo, {CFrame = CFrame.new(Target.Position) * CFrame.Angles(0, math.rad(Degree), 0) * CFrame.new(0, yAxis, zAxis)})
                Tween:Play()
            end
            RunService.Heartbeat:Wait()
        end
        if Tween and Tween.PlaybackState == Enum.PlaybackState.Playing then
            Tween:Cancel()
        end
        if not Toggles.AutoFarm then
            bvDelete()
        end
    end)
end})

local GetDrops = WinA:Toggle({
    Text = "GetDrops",
    TextSize = 22,
    TextColor = Color3.fromRGB(255, 187, 109),
    Font = Enum.Font.FredokaOne,
    Enabled = Toggles.GetDrop,
    Callback = function(State)
    Toggles.GetDrop = State
    task.spawn(function()
        SaveData('WZ_Toggles', Toggles)
        local item_drops = getupvalue(DropsMod.Start, 4)
        while Toggles.GetDrop do
            if not Toggles.GetDrop then break end
            for i, v in pairs(item_drops) do
                v.model:Destroy()
                v.followPart:Destroy()
                ReplicatedStorage.Shared.Drops.CoinEvent:FireServer(v.id)
                table.remove(item_drops, i)
            end
            task.wait(1/3)
        end
    end)
end})

local Levitating = WinA:Toggle({
    Text = "Levitating",
    TextSize = 22,
    TextColor = Color3.fromRGB(255, 187, 109),
    Font = Enum.Font.FredokaOne,
    Disable = true,
    Enabled = Levitating,
    Callback = function(State)
    Levitating = State
    local function ForEach(t, f)
        for Index, Value in pairs(t) do
            f(Value, Index)
        end
    end
    local function Create(ClassName)
        local Object = Instance.new(ClassName)
        return function(Properties)
            ForEach(Properties, function(Value, Property)
                Object[Property] = Value
            end)
            return Object
        end
    end
    do
        local currentPart = nil
        while Levitating do
            if not currentPart then
                currentPart = Create 'Part' {
                    Parent = workspace.CurrentCamera;
                    Name = 'Part';
                    Transparency = 0.95;
                    Size = Vector3.new(3, .1, 3);
                    Anchored = true;
                }
            end
            if Character then
                currentPart.CFrame = HRP.CFrame - Vector3.new(0, 3, 0)
            end
            task.wait()
        end
    end
end})

local InfiniteJump = WinA:Toggle({
    Text = "InfiniteJump",
    TextSize = 22,
    TextColor = Color3.fromRGB(255, 187, 109),
    Font = Enum.Font.FredokaOne,
    Enabled = Toggles.InfJump,
    Callback = function(State)
    Toggles.InfJump = State
    task.spawn(function()
        SaveData('WZ_Toggles', Toggles)
        local function InfJump(Object, Callback)
            if Object ~= nil then
                Callback(Object)
            end
        end
        UserInputService.InputBegan:connect(function(UserInput)
            if Toggles.InfJump and UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space then
                InfJump(Humanoid, function(Player)
                    if Player:GetState() == Enum.HumanoidStateType.Jumping or Player:GetState() == Enum.HumanoidStateType.Freefall then
                        InfJump(HRP, function(Object)
                            Object.Velocity = Vector3.new(0,80, 0)
                        end)
                    end
                end)
            end
        end)
    end)
end})

local NoClip = WinB:Toggle({
    Text = "No-Clip",
    TextSize = 22,
    TextColor = Color3.fromRGB(255, 187, 109),
    Font = Enum.Font.FredokaOne,
    Enabled = Toggles.NoClip,
    Callback = function(State)
    Toggles.NoClip = State
    task.spawn(function()
        SaveData('WZ_Toggles', Toggles)
        noClip(true)
        if Toggles.NoClip then
            noClip(false)
        end
    end)
end})

local HeadLamp = WinB:Toggle({
    Text = "HeadLamp",
    TextSize = 22,
    TextColor = Color3.fromRGB(255, 187, 109),
    Font = Enum.Font.FredokaOne,
    Enabled = HeadLamp,
    Callback = function(State)
    HeadLamp = State
    if HeadLamp then
        local Lighting
        local LSetting = Instance.new('PointLight', Character.Head)
        LSetting.Brightness = .8
        LSetting.Range = 180
        Lighting.Changed:connect(function()
        Lighting.Brightness = 1
        Lighting.ClockTime = 12
        Lighting.FogEnd = 1000000
        Lighting.GlobalShadows = true
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.ColorShift_Top = Color3.new(1, 1, 1)
        Lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
        end)
    else
        Character.Head.PointLight:Destroy()
    end
end})

local ReduceLag = WinB:Toggle({
    Text = "ReduceLag",
    TextSize = 22,
    TextColor = Color3.fromRGB(255, 187, 109),
    Font = Enum.Font.FredokaOne,
    Enabled = Toggles.ReduceLag,
    Callback = function(State)
    Toggles.ReduceLag = State
    task.spawn(function()
        SaveData('WZ_Toggles', Toggles)
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA'BasePart' and not v.Parent:FindFirstChild'Humanoid' then
                v.Material = Enum.Material.SmoothPlastic
                if v:IsA'Texture' then
                    task.defer(v.Destroy, v)
                end
            end
        end
        Workspace.DescendantAdded:Connect(function(tex)
            if tex:IsA'BasePart'and not tex.Parent:FindFirstChild'Humanoid'then
                tex.Material=Enum.Material.SmoothPlastic
                if tex:IsA'Texture'then
                    task.defer(tex.Destroy,tex)
                end
            end
        end)
        Workspace.ChildAdded:Connect(function(dn)
            if dn.Name == 'DamageNumber' then
                task.defer(dn.Destroy,dn)
            end
        end)
    end)
end})

local DelEggs = WinB:Toggle({
    Text = "DeleteEggs",
    TextSize = 22,
    TextColor = Color3.fromRGB(255, 187, 109),
    Font = Enum.Font.FredokaOne,
    Enabled = Toggles.DelEgg,
    Callback = function(State)
    Toggles.DelEgg = State
    task.spawn(function()
        SaveData('WZ_Toggles', Toggles)
        local BackPack = ReplicatedStorage.Profiles[Player.Name].Inventory.Items
        BackPack.DescendantAdded:Connect(function()
            for _,v in pairs(BackPack:GetChildren()) do
                if string.find(v.Name, "Egg") then
                    task.defer(v.Destroy, v)
                end
            end
        end)
        BackPack.DescendantAdded:Connect(function(egg)
            if table.find(eggID, egg.Name) then
              task.delay(2, function()
                egg:Destroy()
              end)
            end
          end)
        Player.CharacterAdded:Connect(function()
            for _,v in pairs(BackPack:GetChildren()) do
                if string.find(v.Name, "Egg") then
                    v:Destroy()
                end
            end
        end)
    end)
end})

local skipCS = WinB:Toggle({
    Text = "NoCutScene",
    TextSize = 22,
    TextColor = Color3.fromRGB(255, 187, 109),
    Font = Enum.Font.FredokaOne,
    Enabled = Toggles.NoCutScene,
    Callback = function(State)
    Toggles.NoCutScene = State
    task.spawn(function()
        SaveData('WZ_Toggles', Toggles)
        local CutsceneUI = Player.PlayerGui.CutsceneUI
        CutsceneUI:GetPropertyChangedSignal('Enabled'):Connect(function()
            if CutsceneUI.Enabled then
                CameraMod:SkipCutscene()
            end
        end)
    end)
end})

local AutoOffhand = WinB:Toggle({
    Text = "AutoOffhandPerk",
    TextSize = 22,
    TextColor = Color3.fromRGB(255, 187, 109),
    Font = Enum.Font.FredokaOne,
    Enabled = Toggles.AutoSwitch,
    Callback = function(State)
    Toggles.AutoSwitch = State
    task.spawn(function()
        SaveData('WZ_Toggles', Toggles)
        local connection 
        connection = Workspace.Mobs.ChildAdded:connect(function(Mob)
            if Toggles.AutoSwitch and Mob:isA('Model') then 
                SwitchToPerk(Mob)
            end
        end)
        if not Toggles.AutoSwitch then
            connection:Disconnect()
        end
    end)
end})

WinC:Button({
    Text = "Bank",
    TextSize = 22,
    Font = Enum.Font.FredokaOne,
    TextColor = Color3.fromRGB(255, 187, 109),
    Callback = function()
    if Workspace:FindFirstChild("MenuRings") and Workspace.MenuRings:FindFirstChild("Bank") then
        Workspace.MenuRings.Bank.Ring.CFrame = Character:WaitForChild('LeftFoot').CFrame * CFrame.new(0, 0, -12)
        Workspace.MenuRings.Bank.Floor.CFrame = Character:WaitForChild('LeftFoot').CFrame * CFrame.new(0, 0, -12)
    end
end})

WinC:Button({
    Text = "Upgrade",
    TextSize = 22,
    Font = Enum.Font.FredokaOne,
    TextColor = Color3.fromRGB(255, 187, 109),
    Callback = function()
    require(ReplicatedStorage.Client.Gui.GuiScripts.ItemUpgrade):Toggle()
end})

WinC:Button({
    Text = "Zero Altar",
    TextSize = 22,
    Font = Enum.Font.FredokaOne,
    TextColor = Color3.fromRGB(255, 187, 109),
    Callback = function()
    require(ReplicatedStorage.Client.Gui.GuiScripts.Fusion):Open()
end})

WinC:Button({
    Text = "Way Stones",
    TextSize = 22,
    Font = Enum.Font.FredokaOne,
    TextColor = Color3.fromRGB(255, 187, 109),
    Callback = function()
    require(ReplicatedStorage.Client.Gui.GuiScripts.Waystones):Open()
end})

WinC:Button({
    Text = "World Menu",
    TextSize = 22,
    Font = Enum.Font.FredokaOne,
    TextColor = Color3.fromRGB(255, 187, 109),
    Callback = function()
    require(ReplicatedStorage.Client.Gui.GuiScripts.WorldTeleport):Toggle()
end})

WinC:Button({
    Text = "Dungeon Menu",
    TextSize = 22,
    Font = Enum.Font.FredokaOne,
    TextColor = Color3.fromRGB(255, 187, 109),
    Callback = function()
    require(ReplicatedStorage.Client.Gui.GuiScripts.MissionSelect):Toggle()
end})

local SellNonLeg = WinD:Toggle({
    Text = "SellTier[1-4]",
    TextSize = 22,
    TextColor = Color3.fromRGB(255, 187, 109),
    Font = Enum.Font.FredokaOne,
    Enabled = Toggles.SellNonLegend,
    Callback = function(State)
    Toggles.SellNonLegend = State
    task.spawn(function()
        SaveData('WZ_Toggles', Toggles)
    end)
end})

local SellLeg = WinD:Toggle({
    Text = "SellLegendary",
    TextSize = 22,
    TextColor = Color3.fromRGB(255, 187, 109),
    Font = Enum.Font.FredokaOne,
    Enabled = Toggles.SellLegend,
    Callback = function(State)
    Toggles.SellLegend = State
    task.spawn(function()
        SaveData('WZ_Toggles', Toggles)
    end)
end})

local MoLPass = WinD:Toggle({
    Text = "MoLPassive",
    TextSize = 22,
    TextColor = Color3.fromRGB(255, 187, 109),
    Font = Enum.Font.FredokaOne,
    Enabled = Toggles.MoLPass,
    Callback = function(State)
    Toggles.MoLPass = State
    local party = require(ReplicatedStorage.Shared.Party):GetPartyByUsername(Player.Name)
    task.spawn(function()
        while Toggles.MoLPass do
            local character = Workspace.Characters[Player.Name]
            if character and character.HealthProperties.Health.Value / character.HealthProperties.MaxHealth.Value * 100 < 99 then
            for _, player in pairs(Players:GetPlayers()) do
                if party and party.Members:FindFirstChild(player.Name) then
                ReplicatedStorage.Shared.Combat.Skillsets.MageOfLight.HealCircle:FireServer(player)
                end
            end
            end
            task.wait(14)
        end
    end)
    task.spawn(function()
        SaveData('WZ_Toggles', Toggles)
        while Toggles.MoLPass do
            local character = Workspace.Characters[Player.Name]
            if character and character.HealthProperties.BarrierHealth.Value <= 0 then
            for _, player in pairs(Players:GetPlayers()) do
                if party and party.Members:FindFirstChild(player.Name) then
                ReplicatedStorage.Shared.Combat.Skillsets.MageOfLight.Barrier:FireServer(player)
                end
            end
            end
            task.wait(15)
        end
    end)
end})

local AiPing = WinD:Toggle({
    Text = "AI.Cooldown",
    TextSize = 22,
    TextColor = Color3.fromRGB(255, 187, 109),
    Font = Enum.Font.FredokaOne,
    Enabled = Toggles.AiPing,
    Callback = function(State)
    Toggles.AiPing = State
    task.spawn(function()
    SaveData('WZ_Toggles', Toggles)
    end)
end})

Workspace.ChildAdded:Connect(function(bp)
    if bp.Name == 'BarrierPart' then
        task.defer(bp.Destroy,bp)
    end
end)

local RepeatRaid = WinD:Toggle({
    Text = "RepeatRaid",
    TextSize = 22,
    TextColor = Color3.fromRGB(255, 187, 109),
    Font = Enum.Font.FredokaOne,
    Enabled = Toggles.RepeatRaid,
    Callback = function(State)
    Toggles.RepeatRaid = State
    task.spawn(function()
        SaveData('WZ_Toggles', Toggles)
        for _,v in pairs(oID) do
            if game.PlaceId ~= v and Toggles.RepeatRaid then
                local MissionRewards = Player.PlayerGui.MissionRewards.MissionRewards
                if MissionRewards.Playerlist.Visible then
                    MissionsMod:SetLeaveChoice(Player, true)
                    MissionsMod:NotifyReadyToLeave(Player)
                end
                MissionRewards.RaidClear:GetPropertyChangedSignal('Text'):Connect(function()
                    if MissionRewards.RaidClear.Text == 'T O W E R    F A I L U R E' then
                        MissionsMod:SetLeaveChoice(Player, true)
                        MissionsMod:NotifyReadyToLeave(Player)
                    end
                end)
                MissionRewards.RaidClear:GetPropertyChangedSignal('Text'):Connect(function()
                    if MissionRewards.RaidClear.Text == 'D U N G E O N    F A I L U R E' then
                        MissionsMod:SetLeaveChoice(Player, true)
                        MissionsMod:NotifyReadyToLeave(Player)
                    end
                end)
                Player.PlayerGui.TowerFinish.TowerFinish.Description.Overlay:GetPropertyChangedSignal('Text'):Connect(function()
                    if Player.PlayerGui.TowerFinish.TowerFinish.Description.Overlay.Text == 'Collect your rewards! (10)' then
                        MissionsMod:SetLeaveChoice(Player, true)
                        MissionsMod:NotifyReadyToLeave(Player)
                    end
                end)
                MissionRewards.Playerlist.Header:GetPropertyChangedSignal('Visible'):Connect(function()
                    wait(1)
                    click(MissionRewards.Playerlist.WithParty.TextLabel)
                end)
            end
        end
    end)
end})

local ReloadOnHop = WinD:Toggle({
    Text = "ReloadOnHop",
    TextSize = 22,
    TextColor = Color3.fromRGB(255, 187, 109),
    Font = Enum.Font.FredokaOne,
    Enabled = Toggles.ReLoadOnHop,
    Callback = function(State)
    Toggles.ReLoadOnHop = State
    task.spawn(function()
        SaveData('WZ_Toggles', Toggles)
        Players.PlayerRemoving:connect(function(engaged)
            if engaged == Player and Toggles.ReLoadOnHop then
                quequeTeleport(ScriptLink)
            end
        end)
    end)
end})

local KlausDown = WinE:Toggle({
    Text = "Klaus↓Down",
    TextSize = 22,
    Font = Enum.Font.FredokaOne,
    TextColor = Color3.fromRGB(255, 187, 109),
    Enabled = Toggles.KlausDown,
    Callback = function(State)
    Toggles.KlausDown = State
    local parts = Workspace.MissionObjects.MissionStart:GetChildren()
    for i = 1, 2 do
        if Toggles.KlausDown and Workspace.MissionObjects:FindFirstChild("MissionStart") then
            parts[3].CFrame = HRP.CFrame
        end
        wait()
    end
    HRP.CFrame = CFrame.new(44, 497, 997)
    bvCreate()
end})

WinE:Button({
    Text = "Unstuck-SOS",
    TextSize = 22,
    Font = Enum.Font.FredokaOne,
    TextColor = Color3.fromRGB(255, 187, 109),
    Callback = function()
    bvDelete()
end})

WinE:Slider("WalkSpeed",16,120,Humanoid.WalkSpeed, function(Value)
    Humanoid.WalkSpeed = Value
end)

WinF:DestroyUI()

----------------------------FreezeMobs-----------------------------

WinF:Button({
    Text = "FreezeMob",
    TextSize = 22,
    TextColor = Color3.fromRGB(255, 187, 109),
    Font = Enum.Font.FredokaOne,
    Enabled = FreezeMob,
    Callback = function(bool)
    if bool then
        Workspace.Mobs.ChildAdded:connect(function(mob)
            if not string.find(mob.Name, "BOSS") then
                local dummy = Instance.new("Part")
                dummy.Name = "Dummy"
                dummy.Anchored = true
                dummy.CanCollide = false
                dummy.Size = Vector3.new(1, 1, 1)
                dummy.Transparency = 1
                dummy.Parent = game:GetService("Workspace")
                dummy.Position = mob.Collider.Position
                local weld = Instance.new("Weld")
                weld.Parent = mob.Collider
                weld.Part0 = mob.Collider
                weld.Part1 = dummy
                local bodyForce = Instance.new("BodyForce")
                bodyForce.Parent = dummy
                pcall(function()
                bodyForce:ApplyForce(Vector3.new(0, -100, 0))
                end)
            end
        end)
    end
end})

WinF:HideUI()

local RealTime = WinF:Toggle({
    Text = "RealTimePing",
    TextSize = 22,
    TextColor = Color3.fromRGB(255, 187, 109),
    Font = Enum.Font.FredokaOne,
    Enabled = RealTime,
    Callback = function(State)
    RealTime = State
    task.spawn(function()
        while RealTime do
            WinF.Text = ("Ping: "..math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue()))
            wait(2)
        end
    end)
end})

local OWFarm = WinF:Toggle({
    Text = "PubMapFarm",
    TextSize = 22,
    TextColor = Color3.fromRGB(255, 187, 109),
    Font = Enum.Font.FredokaOne,
    Enabled = OWFarm,
    Callback = function(State)
    OWFarm = State
    task.spawn(function()
        TeleportSpeed = 60
        while OWFarm do
            local Mob = TargetLocator()
            Teleport(Mob)
            task.wait(3/2)
        end
    end)
end})

WinF:Box({
    Text = "Webhook URL",
    Callback = function(Value)
    MoreFlag.Webhook = Value
    ClearText = true
    task.spawn(function()
        SaveData('WZwebhook', MoreFlag)
    end)
end})

WinG:MinimizeWindows()

ReplicatedStorage.Shared.Missions.MissionFinished.OnClientEvent:Connect(function()
    WinB.Text = ("EndTime: "..os.date("%I:%M %p"))
end)

----------------------------ClaimDungeonReward-----------------------------

for _,v in pairs(dID) do
    if game.PlaceId == v then
        local MissionRewards = Player.PlayerGui.MissionRewards.MissionRewards
        MissionRewards.Countdown:GetPropertyChangedSignal('Text'):Connect(function()
            if MissionRewards.Countdown.Text == 'Pick up your gold! (1)' then 
                repeat wait() until MissionRewards.Chests.Visible and MissionRewards.Chests.Box1.Visible and MissionRewards.Chests.Box2.Visible
                repeat wait() until MissionRewards.Chests.Box1.ChestImage.Select.Visible
                repeat click(MissionRewards.Chests.Box1.ChestImage.Select) wait()
                until MissionRewards.OpenChest.Countdown.text == '0'
             end
        end)
        MissionRewards.OpenChest.Countdown:GetPropertyChangedSignal('Text'):Connect(function()
            if MissionRewards.OpenChest.Countdown.Text == '0' then
                repeat wait() until MissionRewards.OpenChest:FindFirstChild("Next") and MissionRewards.OpenChest:FindFirstChild("Next").Visible
                click(MissionRewards.OpenChest.Next.TextLabel)
            end
        end)
        MissionRewards.Chests.Box1.ChestImage.ChildAdded:Connect(function(vf)
            if vf.Name == 'ViewportFrame' and not IsExtraDrop then
                wait(5)
                click(MissionRewards.OpenChest.Next.TextLabel)
            else click(MissionRewards.Chests.Box2.ChestImage.VIP.TextLabel) wait(1.5)
                repeat click(MissionRewards.Chests.Box2.ChestImage.Select) wait()
                until MissionRewards.OpenChest.Countdown.text == '0'
            end
        end)
        MissionRewards.Chests.Box2.ChestImage.ChildAdded:Connect(function(vf)
            if vf.Name == 'ViewportFrame' and IsExtraDrop then wait(3)
                click(MissionRewards.OpenChest.Next.TextLabel)
            end
        end)
    end
end
  
----------------------------MissionConnections-----------------------------

if game.PlaceId == dID[2.1] then
    Workspace.MissionObjects.ChildRemoved:Connect(function(ms)
        if ms.Name == 'MissionStart' then wait(1)
            Workspace.MissionObjects.Room1Trigger.CFrame = HRP.CFrame
        end
    end)
    Workspace.MissionObjects.Room1Trigger.ChildRemoved:Connect(function()
        wait(2)
        Workspace.MissionObjects.Room2Trigger.CFrame = HRP.CFrame
    end)
    Workspace.MissionObjects.Room2Trigger.ChildRemoved:Connect(function()
        wait(2)
        Workspace.MissionObjects.Room3Trigger.CFrame = HRP.CFrame
    end)
    Workspace.MissionObjects.Room3Trigger.ChildRemoved:Connect(function()
        wait(2)
        Workspace.MissionObjects.Room4Trigger.CFrame = HRP.CFrame
    end)
    Workspace.MissionObjects.Room4Trigger.ChildRemoved:Connect(function()
        wait(6)
        HRP.CFrame = Workspace.MissionObjects.WallsTrigger.CFrame
        wait(3)
        HRP.CFrame = Workspace.MissionObjects.WallsFinalTrigger.CFrame
    end)
    Player.PlayerGui.MissionObjective.MissionObjective.Label:GetPropertyChangedSignal('Text'):Connect(function()
        if Player.PlayerGui.MissionObjective.MissionObjective.Label.Text == 'Take the royal crystal! (0 / 1)' then
            HRP.CFrame = CFrame.new(1192.15894, -226.738449, 110.141144)
        end
    end)
end
-- 1-4
if game.PlaceId == dID[1.4] then
    Workspace.ChildAdded:Connect(function(SceneTrigger)
        if SceneTrigger.Name == 'Cage1Marker' then
            wait(2)
            Workspace.Cage1Marker.Collider.CFrame = HRP.CFrame
        end
    end)
    Workspace.ChildAdded:Connect(function(SceneTrigger)
        if SceneTrigger.Name == 'Cage2Marker' then
            wait(2.2)
            Workspace.Cage2Marker.Collider.CFrame = HRP.CFrame
        end
    end)
end
-- 3-1
if game.PlaceId == dID[3.1] then
    Workspace.MissionObjects.ChildRemoved:Connect(function(pb1)
        if pb1.Name == 'ProgressionBlocker1' then
            Workspace.MissionObjects.CaveTrigger.CFrame = HRP.CFrame
        end
    end)
end
--3 Final
if game.PlaceId == dID[3] then
    Workspace.ChildAdded:Connect(function(iw)
        if iw.Name == 'IceWall' then
            wait(5)
            AutoFarm.State = false
            HRP.CFrame = Workspace.IceWall:FindFirstChild('Ring').CFrame
        end
    end)
    Workspace.ChildRemoved:Connect(function(iw)
        if iw.Name == 'IceWall' then
            bvCreate()
            AutoFarm.State = true
        end
    end)
end

-- 4-1
local function CleanTowerLegs()
    pcall(function()
        for _,v in pairs(Workspace.MissionObjects.TowerLegs:GetDescendants()) do
            if v.Name == ('hitbox') and not v.CanCollide then
                v.Parent:Destroy()
            end
        end
    end)
end
if game.PlaceId == dID[4.1] then
    Workspace.MissionObjects.TowerLegs.DescendantRemoving:Connect(CleanTowerLegs)
end
-- 6-1
if game.PlaceId == dID[6.1] then
    Workspace.MissionObjects.ChildRemoved:Connect(function(ms)
        if ms.Name == 'MissionStart' then wait(1)
            Workspace.MissionObjects.Area1Trigger.CFrame = HRP.CFrame
        end
    end)
    Workspace.MissionObjects.Area2Trigger.ChildAdded:Connect(function(ti)
        if ti:IsA('TouchTransmitter') then wait(1)
            Workspace.MissionObjects.Area2Trigger.CFrame = HRP.CFrame
        end
    end)
end
-- 7-1
if game.PlaceId == dID[7.1] then
    Workspace.MissionObjects.ChildRemoved:Connect(function(ms)
        if ms.Name == 'MissionStart' then wait(1)
            Workspace.MissionObjects.FakeBoss.CFrame = HRP.CFrame
        end
    end)
end
-- Towers
if game.PlaceId == tID[1] then
    Player.PlayerGui.MissionObjective.MissionObjective.Label:GetPropertyChangedSignal('Text'):Connect(function()
        if Player.PlayerGui.MissionObjective.MissionObjective.Label.Text == 'Get behind the active shield! (2)' then
            AutoFarm.State = false
            HRP.CFrame = Workspace.MissionObjects.IgnisShield.Ring.CFrame
            wait(3)
            bvCreate()
            AutoFarm.State = true
        end
    end)
end
for _,v in pairs(tID) do
    if game.PlaceId == v then
        task.spawn(function()
            while IsAlive() do
                local Starter = Workspace.MissionObjects:WaitForChild('WaveStarter', math.huge)
                if #Starter:GetChildren() > 0 then
                    Starter.CFrame = HRP.CFrame
                end
                wait()
            end
        end)
        Workspace.MissionObjects.ChildAdded:Connect(function(mbem)
            if mbem.Name == 'MinibossExitModel' then wait(2)
                Workspace.MissionObjects.MinibossExitModel:MoveTo(HRP.Position)
            end
        end)
        Workspace.MissionObjects.ChildAdded:Connect(function(mbe)
            if mbe.Name == 'MinibossExit' then wait(3)
                AutoFarm.State = false
                Workspace.MissionObjects.MinibossExit.CFrame = HRP.CFrame
                wait()
                bvCreate()
                AutoFarm.State = true
            end
        end)
    end
end

-- Holidays 

local effects = game:GetService("ReplicatedStorage").Shared.Effects
local effectsMod = effects.EffectScripts:GetChildren()

for _, v in ipairs(effectsMod) do
    if hookfunction and v:IsA("ModuleScript") and (
        string.find(v.Name, "Klaus")
    ) then
        local Module = require(v)
        hookfunction(Module, function()
            return wait(600)
        end)
    end
end

----------------------------AutoNextScene-----------------------------

for i,v in pairs(dID) do
    if type(i) ~= "string" and game.PlaceId == v then
        if Workspace:FindFirstChild('MissionObjects') then
            local missionObjects = Workspace.MissionObjects
            missionObjects.DescendantAdded:Connect(function(ti)
                if ti:IsA'TouchTransmitter' and not string.match(ti.Parent.Parent.Name, 'Damage') and not string.match(ti.Parent.Name, 'Killpart') and not string.match(ti.Parent.Name, '0') and
                not string.match(ti.Parent.Parent.Name, 'Darts') and not string.match(ti.Parent.Parent.Name, 'Spikes') and ti.Parent ~= 'MinibossExit' and ti.Parent.Parent ~= 'MinibossExitModel' then wait(2)
                    pcall(function()
                    ti.Parent.CFrame = HRP.CFrame
                    end)
                end
            end)
            missionObjects.DescendantAdded:Connect(function(trigger)
                if trigger:IsA'TouchTransmitter' and string.match(trigger.Parent.Name, 'Trigger') then wait(3/2)
                    pcall(function()
                    trigger.Parent.CFrame = HRP.CFrame
                    end)
                end
            end)
        end
    end
end

----------------------------ChestHandler-----------------------------

for _,tower in pairs(tID) do
    if game.PlaceId == tower then
        Workspace.ChildAdded:Connect(function(rcg)
            if rcg.Name == 'RaidChestGold' then
                Workspace.RaidChestGold.ChestBase.CFrame = HRP.CFrame
                wait(3.8) rcg:Destroy()
            end
        end)
        Workspace.ChildAdded:Connect(function(rcs)
            if rcs.Name == 'RaidChestSilver' then
                Workspace.RaidChestSilver.ChestBase.CFrame = HRP.CFrame
                wait(3.8) rcs:Destroy()
            end
        end)
        Workspace.ChildAdded:Connect(function(ac)
            if ac.Name == 'AtlanticChest' then
                for _, v in pairs(Workspace:GetChildren()) do
                    if v.ClassName == 'Model' and v.Name == 'AtlanticChest' then
                        v.ChestBase.CFrame = HRP.CFrame
                    end
                end
            end
        end)
        Workspace.ChildAdded:Connect(function(vc)
            if vc.Name == 'VolcanicChestTower' then
                for _, v in pairs(Workspace:GetChildren()) do
                    if v.ClassName == 'Model' and v.Name == 'VolcanicChestTower' then
                        v.ChestBase.CFrame = HRP.CFrame
                    end
                end
            end
        end)
        Workspace.ChildRemoved:Connect(function(rcg)
            if rcg.Name == 'RaidChestGold' and Workspace:FindFirstChild'RaidChestGold' then
                Workspace.RaidChestGold.ChestBase.CFrame = HRP.CFrame
            end
        end)
        Workspace.ChildRemoved:Connect(function(rcs)
            if rcs.Name == 'RaidChestSilver' and Workspace:FindFirstChild'RaidChestSilver' then
                Workspace.RaidChestSilver.ChestBase.CFrame = HRP.CFrame
            end
        end)
        Workspace.ChildRemoved:Connect(function(ac)
            if ac.Name == 'AtlanticChest' then
                for _, v in pairs(Workspace:GetChildren()) do
                    if v.ClassName == 'Model' and v.Name == 'AtlanticChest' and Workspace:FindFirstChild'AtlanticChest' then
                        v.ChestBase.CFrame = HRP.CFrame
                    end
                end
            end
        end)
        Workspace.ChildRemoved:Connect(function(vc)
            if vc.Name == 'VolcanicChestTower' then
                for _, v in pairs(Workspace:GetChildren()) do
                    if v.ClassName == 'Model' and v.Name == 'VolcanicChestTower' and Workspace:FindFirstChild'VolcanicChestTower' then
                        v.ChestBase.CFrame = HRP.CFrame
                    end
                end
            end
        end)
    end
end

----------------------------PurchaseHandler-----------------------------

for _,v in pairs(tID) do
    if game.PlaceId == v then
        CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.ChildAdded:Connect(function()
            pcall(function()
                CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.Visible = false
            end)
        end)
        CoreGui.PurchasePrompt.ChildAdded:Connect(function(ruc)
            if ruc.Name == 'RobuxUpsellContainer' then
                wait(1/3)
                ruc:Destroy()
            end
        end)
    end
end

----------------------------OpenWorldProtection-----------------------------

for _,v in pairs(oID) do
    if game.PlaceId == v then
        KillAura.State = false
        AutoFarm.State = false
    end
end

----------------------------HRPupdater-----------------------------

local function updateVariables(newCharacter)
    character = newCharacter
    Humanoid = newCharacter:WaitForChild('Humanoid')
    HRP = newCharacter:WaitForChild('HumanoidRootPart')
    bvCreate()
end
Player.CharacterAdded:Connect(updateVariables)

----------------------------AntiAFK-----------------------------

if getconnections then
    for _, v in next, getconnections(Player.Idled) do
        v:Disable()
    end
end
if not getconnections then
    Player.Idled:connect(
        function()
            gs.VirtualUser:ClickButton2(Vector2.new())
        end
    )
end

----------------------------ZoomOut-----------------------------

Player.CameraMaxZoomDistance = 60
local OldCMZD = Player.CameraMinZoomDistance
Player.CameraMinZoomDistance = 60
Player.CameraMinZoomDistance = OldCMZD

----------------------------KickedConnection-----------------------------

game.NetworkClient.ChildRemoved:Connect(function(Status)
    Toggles.KillAura = false
    gs.GuiService:ClearError()
    WinE.Text = ("Disconnected")
end)

----------------------------Kicked & Reconnect Rejoin-----------------------------

spawn(function()
    local promptGui = CoreGui:WaitForChild("RobloxPromptGui")
    local promptOverlay = promptGui:WaitForChild("promptOverlay")
    local errorPrompt = promptOverlay:WaitForChild("ErrorPrompt")
    local messageArea = errorPrompt:WaitForChild("MessageArea")
    local errorFrame = messageArea:WaitForChild("ErrorFrame")
    local errorMessage = errorFrame:WaitForChild("ErrorMessage")
    repeat wait() until string.find(errorMessage.Text, "exploit") or string.find(errorMessage.Text, "reconnect")
    print("Got Kicked, Last DungeonID is "..tostring(Kick.DungeonID).." and last Difficulty is "..tostring(Kick.DifficultyID))
    if Kick.DifficultyID <= 1 then
        ReplicatedStorage.Shared.Teleport.StartRaid:FireServer(Kick.DungeonID)
    else
        ReplicatedStorage.Shared.Teleport.StartRaid:FireServer(Kick.DungeonID, Kick.DifficultyID)
    end
end)


----------------------------AltAccRejoin-----------------------------

local GameData = {
    DungeonID = wID[game.PlaceId],
    DifficultyID = MissionsMod.GetDifficulty(),
    Phase = 0,
    ProfileGUID = ReplicatedStorage.Profiles[Player.Name].GUID.Value
}
if getgenv().RJOnCrash and not wID[game.PlaceId] or GameData.Phase == 1 then
    LoadData('WZ_CrashRJ', GameData)
    wait(1)
    if GameData.Phase == 0 then
        GameData.Phase = 1
        SaveData('WZ_CrashRJ', GameData)
        quequeTeleport(ScriptLink)
        while wait(10) do
            ReplicatedStorage.Shared.Teleport.JoinGame:FireServer(GameData.ProfileGUID)
        end
    end
    if GameData.Phase == 1 then
        GameData.Phase = 0
        SaveData('WZ_CrashRJ', GameData)
        quequeTeleport(ScriptLink)
        if Kick.DifficultyID <= 1 then
            ReplicatedStorage.Shared.Teleport.StartRaid:FireServer(GameData.DungeonID)
        else
            ReplicatedStorage.Shared.Teleport.StartRaid:FireServer(GameData.DungeonID, GameData.DifficultyID)
        end
    end
end
SaveData('WZ_CrashRJ', GameData)
----------------------------Spoof-----------------------------

local spoof = function(instance, property)
    local spoofer = {
        enabled = true,
        fake = instance[property],
        fake_type = typeof(fake),
    }
    local _index
    local _newindex
    function spoofer:SetFake(new_value, any_type)
        if any_type then
            spoofer.fake = new_value
        elseif typeof(new_value) == spoofer.fake_type then
            spoofer.fake = new_value
        else
            spoofer.fake = nil
        end
    end
    function spoofer:Destroy()
        instance[property] = spoofer.fake
        spoofer.enabled = false
    end
    if hookmetamethod then
        _index = hookmetamethod(instance, '__index', function(self, index)
            if self == instance and index == property and not checkcaller() and spoofer.enabled then
                return spoofer.fake
            end

            return _index(self, index)
        end)
        _newindex = hookmetamethod(instance, '__newindex', function(self, index, value)
            if self == instance and index == property and not checkcaller() and spoofer.enabled then
                if typeof(value) == spoofer.fake_type then
                    spoofer.fake = value
                    return
                else
                    spoofer.fake = nil
                    return
                end
            end
            return _newindex(self, index, value)
        end)
    else
        return
    end
    return spoofer
end

spoof(Humanoid, 'WalkSpeed')
spoof(Humanoid, 'JumpPower')
spoof(Player, 'CameraMaxZoomDistance')

----------------------------ResetToggle-----------------------------

if PlayerClass ~= 'MageOfLight' then
    MoLPass.State = false
end

-------------------------GetMaxPerks-----------------------------

local MaxPerkRange = {}
local SelectedPerk = ''
local FirstPerkTable = true
if MoreFlag.PerkNames ~= nil and type(MoreFlag.PerkNames) == 'table' then
    for i,v in pairs(MoreFlag.PerkNames) do
        FirstPerkTable = false
    end
end
if FirstPerkTable then
    MoreFlag.PerkNames = {}
    for i, v in pairs(GearPerksMod) do
        if type(v) == 'table' then
            for i2,v2 in pairs(v) do
                if type(v2) == 'table' then
                    for i3,v3 in pairs(v2) do
                        if i3 == 2 then
                            table.insert(MoreFlag.PerkNames, i)
                            MaxPerkRange[i] = v3
                        end
                    end
                end
            end
        end
    end
else
    LoadData('WZwebhook', MoreFlag)
end

-----------------------Dungeon End checks---------------------------

local ItemsDropped = {}
local BetterPerkName = {
    ['ResistFrost'] = 'Resist Frost',
    ['ResistBurn'] = 'Resist Burn',
    ['Glass'] = 'Glass',
    ['RoughSkin'] = 'Rough Skin',
    ['ResistKnockdown'] = 'Resist Knockdown',
    ['BonusWalkspeed'] = 'Bonus Walkspeed',
    ['PetFoodDrop'] = 'Bonus Pet Food Chance',
    ['BonusAttack'] = 'Attack UP',
    ['BonusHP'] = 'HP UP',
    ['ResistPoison'] = 'Resist Poison',
    ['LifeDrain'] = 'Life Drain',
    ['CritStack'] = 'Crit Stack',
    ['BurnChance'] = 'Burn Chance',
    ['OpeningStrike'] = 'Opening Strike',
    ['MobBoss'] = 'Mob Boss',
    ['TestTier5'] = 'Boss of the Boss',
    ['GoldDrop'] = 'Bonus Gold',
    ['BonusRegen'] = 'Bonus Health Regen',
    ['DamageReduction'] = 'Damage Reduction',
    ['Aggro'] = 'Shifted Aggro',
    ['UltCharge'] = 'Ult Charge',
    ['Fortress'] = 'Fortress',
    ['MasterThief'] = 'Master Thief',
    ['EliteBoss'] = 'Elite Boss',
    ['DodgeChance'] = 'Untouchable'
}
local StartedGold = ReplicatedStorage.Profiles[Player.Name].Currency.Gold.Value
for i,v in pairs(ReplicatedStorage.Profiles[Player.Name].Inventory.Items:GetChildren()) do
    if v:FindFirstChild('UpgradeLimit') and v:FindFirstChild('Level') then
        local ItemExists = Instance.new('StringValue')
        ItemExists.Parent = v
        ItemExists.Name = 'Item Already Exists'
        ItemExists.Value = 'Item Already Exists'
    end
end
local connection
connection = ReplicatedStorage.Profiles[Player.Name].Inventory.Items.DescendantAdded:Connect(function()
    for i,v in pairs(ReplicatedStorage.Profiles[Player.Name].Inventory.Items:GetChildren()) do
        if v:FindFirstChild('UpgradeLimit') and v:FindFirstChild('Level') and not v:FindFirstChild('Item Already Exists') then
            wait(.25)
            local ItemSold = false
			local ItemName = ''
            if Toggles.SellNonLegend then
                if not v:FindFirstChild('Perk3') then
                    v.Name = 'This Item is gone'
                    ItemName = v.Name
                    ReplicatedStorage.Shared.Drops.SellItems:InvokeServer({ReplicatedStorage.Profiles[Player.Name].Inventory.Items:FindFirstChild(ItemName)})
                    ItemSold = true
                end
            end
            if Toggles.SellLegend and ItemsMod[v.Name].Rarity ~= 7 and not string.find(ItemsMod[v.Name].DisplayKey, "Zero") then
                local Perk1Check = false
                local Perk2Check = false
                local Perk3Check = false
                for _,Perk in pairs(MoreFlag.PerkNames) do
                    if v:FindFirstChild('Perk3') and v:FindFirstChild('Perk3').Value == Perk then
                        if Toggles.MaxPerk and v:FindFirstChild('Perk3'):FindFirstChild('PerkValue').Value == MaxPerkRange[Perk] then
                            Perk3Check = true
                        else
                            Perk3Check = true
                        end
                    elseif v:FindFirstChild('Perk2') and v:FindFirstChild('Perk2').Value == Perk then
                        if Toggles.MaxPerk and v:FindFirstChild('Perk2'):FindFirstChild('PerkValue').Value == MaxPerkRange[Perk] then
                            Perk2Check = true
                        else
                            Perk2Check = true
                        end
                    elseif v:FindFirstChild('Perk1') and v:FindFirstChild('Perk1').Value == Perk then
                        if Toggles.MaxPerk and v:FindFirstChild('Perk1'):FindFirstChild('PerkValue').Value == MaxPerkRange[Perk] then
                            Perk1Check = true
                        else
                            Perk1Check = true
                        end
                    end
                    if not Perk1Check and not Perk2Check and not Perk3Check then
                        v.Name = 'This Item is gone'
                        ItemName = v.Name
                        ReplicatedStorage.Shared.Drops.SellItems:InvokeServer({ReplicatedStorage.Profiles[Player.Name].Inventory.Items:FindFirstChild(ItemName)})
                        ItemSold = true
                    end
                end
            end
            if not ItemSold then
                local ItemExists = Instance.new("StringValue")
                ItemExists.Name = "Item Already Exists"
                ItemExists.Value = "Item Already Exists"
                ItemExists.Parent = v
                local Level = v:FindFirstChild("Level").Value
                local Rarity, Perk1, Perk2, Perk3
                if v:FindFirstChild("Perk3") then
                    Rarity = "Legendary"
                    Perk1 = BetterPerkName[tostring(v.Perk1.Value)] .. " " .. tostring(math.floor(v:FindFirstChild("Perk1"):FindFirstChild("PerkValue").Value * 100)) .. "%"
                    Perk2 = BetterPerkName[tostring(v.Perk2.Value)] .. " " .. tostring(math.floor(v:FindFirstChild("Perk2"):FindFirstChild("PerkValue").Value * 100)) .. "%"
                    Perk3 = BetterPerkName[tostring(v.Perk3.Value)] .. " " .. tostring(math.floor(v:FindFirstChild("Perk3"):FindFirstChild("PerkValue").Value * 100)) .. "%"
                elseif v:FindFirstChild("Perk2") then
                    Rarity = "Epic"
                    Perk1 = BetterPerkName[tostring(v.Perk1.Value)] .. " " .. tostring(math.floor(v:FindFirstChild("Perk1"):FindFirstChild("PerkValue").Value * 100)) .. "%"
                    Perk2 = BetterPerkName[tostring(v.Perk2.Value)] .. " " .. tostring(math.floor(v:FindFirstChild("Perk2"):FindFirstChild("PerkValue").Value * 100)) .. "%"
                elseif v:FindFirstChild("Perk1") then
                    Rarity = "Uncommon"
                    Perk1 = BetterPerkName[tostring(v.Perk1.Value)] .. " " .. tostring(math.floor(v:FindFirstChild("Perk1"):FindFirstChild("PerkValue").Value * 100)) .. "%"
                else
                    Rarity = "Common"
                end
                ItemsDropped[v.Name] = {["Level"] = Level, ["Rarity"] = Rarity, ["Perk 1"] = Perk1, ["Perk 2"] = Perk2, ["Perk 3"] = Perk3}
            end
        end
    end
end)
Player.CharacterRemoving:Connect(function()
    connection:Disconnect()
end)


local PlayerGui = Player:WaitForChild("PlayerGui")
local MissionRewards = PlayerGui:WaitForChild("MissionRewards"):WaitForChild("MissionRewards")
local TowerFinish = PlayerGui:WaitForChild("TowerFinish"):WaitForChild("TowerFinish")
local RunFinished = MissionRewards:WaitForChild("Time")
local TowerFinished = TowerFinish:WaitForChild("Description"):WaitForChild("Overlay")

repeat wait() until RunFinished.Visible or TowerFinished.text == "Collect your rewards! (20)"
wait(1)

local GoldEarned = ReplicatedStorage.Profiles[Player.Name].Currency.Gold.Value - StartedGold
local Description = ""
local RunTime = ""
if not RunFinished.Visible then
    Description = "Tower Finished"
    RunTime = TowerFinish:WaitForChild("Time").Text
else
    Description = MissionRewards:WaitForChild("RaidClear").Text
    RunTime = MissionRewards:WaitForChild("Time").Text
end




local WorldName = ''
local WorldDescription = ''
for i,v in pairs(WorldDataMod) do
    if v.LiveID == game.PlaceId then
        WorldName = v.Name
        WorldDescription = v.NameTag
    end
end

local ItemsTable = {
    {
        ['title'] = 'World // Zero',
        ['description'] = Description,
        ['color'] = tonumber(0x2B6BE4),
        ['footer'] = {
            ['text'] = tostring(os.date())
        },
        ['fields'] = {
            {
                ['name'] = WorldName,
                ['value'] = WorldDescription,
                ['inline'] = false
            },
            {
                ['name'] = 'Finished in',
                ['value'] = RunTime,
                ['inline'] = false
            },
            {
                ['name'] = 'Gold Earned',
                ['value'] = tostring(GoldEarned),
                ['inline'] = false
            },
            {
                ['name'] = 'Level: '..tostring(string.match(Player.PlayerGui.Hotbar.Hotbar.Vitals.Level.TextLabel.Text, '%d+')),
                ['value'] = Player.PlayerGui.Hotbar.Hotbar.Vitals.XP.TextLabel.Text,
                ['inline'] = false
            }
        }
    }
}

local AddEmbeds = function(Title, Description, ...)
    local Table = {
        ['title'] = Title,
        ['description'] = Description,
        ['color'] = tonumber(0x2B6BE4),
        ['fields'] = ...
    }
    return Table
end
local AddFields = function(Name, Description, Inline)
    local Table = {
        ['name'] = Name,
        ['value'] = Description,
        ['inline'] = Inline
    }
    return Table
end

for i,v in pairs(ItemsDropped) do
    if type(v) == 'table' then
        local Table = {}
        table.insert(Table, AddFields('Level', v.Level, true))
        table.insert(Table, AddFields('Rarity', v.Rarity, true))
        if v['Perk 1'] then
            table.insert(Table, AddFields('Perk 1', v['Perk 1'], false))
        end
        if v['Perk 2'] then
            table.insert(Table, AddFields('Perk 2', v['Perk 2'], false))
        end
        if v['Perk 3'] then
            table.insert(Table, AddFields('Perk 3', v['Perk 3'], false))
        end
        table.insert(ItemsTable, AddEmbeds(ItemsMod[i].DisplayKey, i, Table))
    end
end

getgenv().PlayerData = HttpService:JSONEncode({
    ['content'] = '',
    ['embeds'] = {
        unpack(ItemsTable)
    }
})

----------------------------Webhook Stuff--------------------------

local function SendWebhook(Link, Body)
    if Link:match("https://discord.com/api/webhooks/%d.*/%w*") then
        local url = Link
        local data = PlayerData
        local headers = {
            ["content-type"] = "application/json"
        }
        request = http_request or request or HttpPost or syn.request
        request({Url = url, Body = data, Method = "POST", Headers = headers})
    else
        warn("Something went wrong")
    end
end

SendWebhook(MoreFlag.Webhook, PlayerData)
