-- TODO -> Add a way to get the player's rank
Menu["main"] = zUI.CreateMenu(nil, "Version 2.0.0", Config.Menu.Banner, nil, nil)

local cachedMenuItems = {}

Menu["main"]:SetItems(function (Items)
    if not cachedMenuItems[1] then
        cachedMenuItems[1] = Items:AddCheckbox(Strings["staffMode"], Strings["staffModeDescription"], adminMenu.staffMode, {}, function(onSelected, onHovered)
            if onSelected then
                adminMenu.staffMode = not adminMenu.staffMode
            end
        end)
    else
        cachedMenuItems[1]:SetChecked(adminMenu.staffMode)
    end

    if adminMenu.staffMode then
        if not cachedMenuItems[2] then
            cachedMenuItems[2] = Items:AddLine({ Config.Menu.Color })
        end
        if not cachedMenuItems[3] then
            cachedMenuItems[3] = Items:AddButton(Strings["rankManagement"], Strings["rankManagementDescription"], {LeftBadge = 'NEW_STAR', RightLabel = "→→"}, function()
                adminMenu:updateRanksIfNeeded()
            end, Menu["rank"])
        end
    else
        cachedMenuItems[2] = nil
        cachedMenuItems[3] = nil
    end
end)