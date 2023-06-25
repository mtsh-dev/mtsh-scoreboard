-- DZIEKI ZA POBRANIE / BEDE STARAL SIĘ DLA WAS WRZUCAC WIĘCEJ SKRYPTÓW :D discord mtsh#1761
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local uptm = GetPlayerServerId(PlayerId())
local IdOn = true
local tablist = false


ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('one:getsharedobject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(2000)
	ESX.TriggerServerCallback('mtsh-scoreboard:getcP', function(cP)
		UpdatePlayerTable(cP)
		Citizen.Wait(5000)
		playerData = ESX.GetPlayerData()
	end)
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
	local data = playerData
	ESX.PlayerData = playerData
	local job = data.job
	SendNUIMessage({
		action = "updateJob", 
		praca = job.label.." - "..job.grade_label
	});

	SendNUIMessage({
		action = "updateJob2", 
		praca2 = thirdjob.label.." - "..thirdjob.grade_label
	});
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	SendNUIMessage({action = "updateJob", praca = job.label.." - "..job.grade_label})
end)

RegisterNetEvent('esx:setThirdJob')
AddEventHandler('esx:setThirdJob', function(thirdjob)
	SendNUIMessage({action = "updateJob2", praca2 = thirdjob.label.." - "..thirdjob.grade_label})
end)





Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		uptm = GetPlayerServerId(PlayerId())
		if uptm == nil or uptm == '' then
			uptm = GetPlayerServerId(PlayerId())
		end
	end
end)

Citizen.CreateThread(function()
	Citizen.Wait(500)
	uptm = GetPlayerServerId(PlayerId())
	if uptm == nil or uptm == '' then
		uptm = GetPlayerServerId(PlayerId())
	end
	SendNUIMessage({
		action = 'updateServerInfo',

		maxPlayers = GetConvarInt('sv_maxclients', 128),
		uptime = uptm,
	})
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
			if IsControlJustPressed(1, 20) then
										TriggerServerEvent('mtsh-scoreboard:Show', "przeglada wykaz mieszkancow")
		end
	end
end)

RegisterNetEvent('mtsh-scoreboard:updatecP')
AddEventHandler('mtsh-scoreboard:updatecP', function(cP)
	UpdatePlayerTable(cP)
end)

RegisterNetEvent('mtsh-scoreboard:updatePing')
AddEventHandler('mtsh-scoreboard:updatePing', function(cP)
	SendNUIMessage({
		action  = 'updatePing',
		players = cP
	})
end)

RegisterNetEvent('mtsh-scoreboard:toggleID')
AddEventHandler('mtsh-scoreboard:toggleID', function(state)
	if state then
		IdOn = state
	else
		IdOn = not IdOn
	end

	SendNUIMessage({
		action = 'toggleID',
		state = IdOn
	})
end)



RegisterNetEvent('uptime:tick')
AddEventHandler('uptime:tick', function(uptime)
	uptm = GetPlayerServerId(PlayerId())
	if uptm == nil or uptm == '' then
		uptm = GetPlayerServerId(PlayerId())
	end
	SendNUIMessage({
		action = 'updateServerInfo',
		uptime = uptm
	})
end)

function UpdatePlayerTable(cP)
	local formattedPlayerList, num = {}, 1
	local ems, police, taxi, mecano, cardealer, safj, players = 0, 0, 0, 0, 0, 0, 0, 0

	for k,v in pairs(cP) do

		table.insert(formattedPlayerList, ('<tr><td>%s</td><td>%s</td><td>%s</td>'):format(v.name, v.id, v.ping))

		players = players + 1

		if v.job == 'ambulance' then
			ems = ems + 1
		elseif v.job == 'police' then
			police = police + 1
		elseif v.job == 'mecano' then
			mecano = mecano + 1
		end
	end

	if num == 1 then
		table.insert(formattedPlayerList, '</tr>')
	end

	if police <= 4 then
		SendNUIMessage({
			action = 'updatePlayerJobs',
			jobs   = {ems = ems, police = police,  mecano = mecano,  player_count = players}
		})
	elseif police > 4 then
		SendNUIMessage({
			action = 'updatePlayerJobs',
			jobs   = {ems = ems, police = '4+',  mecano = mecano,   player_count = players}
		})
	end

	local pingpong = nil

	ESX.TriggerServerCallback('mtsh-pingpong', function(data)
		local deta = data
		pingpong = deta
		
		SendNUIMessage({
			action = 'updateServerInfo',
			playTime = pingpong
		})

	end)

end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(0, Keys['Z']) and IsInputDisabled(0) then
			ToggleScoreBoard()
			tablist = true
			TriggerServerEvent('mtsh-scoreboard', GetPlayerServerId(PlayerId()))
		end
		if IsControlJustReleased(0, Keys['Z']) and IsInputDisabled(0) then
			ToggleScoreBoard()
			tablist = false
			ClearPedTasks(PlayerPedId()) 
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300)

		if IsPauseMenuActive() and not IsPaused then
			IsPaused = true
			SendNUIMessage({
				action  = 'close'
			})
		elseif not IsPauseMenuActive() and IsPaused then
			IsPaused = false
		end
	end
end)

function ToggleScoreBoard()
	SendNUIMessage({
		action = 'toggle'
	})
end
-- id
local showPlayerBlips = false
local ignorePlayerNameDistance = false
local playerNamesDist = 20
local displayIDHeight = 1.2 

local red = 255
local green = 255
local blue = 255

function DrawText3D(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.0*scale, 1.5*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(red, green, blue, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
		World3dToScreen2d(x,y,z, 0) 
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlPressed(1, 48) then
            for i=0,99 do
                N_0x31698aa80e0223f8(i)
            end
            for id = 0, 255 do
                if  ((NetworkIsPlayerActive( id )) and GetPlayerPed( id ) ~= GetPlayerPed( -1 )) then
                ped = GetPlayerPed( id )
                blip = GetBlipFromEntity( ped ) 
 
                x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
                x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )
                distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))

                if(ignorePlayerNameDistance) then
					if NetworkIsPlayerTalking(id) then
						red = 83
						green = 245
						blue = 151
						DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id))
					else
						red = 255
						green = 255
						blue = 255
						DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id))
					end
                end

                if ((distance < playerNamesDist)) then
                    if not (ignorePlayerNameDistance) then
						if NetworkIsPlayerTalking(id) then
							red = 83
							green = 245
							blue = 151
							DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id))
						else
							red = 255
							green = 255
							blue = 255
							DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id))
						end
                    end
                end  
            end
        end
        elseif not IsControlPressed(1, 48) then
            DrawText3D(0, 0, 0, "")
        end
    end
end)

-- DZIEKI ZA POBRANIE / BEDE STARAL SIĘ DLA WAS WRZUCAC WIĘCEJ SKRYPTÓW :D discord mtsh#1761
