fx_version 'cerulean'
game 'gta5'

author 'Jules'
description 'Skrypt powitalny z wyborem postaci dla ESX'
version '1.0.0'

shared_script 'config.lua'

server_scripts {
    '@es_extended/locale.lua',
    'server/main.lua'
}

client_script 'client/main.lua'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

dependency 'es_extended'
