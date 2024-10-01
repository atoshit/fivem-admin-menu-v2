--- @class adminMenu
--- @field staffMode boolean
local function createAdminMenuObj()
    local self = {
        staffMode = false
    }

    return self
end

adminMenu = createAdminMenuObj()

function adminMenu:openMenu()
    AdminMenu["main"]:SetVisible(not AdminMenu["main"]:IsVisible())
end

function adminMenu:closeMenu()
    AdminMenu["main"]:SetVisible(false)
end