Menu["rank"] = zUI.CreateSubMenu(Menu["main"], nil, "Version 2.0.0", Config.Menu.Banner)
Menu["createRank"] = zUI.CreateSubMenu(Menu["rank"], nil, Strings["creatingRank"], Config.Menu.Banner)
Menu["editRank"] = zUI.CreateSubMenu(Menu["rank"], nil, Strings["editingRank"], Config.Menu.Banner)
Menu["editingRank"] = zUI.CreateSubMenu(Menu["editRank"], nil, Strings["editingRank"], Config.Menu.Banner)

Menu["rank"]:SetItems(function(Items)
    Items:AddButton(Strings["createRank"], Strings["createRankDescription"], {RightLabel = "→→"}, function()
        adminMenu:getColors()
        adminMenu:getPermissions()
        adminMenu.newRank = { permissions = {} }
    end, Menu["createRank"])

    Items:AddButton(Strings["editingRank"], Strings["editingRankDescription"], {RightLabel = "→→"}, function()
        adminMenu:getColors()
        adminMenu:getPermissions()
        adminMenu:getRanks()
    end, Menu["editRank"])
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
--- @param rank table
local function updateRankName(Items, rank)
    local currentName = rank.name or Strings["undefined"]
    Items:AddButton(Strings["rankName"], Strings["rankNameDescription"], {RightLabel = currentName}, function(onSelected)
        if onSelected then
            local name = zUI.KeyboardInput(Strings["rankName"], nil)
            if name and isValidRankName(name) then
                rank.name = name
                Io.Debug(rank.name)
            else
                Io.Error(Strings["rankNameError"])
            end
        end
    end)
end

--- Update the rank label
--- @param Items Items
--- @param rank table
local function updateRankLabel(Items, rank)
    if not rank.name then return end
    
    local currentLabel = rank.label or Strings["undefined"]
    Items:AddButton(Strings["rankLabel"], Strings["rankLabelDescription"], {RightLabel = currentLabel}, function(onSelected)
        if onSelected then
            local label = zUI.KeyboardInput(Strings["rankLabel"], nil)
            if label and isValidRankLabel(label) then
                rank.label = label
                Io.Debug(rank.label)
            else
                Io.Error(Strings["rankLabelError"])
            end
        end
    end)
end

--- Update the rank color
--- @param Items Items
--- @param rank table
local function updateRankColor(Items, rank)
    if not rank.label then return end
    
    Items:AddList(Strings["rankColor"], Strings["rankColorDescription"], adminMenu.colors, {}, function(onSelected, _, _, index)
        if onSelected then
            rank.color = Config.Colors[index].Color
            Io.Debug(rank.color)
        end
    end)
end

--- Add permissions and create/save button
--- @param Items Items
--- @param rank table
--- @param isEditing boolean
local function addPermissionsAndButton(Items, rank, isEditing)
    if not rank.color then return end
    
    Items:AddLine({ Config.Menu.Color })

    for name, label in pairs(Perms) do
        print(name,  rank.permissions[name])
        local isChecked = rank.permissions[name] or false
        Items:AddCheckbox(label, label, isChecked, {}, function(onSelected)
            if onSelected then
                rank.permissions[name] = not rank.permissions[name]
                print(json.encode(rank.permissions))
            end
        end)
    end

    Items:AddLine({ Config.Menu.Color })

    local buttonText = isEditing and Strings["saveChanges"] or Strings["createRank"]
    local buttonDescription = isEditing and Strings["saveChangesDescription"] or Strings["createRankDescription"]

    Items:AddButton(buttonText, buttonDescription, {RightBadge = "NEW_STAR"}, function(onSelected)
        if onSelected then
            local good = false

            for name, state in pairs(rank.permissions) do
                if state then
                    good = true
                    break
                end
            end

            if not good then
                Io.Error(Strings["rankPermissionsError"])
                return
            end

            if isEditing then
                TriggerServerEvent("fivem-admin-menu-v2:updateRank", rank)
            else
                adminMenu:createRank()
            end
        end
    end)
end

Menu["createRank"]:SetItems(function(Items)
    updateRankName(Items, adminMenu.newRank)
    updateRankLabel(Items, adminMenu.newRank)
    updateRankColor(Items, adminMenu.newRank)
    addPermissionsAndButton(Items, adminMenu.newRank, false)
end)

Menu["editRank"]:SetItems(function(Items)
    for _, v in ipairs(adminMenu.ranks) do
        Items:AddButton(v.label, v.name .. " | " .. v.label, {RightLabel = "→→"}, function()
            adminMenu.rankToEdit = v
        end, Menu["editingRank"])
    end
end)

Menu["editingRank"]:SetItems(function(Items)
    if not adminMenu.rankToEdit then return end
    updateRankName(Items, adminMenu.rankToEdit)
    updateRankLabel(Items, adminMenu.rankToEdit)
    updateRankColor(Items, adminMenu.rankToEdit)
    addPermissionsAndButton(Items, adminMenu.rankToEdit, true)
end)
