local ranks = {}

RegisterServerEvent("fivem-admin-menu-v2:createRank")
AddEventHandler("fivem-admin-menu-v2:createRank", function(rank)
    print(json.encode(rank))
    ranks[#ranks + 1] = rank
    local author = GetPlayerName(source)

    MySQL.Sync.execute("INSERT INTO admin_ranks (author, date, name, label, color, permissions) VALUES (@author, @date, @name, @label, @color, @permissions)", {
        ["@author"] = author,
        ["@date"] = os.date("%Y-%m-%d %H:%M:%S"),
        ["@name"] = rank.name,
        ["@label"] = rank.label,
        ["@color"] = rank.color,
        ["@permissions"] = json.encode(rank.permissions)
    })

    Io.Success("Le rang " .. rank.label .. " a été créé avec succès !")
end)

AddEventHandler("onResourceStart", function(resource)
    if GetCurrentResourceName() ~= resource then return end
    local result = MySQL.Sync.fetchAll("SELECT * FROM admin_ranks")
    for _, rank in ipairs(result) do
        ranks[#ranks + 1] = rank
    end
    print(json.encode(ranks))
end)