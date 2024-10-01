--- @class adminMenu
--- @field staffMode boolean
local function createAdminMenuObj()
    local self = {
        staffMode = false,
        newRank = {
            permissions = {}
        },
        colors = {}
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
    for _, color in pairs(Config.Colors) do
        self.colors[#self.colors + 1] = color.Label
    end
end

function adminMenu:getPermissions()
    for name, label in pairs(Perms) do
        self.newRank.permissions[name] = false
    end
end