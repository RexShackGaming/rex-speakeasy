local RSGCore = exports['rsg-core']:GetCoreObject()
local cardname = nil
lib.locale()

---------------------------------
-- prompts and blips
---------------------------------
CreateThread(function()
    for _, v in pairs(Config.SpeakeasyData) do
        exports['rsg-core']:createPrompt(v.prompt, v.coords, RSGCore.Shared.Keybinds[Config.KeyBind], v.name, {
            type = 'client',
            event = 'rex-speakeasy:client:useteleport',
            args = { v.item, v.destination, v.jobaccess },
        })
        if v.showblip == true then    
            local Blip = BlipAddForCoords(1664425300, v.coords)
            SetBlipSprite(Blip, joaat(v.blipsprite), true)
            SetBlipScale(Blip, v.blipscale)
            SetBlipName(Blip, v.blipname)
        end
    end
end)

---------------------------------
-- teleportation logic 
---------------------------------
RegisterNetEvent('rex-speakeasy:client:useteleport')
AddEventHandler('rex-speakeasy:client:useteleport', function(item, destination, jobaccess)

    local Player = RSGCore.Functions.GetPlayerData()
    local job = Player.job.name
    local hasItem = RSGCore.Functions.HasItem(item)

    if hasItem or jobaccess == job then
        DoScreenFadeOut(500)
        Wait(1000)
        SetEntityCoordsAndHeading(cache.ped, destination)
        Wait(1500)
        DoScreenFadeIn(1800)
    else
        lib.notify({ title = locale('cl_lang_1'), duration = 7000, type = 'error' })
    end

end)

---------------------------------
-- manager menu
---------------------------------
RegisterNetEvent('rex-speakeasy:client:managermenu', function(speakeasyid)

    local Player = RSGCore.Functions.GetPlayerData()
    local job = Player.job.name
    local isboss = Player.job.isboss

    if job == speakeasyid and isboss then
        lib.registerContext({
            id = 'manager_menu',
            title = locale('cl_lang_2'),
            options = {
                {
                    title = locale('cl_lang_3'),
                    description = locale('cl_lang_4'),
                    icon = 'fa-solid fa-user-tie',
                    event = 'rsg-bossmenu:client:mainmenu',
                    arrow = true
                },
                {
                    title = locale('cl_lang_5'),
                    description = locale('cl_lang_6')..Config.CardCreationCost..locale('cl_lang_7'),
                    icon = 'fa-solid fa-user-tie',
                    event = 'rex-speakeasy:client:makecards',
                    args = { speakeasy = speakeasyid },
                    arrow = true
                },
            }
        })
        lib.showContext('manager_menu')
    else
        lib.notify({ title = locale('cl_lang_8'), duration = 7000, type = 'error' })
    end

end)

---------------------------------
-- manager create memebership cards
---------------------------------
RegisterNetEvent('rex-speakeasy:client:makecards', function(data)

    local input = lib.inputDialog(locale('cl_lang_9'), {
        { 
            label = locale('cl_lang_10'),
            type = 'input',
            required = true,
            icon = 'fa-solid fa-hashtag'
        },
    })

    if not input then
        return
    end

    if data.speakeasy == 'lemoynese' then
        cardname = 'lemoynemember'
    end
    
    if data.speakeasy == 'cattailse' then
        cardname = 'lemoynemember'
    end
    
    if data.speakeasy == 'newaustinse' then
        cardname = 'lemoynemember'
    end

    if data.speakeasy == 'hanoverse' then
        cardname = 'lemoynemember'
    end

    if data.speakeasy == 'manzanitase' then
        cardname = 'lemoynemember'
    end
    
    local totalcost = Config.CardCreationCost * input[1]
    local maketime = Config.MakeTime * input[1]
    local Player = RSGCore.Functions.GetPlayerData()
    
    RSGCore.Functions.TriggerCallback('rsg-bossmenu:server:GetAccount', function(cb)

        if cb > totalcost then
        
            LocalPlayer.state:set("inv_busy", true, true) -- lock inventory
            lib.progressBar({
                duration = maketime,
                position = 'bottom',
                useWhileDead = false,
                canCancel = false,
                disableControl = true,
                disable = {
                    move = true,
                    mouse = true,
                },
                label = locale('cl_lang_11'),
            })
            TriggerServerEvent('rex-speakeasy:server:membershipcards', cardname, input[1], totalcost)
            LocalPlayer.state:set("inv_busy", false, true) -- unlock inventory
            
        else
            lib.notify({ title = locale('cl_lang_12'), description = locale('cl_lang_13'), duration = 7000, type = 'error' })
        end
    end, Player.job.name)
end)
