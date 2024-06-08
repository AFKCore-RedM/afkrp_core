fx_version 'cerulean'
games { 'rdr3' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Sasukehteme'
description 'AFK Core'
lua54 'yes'

-- ui_page 'html/index.html'

client_scripts {
    'client/*.lua',
}

shared_script {
    'config.lua',
    'shared/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
}

-- files { -- Credits to https://github.com/LVRP-BEN/bl_coords for clipboard copy method
--     'html/index.html',
--     'html/index.js'
-- }