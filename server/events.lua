ranks = {}

local insertRankStmt = "INSERT INTO admin_ranks (author, date, name, label, color, permissions) VALUES (?, ?, ?, ?, ?, ?)"

RegisterServerEvent("fivem-admin-menu-v2:createRank")
AddEventHandler("fivem-admin-menu-v2:createRank", function(rank)
    local author = GetPlayerName(source)
    local discord = GetPlayerIdentifierByType(source, "discord")
    local discordId = discord:gsub("discord:", "")

    -- Vérifiez que toutes les valeurs nécessaires sont présentes
    if not rank.name or not rank.label or not rank.color or not rank.permissions then
        print("Erreur : Données de rang incomplètes")
        return
    end

    -- Assurez-vous que permissions est une chaîne JSON valide
    local permissionsJson = json.encode(rank.permissions)
    if not permissionsJson then
        print("Erreur : Impossible d'encoder les permissions en JSON")
        return
    end

    MySQL.Async.execute(insertRankStmt, {
        author,
        os.date("%Y-%m-%d %H:%M:%S"),
        rank.name,
        rank.label,
        rank.color,
        permissionsJson
    }, function(affectedRows)
        if affectedRows and affectedRows > 0 then
            ranks[#ranks + 1] = rank
            Io.Success(author .. " a créé le rang ^3" .. rank.label .. "^7 avec succès !")
            queueWebhook(Webhooks["rank.create"], 3145581, Strings["creatingRank"], 
                ("**%s**: <@%s> \n**%s**: ```%s``` \n**%s**: ```%s``` \n**%s**: ```%s``` \n**%s**: ```%s```")
                :format(Strings["author"], discordId, Strings["rankName"], rank.name, Strings["rankLabel"], rank.label, Strings["rankColor"], rank.color, Strings["rankPermissions"], permissionsJson), 
            "")
        else
            print("Erreur lors de l'insertion du rang dans la base de données")
        end
    end)
end)

local function updateRanksCache()
    local result = MySQL.Sync.fetchAll("SELECT * FROM admin_ranks")
    for _, rank in ipairs(result) do
        ranks[#ranks + 1] = {
            id = rank.id,
            name = rank.name,
            label = rank.label,
            color = rank.color,
            permissions = json.decode(rank.permissions)
        }
    end
end

AddEventHandler("onResourceStart", function(resource)
    if GetCurrentResourceName() ~= resource then return end
    updateRanksCache()
end)

ESX.RegisterServerCallback("fivem-admin-menu-v2:getRanks", function(source, cb)
    cb(ranksCache)
end)