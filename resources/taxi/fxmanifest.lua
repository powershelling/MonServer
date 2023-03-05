fx_version 'cerulean'
game 'gta5'

author 'Your Name'
description 'Spawn Infernus with NPC driver'
version '1.0.0'

client_scripts {
    '@es_extended/locale.lua',
    'locales/fr.lua', -- change the language file as necessary
}

server_script 'server.lua'

dependencies {
    'es_extended'
}
