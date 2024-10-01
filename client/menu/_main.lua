-- TODO -> Add a way to get the player's rank
Menu["main"] = zUI.CreateMenu(nil, "Version 2.0.0", Config.Menu.Banner, nil, nil)

Menu["main"]:SetItems(function (Items)
    Items:AddCheckbox(Strings["staffMode"], Strings["staffModeDescription"], adminMenu.staffMode, {}, function(onSelected, onHovered)
        if onSelected then
            adminMenu.staffMode = not adminMenu.staffMode
        end
    end)

    if adminMenu.staffMode then
        Items:AddLine({ Config.Menu.Color })
        Items:AddButton(Strings["rankManagement"], Strings["rankManagementDescription"], {LeftBadge = 'NEW_STAR', RightLabel = "→→"}, function()
        end, Menu["rank"])
    end
end)
