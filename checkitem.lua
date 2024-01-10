_G.time = 5
_G.Pass = "123456"
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer:FindFirstChild("DataLoaded")
repeat task.wait()
    local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
    if playerGui:FindFirstChild("Main") and playerGui.Main:FindFirstChild("ChooseTeam") then
        local piratesButtonFrame = playerGui.Main.ChooseTeam.Container.Marines.Frame

        if piratesButtonFrame:FindFirstChild("TextButton") then 
            for _, connection in pairs(getconnections(piratesButtonFrame.TextButton.Activated)) do
                connection.Function()
            end
        end
    end
until game.Players.LocalPlayer.Team ~= nil
local RAMAccount = loadstring(game:HttpGet "https://raw.githubusercontent.com/Bonevn/RAM/main/PC1.lua")()
local MyAccount = RAMAccount.new(game:GetService "Players".LocalPlayer.Name)
if MyAccount then 
function formatNumber(v)
    return tostring(v):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
end
function checkweapon() 
    sw = {}
    local args = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("getInventory")
for i,v in pairs(args) do 
    if v.Type == "Sword" and (v.Rarity == 3 or v.Rarity == 4 )then
        table.insert(sw,v.Name)
end
end
return table.concat(sw,",")
end
function checkgun() 
    sw = {}
    local args = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("getInventory")
for i,v in pairs(args) do 
    if v.Type == "Gun" and (v.Rarity == 3 or v.Rarity == 4 )then
        table.insert(sw,v.Name)
end
end
return table.concat(sw,",")
end
function checkfruit() 
    fruit = {}
    local args = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("getInventory")
for i,v in pairs(args) do 
    if v.Type == "Blox Fruit" then
        if v.Rarity == 3 or v.Rarity == 4 then 
        table.insert(fruit,v.Name)
         end
     end
    end
    return table.concat(fruit,",")
end
local getawaken = (function()
    local v99 = {}
    local v100 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("getAwakenedAbilities")
    if v100 then
        for _, k90 in pairs(v100) do
        wait()
            if k90.Awakened then
                table.insert(v99, k90.Key)
            end
        end
    end
    return table.concat(v99, ", ")
end)
function getSeaLocation()
    local currentPlaceId = game.PlaceId
    if currentPlaceId == 2753915549 then
        return "Sea 1"
    elseif currentPlaceId == 4442272183 then
        return "Sea 2"
    elseif currentPlaceId == 7449423635 then
        return "Sea 3"
    else
        return "Không xác định"
    end
end
function checkspy()
    local seaLocation = getSeaLocation()
    if seaLocation ~= "Sea 3" then
        return seaLocation
    end
    local checkvalue = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("InfoLeviathan","1")
    if checkvalue == -1 then
        return "I Don't Know"
    elseif checkvalue ~= -1 and checkvalue < 5 then
        return "You Can Pay Now"
    elseif checkvalue == 5 then
        return "You can find leviathan now"
    end
end
function checkmelee()
        local checkmelee = {}
    if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySharkmanKarate", true) == 1 then
        table.insert(checkmelee, "Sharkman Karate")
    end
    if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDeathStep", true) == 1 then
        table.insert(checkmelee, "Death Step")
    end
    if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectricClaw", true) == 1 then
        table.insert(checkmelee, "Electric Claw")
    end
    if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDragonTalon", true) == 1 then
        table.insert(checkmelee, "Dragon Talon")
    end
    if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySuperhuman", true) == 1 then
        table.insert(checkmelee, "Superhuman")
    end
    if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyGodhuman", true) == 1 then
        table.insert(checkmelee, "Godhuman")
    end
    if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySanguineArt", true) == 1 then
        table.insert(checkmelee, "Sanguine Art")
    end
    return table.concat(checkmelee, ", ")
end
function checkgatcan()
    local a = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("CheckTempleDoor")
if a then 
    return true
    else 
        return false 
end
end
function checkgatcan2()
    cac = {}
    if checkgatcan() then 
        table.insert(cac,"Đã Gạt Cần") 
    else table.insert(cac,"Chưa Gạt Cần")
end
return table.concat(cac)
end
function checkmirrorvamu()
    checkcheck = {}
    for i, v in pairs(game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("getInventory")    ) do
        if v.Name == "Mirror Fractal" or  v.Name == "Valkyrie Helm" then 
            table.insert(checkcheck,v.Name)
        end
    end
    return table.concat(checkcheck," & ")
end
local function v5()
    local l__LocalPlayer__3 = game.Players.LocalPlayer;
local l__Character__4 = l__LocalPlayer__3.Character;
	for v6, v7 in pairs({ "Last Resort", "Agility", "Water Body", "Heavenly Blood", "Heightened Senses", "Energy Core" }) do
		if l__LocalPlayer__3.Backpack:FindFirstChild(v7) then
			return true;
		end;
		if l__Character__4:FindFirstChild(v7) then
			return true;
		end;
	end;
end;
function checkrace()
    race = {}
    local v113 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "1");
    local v111 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "1")
    if game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed") then
        table.insert(race,game.Players.LocalPlayer.Data.Race.Value.." V4")
    end
 if v113 == -2 and not game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed") then 
         table.insert(race,game.Players.LocalPlayer.Data.Race.Value.." V3")
 end
if v111 == -2 and not v5() and not game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed") then 
        table.insert(race,game.Players.LocalPlayer.Data.Race.Value.." V2") 
end 
if not game:GetService("Players").LocalPlayer.Data.Race:FindFirstChild("Evolved") and not v5() and not game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed") then

    table.insert(race,game.Players.LocalPlayer.Data.Race.Value.." V1")
end
    return table.concat(race)
end
database = {}
datainv = {}
function setalias()
    local asdas = {}
    local hasMirrorFractal = false
    local hasValkyrieHelm = false
    local hasCursedDualKatana = false
    local hasSoulGuitar = false
    local fruit = game:GetService("Players").LocalPlayer.Data.DevilFruit.Value
    awk = getawaken()
    table.insert(asdas, game:GetService("Players").LocalPlayer.Data.Level.Value)
    if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyGodhuman", true) == 1 then
        table.insert(asdas, "GHM")
    end
    if fruit == "Dough-Dough" and awk == "X, C, Z, TAP, F, V" then
        table.insert(asdas, "MCV2")
    end
    -- Lưu kết quả trả về từ InvokeServer để sử dụng lại
    local inventory = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("getInventory")

    -- Kiểm tra các mục trong inventory và cập nhật trạng thái
    for i, v in pairs(inventory) do 
        if v.Name == "Cursed Dual Katana" then 
            hasCursedDualKatana = true
        elseif v.Name == "Soul Guitar" then 
            hasSoulGuitar = true
        elseif v.Name == "Mirror Fractal" then 
            hasMirrorFractal = true
        elseif v.Name == "Valkyrie Helm" then
            hasValkyrieHelm = true
        end
    end
    if hasCursedDualKatana then
        table.insert(asdas, "CDK")
    end
    if hasSoulGuitar then
        table.insert(asdas, "SG")
    end
    if hasMirrorFractal and hasValkyrieHelm then
        table.insert(asdas, "MM")
    end
    return table.concat(asdas, "-")
end
function checkmaterial()
    local material = {}
    local inventory = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(
        "getInventory")
    for i, v in pairs(inventory) do
        if v.Type == "Material" then
            table.insert(material, "x" .. tostring(v.Count) .. " " .. tostring(v.Name))
        end
    end
    return table.concat(material, ", ")
end
function CheckAcientOneStatus()
    status = {}
    if not game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed") then
    return "No Gear"
    end;
    local v227 = nil;
    local v228 = nil;
    local v229 = nil;
    v229, v228, v227 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("UpgradeRace", "Check");
    if v229 == 1 then
    return "Required Train More"
    elseif v229 == 2 or v229 == 4 or v229 == 7 then
    return "Can Buy Gear With "..v227.." Fragments"
    elseif v229 == 3 then
    return "Required Train More"
    elseif v229 == 5 then
    return "Full Gear, Full 5 Training Sessions(Full Update)"
    elseif v229 == 6 then
    return "Gear 3, Upgrades completed: " .. v228 - 2 .. "/3, Need Trains More"
    end
    if v229 ~= 8 then
    if v229 == 0 then 
        return "Ready For Trial"
    else
        return "No Gear"
    end
    end
    return "Full Gear, Remaining " .. 10 - v228 .. " training sessions."
    end

    function checkmasterydf()
        mas = 0
        for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v:IsA("Tool") and v.ToolTip == "Blox Fruit" then
                mas = v.Level.Value
            end
        end
        return mas;
    end
    while wait(_G.time) do 
local ddr = game:GetService("Players").LocalPlayer.Data.DevilFruit.Value
local level = game:GetService("Players").LocalPlayer.Data.Level.Value
local beli = formatNumber(game:GetService("Players").LocalPlayer.Data.Beli.Value)
local fragment = formatNumber(game:GetService("Players").LocalPlayer.Data.Fragments.Value)
MyAccount:SetAlias(setalias())
MyAccount:SetDescription("Level: "..level..", Beli: "..beli..", Frag: "..fragment.."\nMelee: "..checkmelee().."\nSword: "..checkweapon().."\nGun: "..checkgun().."\nMaterial: "..checkmaterial().."\nFruit trong rương: "..checkfruit().."\nFruit Đang Sử Dụng: "..ddr..", Mastery: "..checkmasterydf().."\nAwaken: "..getawaken().."\nRace: "..checkrace().."\nLever Status: "..checkgatcan2().."\nTraining Sessions: "..CheckAcientOneStatus().."\nInventory: "..checkmirrorvamu().."\nStatus SPY: "..checkspy())
    end
else print( MyAccount  )
end
