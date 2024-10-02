local ranks = {}

RegisterServerEvent("fivem-admin-menu-v2:createRank")
AddEventHandler("fivem-admin-menu-v2:createRank", function(rank)
    ranks[#ranks + 1] = rank

    local author = GetPlayerName(source)
    local discord = GetPlayerIdentifierByType(source, "discord")
    local discordId = discord:gsub("discord:", "")

    MySQL.Sync.execute("INSERT INTO admin_ranks (author, date, name, label, color, permissions) VALUES (@author, @date, @name, @label, @color, @permissions)", {
        ["@author"] = author,
        ["@date"] = os.date("%Y-%m-%d %H:%M:%S"),
        ["@name"] = rank.name,
        ["@label"] = rank.label,
        ["@color"] = rank.color,
        ["@permissions"] = json.encode(rank.permissions)
    })

    Io.Success(author .. " a créé le rang ^3" .. rank.label .. "^7 avec succès !")
    sendLog(Webhooks["rank.create"], 3145581, Strings["creatingRank"], ("**%s**: <@%s> \n**%s**: ```%s``` \n**%s**: ```%s``` \n**%s**: ```%s``` \n**%s**: ```%s```"):format(Strings["author"], discordId, Strings["rankName"], rank.name, Strings["rankLabel"], rank.label, Strings["rankColor"], rank.color, Strings["rankPermissions"], json.encode(rank.permissions)), "")
end)

AddEventHandler("onResourceStart", function(resource)
    if GetCurrentResourceName() ~= resource then return end
    local result = MySQL.Sync.fetchAll("SELECT * FROM admin_ranks")
    for _, rank in ipairs(result) do
        ranks[#ranks + 1] = rank
        Io.Success("Le rang ^3" .. rank.label .. "^7 a été chargé avec succès !")
    end
end)