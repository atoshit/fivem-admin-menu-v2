Menu["rank"] = zUI.CreateSubMenu(Menu["main"], nil, "Version 2.0.0", Config.Menu.Banner)
Menu["createRank"] = zUI.CreateSubMenu(Menu["rank"], nil, Strings["creatingRank"], Config.Menu.Banner)

Menu["rank"]:SetItems(function(Items)
    Items:AddButton(Strings["createRank"], Strings["createRankDescription"], {RightLabel = "→→"}, function()
        adminMenu:getColors()
    end, Menu["createRank"])
end)    

Menu["createRank"]:SetItems(function(Items)
    if not adminMenu.newRank.name then
        Items:AddButton(Strings["rankName"], Strings["rankNameDescription"], {RightLabel = Strings["undefined"]}, function(onSelected)
            if onSelected then
                local name = zUI.KeyboardInput(Strings["rankName"], nil)

                if name ~= nil then
                    adminMenu.newRank.name = tostring(name)
                    Io.Debug(adminMenu.newRank.name)
                end
            end
        end)
    else
        Items:AddButton(Strings["rankName"], Strings["rankNameDescription"], {RightLabel = adminMenu.newRank.name}, function(onSelected)
            if onSelected then
                local name = zUI.KeyboardInput(Strings["rankName"], nil)

                if name ~= nil then
                    adminMenu.newRank.name = name
                    Io.Debug(adminMenu.newRank.name)
                end
            end
        end)
    end

    if adminMenu.newRank.name and not adminMenu.newRank.label then
        Items:AddButton(Strings["rankLabel"], Strings["rankLabelDescription"], {RightLabel = Strings["undefined"]}, function(onSelected)
            if onSelected then
                local label = zUI.KeyboardInput(Strings["rankLabel"], nil)

                if label ~= nil then
                    adminMenu.newRank.label = tostring(label)
                    Io.Debug(adminMenu.newRank.label)
                end
            end
        end)
    elseif adminMenu.newRank.name and adminMenu.newRank.label then
        Items:AddButton(Strings["rankLabel"], Strings["rankLabelDescription"], {RightLabel = adminMenu.newRank.label}, function(onSelected)
            if onSelected then
                local label = zUI.KeyboardInput(Strings["rankLabel"], nil)

                if label ~= nil then
                    adminMenu.newRank.label = tostring(label)
                    Io.Debug(adminMenu.newRank.label)
                end
            end
        end)
    end

    if adminMenu.newRank.name and adminMenu.newRank.label and not adminMenu.newRank.color then
        Items:AddList(Strings["rankColor"], Strings["rankColorDescription"], adminMenu.colors, {}, function(onSelected, onHovered, onListChange, index)
            if onSelected then
                adminMenu.newRank.color = Config.Colors[index].Color
                Io.Debug(adminMenu.newRank.color)
            end
        end)
    elseif adminMenu.newRank.name and adminMenu.newRank.label and adminMenu.newRank.color then
        Items:AddList(Strings["rankColor"], Strings["rankColorDescription"], adminMenu.colors, {}, function(onSelected, onHovered, onListChange, index)
            if onSelected then
                adminMenu.newRank.color = Config.Colors[index].Color
                Io.Debug(adminMenu.newRank.color)
            end
        end)
    end
end)

