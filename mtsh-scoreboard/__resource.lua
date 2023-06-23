resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
author 'mtsh#1761'
description 'mtsh-scoreboard'

version '1.0'

server_script 'server/main.lua'

client_script 'client/main.lua'

ui_page 'html/scoreboard.html'

files {
	'html/scoreboard.html',
	'html/style.css',
	'html/listener.js',
	'html/img/*.png',
}