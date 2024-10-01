AdminMenu["main"] = zUI.CreateMenu(nil, nil, Config.Menu.Banner, nil, nil)

AdminMenu["main"]:SetItems(function (Items)
    Items:AddCheckbox(Strings["staffMode"], Strings["staffModeDescription"], adminMenu.staffMode, {}, function(onSelected, onHovered)
        if onSelected then
            adminMenu.staffMode = not adminMenu.staffMode
        end
    end)

    if adminMenu.staffMode then
        Items:AddLine({ Config.Menu.Color })
    end
end)
