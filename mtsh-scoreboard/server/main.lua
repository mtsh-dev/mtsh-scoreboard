-- DZIEKI ZA POBRANIE / BEDE STARAL SIĘ DLA WAS WRZUCAC WIĘCEJ SKRYPTÓW :D discord mtsh#1761
ESX = nil
local cP = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('mtsh-scoreboard:getcP', function(source, cb)
	cb(cP)
end)

AddEventHandler('esx:setJob', function(playerId, job, lastJob)
	cP[playerId].job = job.name

	TriggerClientEvent('mtsh-scoreboard:updatecP', -1, cP)
end)

AddEventHandler('esx:setThirdJob', function(playerId, job, lastJob)
	cP[playerId].job = job.name

	TriggerClientEvent('mtsh-scoreboard:updatecP', -1, cP)
end)


AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	AddPlayerToScoreboard(xPlayer, true)
end)

AddEventHandler('esx:playerDropped', function(playerId)
	cP[playerId] = nil

	TriggerClientEvent('mtsh-scoreboard:updatecP', -1, cP)
end)





Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		UpdatePing()
	end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.CreateThread(function()
			Citizen.Wait(1000)
			print("==================")
			print("^3ZETKA WYSTARTOWALA")
			print("^3SCOREBOARD BY mtsh")
			print("==================")
			print("[+] DODANO GRACZY DO TABELI")
			print("==================")
			AddPlayersToScoreboard()
		end)
	end
end)

function AddPlayerToScoreboard(xPlayer, update)
	local playerId = xPlayer.source

	cP[playerId] = {}
	cP[playerId].ping = GetPlayerPing(playerId)
	cP[playerId].id = playerId
	cP[playerId].name = xPlayer.getName()
	cP[playerId].job = xPlayer.job.name

	if update then
		TriggerClientEvent('mtsh-scoreboard:updatecP', -1, cP)
	end

	if xPlayer.getGroup() == 'user' then
		Citizen.CreateThread(function()
			Citizen.Wait(3000)
			TriggerClientEvent('mtsh-scoreboard:toggleID', playerId, false)
		end)
	end
end

function AddPlayersToScoreboard()
	local players = ESX.GetPlayers()

	for i=1, #players, 1 do
		local xPlayer = ESX.GetPlayerFromId(players[i])
		AddPlayerToScoreboard(xPlayer, false)
	end

	TriggerClientEvent('mtsh-scoreboard:updatecP', -1, cP)
end

function UpdatePing()
	for k,v in pairs(cP) do
		v.ping = GetPlayerPing(k)
	end

	TriggerClientEvent('mtsh-scoreboard:updatePing', -1, cP)
end

RegisterServerEvent('mtsh-scoreboard:Show')
AddEventHandler('mtsh-scoreboard:Show', function(text)
	local _source = source
	TriggerClientEvent("sendProximityMessageMe", -1, _source, _source, text)
end)



ESX.RegisterServerCallback('mtsh-pingpong', function(source, cb)
	local data = GetPlayerPing(source)
	cb(data)
end)


-- DZIEKI ZA POBRANIE / BEDE STARAL SIĘ DLA WAS WRZUCAC WIĘCEJ SKRYPTÓW :D discord mtsh#1761