Menu["rank"] = zUI.CreateSubMenu(Menu["main"], nil, "Version 2.0.0", Config.Menu.Banner)
Menu["createRank"] = zUI.CreateSubMenu(Menu["rank"], nil, Strings["creatingRank"], Config.Menu.Banner)

Menu["rank"]:SetItems(function(Items)
    Items:AddButton(Strings["createRank"], Strings["createRankDescription"], {RightLabel = "→→"}, function()
        adminMenu:getColors()
        adminMenu:getPermissions()
    end, Menu["createRank"])
end)    

--- Verify if the rank name is valid
--- @param name string
--- @return boolean
local function isValidRankName(name)
    return name and not string.find(name, "%u")
end

--- Verify if the rank label is valid
--- @param label string
--- @return boolean
local function isValidRankLabel(label)
    return label and not string.find(label, " ") and string.find(label, "%u")
end

--- Update the rank name
--- @param Items Items
local function updateRankName(Items)
    local currentName = adminMenu.newRank.name or Strings["undefined"]
    Items:AddButton(Strings["rankName"], Strings["rankNameDescription"], {RightLabel = currentName}, function(onSelected)
        if onSelected then
            local name = zUI.KeyboardInput(Strings["rankName"], nil)
            if name and isValidRankName(name) then
                adminMenu.newRank.name = name
                Io.Debug(adminMenu.newRank.name)
            else
                Io.Error(Strings["rankNameError"])
            end
        end
    end)
end

--- Update the rank label
--- @param Items Items
local function updateRankLabel(Items)
    if not adminMenu.newRank.name then return end
    
    local currentLabel = adminMenu.newRank.label or Strings["undefined"]
    Items:AddButton(Strings["rankLabel"], Strings["rankLabelDescription"], {RightLabel = currentLabel}, function(onSelected)
        if onSelected then
            local label = zUI.KeyboardInput(Strings["rankLabel"], nil)
            if label and isValidRankLabel(label) then
                adminMenu.newRank.label = label
                Io.Debug(adminMenu.newRank.label)
            else
                Io.Error(Strings["rankLabelError"])
            end
        end
    end)
end

--- Update the rank color
--- @param Items Items
local function updateRankColor(Items)
    if not adminMenu.newRank.label then return end
    
    Items:AddList(Strings["rankColor"], Strings["rankColorDescription"], adminMenu.colors, {}, function(onSelected, _, _, index)
        if onSelected then
            adminMenu.newRank.color = Config.Colors[index].Color
            Io.Debug(adminMenu.newRank.color)
        end
    end)
end

--- Add permissions and create button
--- @param Items Items
local function addPermissionsAndCreateButton(Items)
    if not adminMenu.newRank.color then return end
    
    Items:AddLine({ Config.Menu.Color })

    for name, label in pairs(Perms) do
        Items:AddCheckbox(label, label, adminMenu.newRank.permissions[name], {}, function(onSelected)
            if onSelected then
                adminMenu.newRank.permissions[name] = not adminMenu.newRank.permissions[name]
                print(json.encode(adminMenu.newRank.permissions))
            end
        end)
    end

    Items:AddLine({ Config.Menu.Color })

    Items:AddButton(Strings["createRank"], Strings["createRankDescription"], {RightBadge = "NEW_STAR"}, function(onSelected)
        if onSelected then
            adminMenu:createRank()
        end
    end)
end

Menu["createRank"]:SetItems(function(Items)
    updateRankName(Items)
    updateRankLabel(Items)
    updateRankColor(Items)
    addPermissionsAndCreateButton(Items)
end)