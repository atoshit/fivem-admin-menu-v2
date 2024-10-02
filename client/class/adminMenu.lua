--- @class adminMenu
--- @field staffMode boolean
local function createAdminMenuObj()
    local self = {
        staffMode = false,
        newRank = {},
        colors = {},
        ranks = {},
        currentRank = nil
    }

    return self
end

adminMenu = createAdminMenuObj()

function adminMenu:openMenu()
    Menu["main"]:SetVisible(not Menu["main"]:IsVisible())
end

function adminMenu:closeMenu()
    Menu["main"]:SetVisible(false)
end

function adminMenu:getColors()
    self.colors = {}
    for _, color in ipairs(Config.Colors) do
        table.insert(self.colors, color.Label)
    end
end

function adminMenu:getPermissions()
    self.newRank.permissions = {}
    for name, _ in pairs(Perms) do
        self.newRank.permissions[name] = false
    end
end

function adminMenu:createRank()
    table.insert(self.ranks, self.newRank)
    TriggerServerEvent("fivem-admin-menu-v2:createRank", self.newRank)
    self.newRank = { permissions = {} }
end

function adminMenu:getRanks()
    ESX.TriggerServerCallback("fivem-admin-menu-v2:getRanks", function(ranks)
        print(json.encode(ranks))
        self.ranks = ranks
    end)
end
