fx_version 'cerulean'
game 'gta5'

author 'TheStoicBear'
description 'StoicMDT-911'
version '1.0.0'
lua54 'yes'
ui_page 'ui/index.html'

shared_scripts {
    'config.lua',
    "@ND_Core/init.lua",
    '@ox_lib/init.lua',
}
client_scripts {
    'src/incident_ui.lua',
    'src/phones.lua',
    'src/notifypd_c.lua'
}

server_scripts {
    'src/notifypd_s.lua'
}

files {
    'ui/index.html',
    'ui/incident.css'
}

