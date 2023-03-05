fx_version 'cerulean'
game 'gta5'

author 'Your Name'
description 'ESX NPC Spawner'

client_scripts {
    'client.lua',
    '@es_extended/locale.lua',
    'locales/en.lua',
    'config.lua'
}

server_scripts {
    'server.lua',
    '@es_extended/locale.lua',
    'locales/en.lua',
    'config.lua'
}

dependencies {
    'es_extended'
}