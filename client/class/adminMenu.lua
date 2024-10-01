--- @class adminMenu
--- @field staffMode boolean
local function createAdminMenuObj()
    local self = {
        staffMode = false,
        newRank = {},
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
