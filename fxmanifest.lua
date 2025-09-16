fx_version 'cerulean'
game 'gta5'

description 'Givecar & Givecarplate Qbox'
author 'Mekez'
version '1.0.0'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

client_scripts {
    'client.lua'
}