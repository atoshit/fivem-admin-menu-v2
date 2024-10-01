fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

author 'Atoshi'
description 'Admin Menu V2'
version '1.0.0'

ui_page "client/lib/zUI/web/build/index.html"

files {
    "client/lib/zUI/theme.json",
    "client/lib/zUI/web/build/index.html",
    "client/lib/zUI/web/build/**/*"
}

shared_scripts {
    'libs/*.lua',
    '*.lua'
}

client_scripts {
    -- zUI
    "client/lib/zUI/init.lua",
    "client/lib/zUI/menu.lua",
    "client/lib/zUI/methods/*.lua",
    "client/lib/zUI/functions/*.lua",
    "client/lib/zUI/items/*.lua",

    -- Admin Menu
    "client/functions/*.lua",
    "client/class/*.lua",
    "client/menu/*.lua",
}