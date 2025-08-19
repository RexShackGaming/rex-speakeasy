local RSGCore = exports['rsg-core']:GetCoreObject()
local deliveryactive = false
local wagonSpawned = false
local timeractive = false
local DeliverySecondsRemaining = 0
local currentDeliveryWagon = nil
lib.locale()

RegisterNetEvent('rex-speakeasy:client:distributionmenu', function(speakeasyid)

    local Player = RSGCore.Functions.GetPlayerData()
    local job = Player.job.name
    local rank = Player.job.grade.level

    if job ~= speakeasyid then
        lib.notify({ title = locale('cl_lang_65'), duration = 7000, type = 'error' })
        return
    end

    -- job rank must be level 3 or 4
    if job == speakeasyid and rank < 2 then
        lib.notify({ title = locale('cl_lang_14'), duration = 7000, type = 'error' })
        return
    end

    RSGCore.Functions.TriggerCallback('rex-speakeasy:server:getAllBrewerData', function(result)

        local currentstock = result[1].stock

        lib.registerContext({
            id = 'distribution_menu',
            title = locale('cl_lang_15'),
            options = {
                {
                    title = locale('cl_lang_16'),
                    icon = 'fa-solid fa-circle-arrow-down',
                    event = 'rex-speakeasy:client:goodsInStore',
                    args = { speakeasy = speakeasyid },
                    arrow = true
                },
                {
                    title = locale('cl_lang_17'),
                    icon = 'fa-solid fa-circle-arrow-up',
                    event = 'rex-speakeasy:client:goodsOutStore',
                    args = { speakeasy = speakeasyid },
                    arrow = true
                },
                {
                    title = locale('cl_lang_18'),
                    description = locale('cl_lang_19')..currentstock..locale('cl_lang_20'),
                    icon = 'fa-solid fa-plus',
                    event = 'rex-speakeasy:client:addstock',
                    args = { speakeasy = speakeasyid },
                    arrow = true
                },
            }
        })
        lib.showContext('distribution_menu')
        
    end, speakeasyid)

end)

---------------------------------------------
-- goods in storage
---------------------------------------------
RegisterNetEvent('rex-speakeasy:client:goodsInStore', function(data)
    local title = locale('cl_lang_66')
    local storename = 'goodsin_'..data.speakeasy
    local maxweight = Config.GoodsInMaxWeight
    local slots = Config.GoodsInMaxSlots
    TriggerServerEvent('rex-speakeasy:server:openstorage', title, storename, maxweight, slots)
end)

---------------------------------------------
-- goods out storage
---------------------------------------------
RegisterNetEvent('rex-speakeasy:client:goodsOutStore', function(data)
    local title = locale('cl_lang_67')
    local storename = 'goodsout_'..data.speakeasy
    local maxweight = Config.GoodsOutMaxWeight
    local slots = Config.GoodsOutMaxSlots
    TriggerServerEvent('rex-speakeasy:server:openstorage', title, storename, maxweight, slots)
end)

---------------------------------------------
-- add delivery stock
---------------------------------------------
RegisterNetEvent('rex-speakeasy:client:addstock', function(data)

    RSGCore.Functions.TriggerCallback('rex-speakeasy:server:getAllBrewerData', function(result)
    
    local currentstock = result[1].stock

    local input = lib.inputDialog(locale('cl_lang_21'), {
        { 
            label = locale('cl_lang_22'),
            description = locale('cl_lang_23')..currentstock..locale('cl_lang_24'),
            type = 'input',
            required = true,
            icon = 'fa-solid fa-hashtag'
        },
    })

    if not input then
        return
    end

        local updatedstock = currentstock + tonumber(input[1])
        local hasItem = RSGCore.Functions.HasItem('moonshine', tonumber(input[1]))

        if hasItem then
            TriggerServerEvent('rex-speakeasy:server:addstockproduct', tonumber(input[1]), updatedstock, data.speakeasy)
        else
            lib.notify({ title = locale('cl_lang_25'), duration = 7000, type = 'error' })
        end
    
    end, data.speakeasy)
    
end)

---------------------------------------------
-- deliveries
---------------------------------------------
RegisterNetEvent('rex-speakeasy:client:deliverymenu', function(speakeasyid)
    
    RSGCore.Functions.TriggerCallback('rsg-lawman:server:getlaw', function(result)

        -- check how many lawman are on duty before starting the run
        if result < Config.LawmanOnDuty then
            lib.notify({
                title = locale('cl_lang_26'),
                description = locale('cl_lang_27'),
                type = 'error',
                icon = 'fa-solid fa-handcuffs',
                iconAnimation = 'shake',
                duration = 7000
            })
            return
        end
    
        RSGCore.Functions.TriggerCallback('rex-speakeasy:server:getAllBrewerData', function(result)

            if result == nil then return end

            local currentstock = result[1].stock

            --Lemoyne Speakeasy
            if currentstock >= 25 and speakeasyid == 'lemoynese' then

                local options = {}
                for _,v in pairs(Config.LemoyneDeliveryLocations) do
                    options[#options + 1] = {
                        title = v.name,
                        description = v.description,
                        icon = 'fa-solid fa-circle-user',
                        event = 'rex-speakeasy:client:startdelivery',
                        args = { 
                            deliveryid = v.deliveryid,
                            speakeasy = v.speakeasy,
                            cartspawn = v.cartspawn,
                            cart = v.cart,
                            cargo = v.cargo,
                            cargoload = v.cargoload,
                            light = v.light,
                            startcoords = v.startcoords,
                            endcoords = v.endcoords,
                            deliverytime = v.deliverytime,
                            showgps = v.showgps,
                            showblip = v.showblip
                        },
                        arrow = true,
                    }
                end
                lib.registerContext({
                    id = 'lemoynese_delivery_menu',
                    title = locale('cl_lang_28'),
                    position = 'top-right',
                    options = options
                })
                lib.showContext('lemoynese_delivery_menu')

            end

            -- Cattail Pond
            if currentstock >= 25 and speakeasyid == 'cattailse' then

                local options = {}
                for _,v in pairs(Config.CattailDeliveryLocations) do
                    options[#options + 1] = {
                        title = v.name,
                        description = v.description,
                        icon = 'fa-solid fa-circle-user',
                        event = 'rex-speakeasy:client:startdelivery',
                        args = { 
                            deliveryid = v.deliveryid,
                            speakeasy = v.speakeasy,
                            cartspawn = v.cartspawn,
                            cart = v.cart,
                            cargo = v.cargo,
                            cargoload = v.cargoload,
                            light = v.light,
                            startcoords = v.startcoords,
                            endcoords = v.endcoords,
                            deliverytime = v.deliverytime,
                            showgps = v.showgps,
                            showblip = v.showblip
                        },
                        arrow = true,
                    }
                end
                lib.registerContext({
                    id = 'cattailse_delivery_menu',
                    title = locale('cl_lang_29'),
                    position = 'top-right',
                    options = options
                })
                lib.showContext('cattailse_delivery_menu')

            end

            -- New Austin
            if currentstock >= 25 and speakeasyid == 'newaustinse' then

                local options = {}
                for _,v in pairs(Config.NewAustinDeliveryLocations) do
                    options[#options + 1] = {
                        title = v.name,
                        description = v.description,
                        icon = 'fa-solid fa-circle-user',
                        event = 'rex-speakeasy:client:startdelivery',
                        args = { 
                            deliveryid = v.deliveryid,
                            speakeasy = v.speakeasy,
                            cartspawn = v.cartspawn,
                            cart = v.cart,
                            cargo = v.cargo,
                            cargoload = v.cargoload,
                            light = v.light,
                            startcoords = v.startcoords,
                            endcoords = v.endcoords,
                            deliverytime = v.deliverytime,
                            showgps = v.showgps,
                            showblip = v.showblip
                        },
                        arrow = true,
                    }
                end
                lib.registerContext({
                    id = 'newaustinse_delivery_menu',
                    title = locale('cl_lang_30'),
                    position = 'top-right',
                    options = options
                })
                lib.showContext('newaustinse_delivery_menu')

            end

            -- Hanover
            if currentstock >= 25 and speakeasyid == 'hanoverse' then

                local options = {}
                for _,v in pairs(Config.HanoverDeliveryLocations) do
                    options[#options + 1] = {
                        title = v.name,
                        description = v.description,
                        icon = 'fa-solid fa-circle-user',
                        event = 'rex-speakeasy:client:startdelivery',
                        args = { 
                            deliveryid = v.deliveryid,
                            speakeasy = v.speakeasy,
                            cartspawn = v.cartspawn,
                            cart = v.cart,
                            cargo = v.cargo,
                            cargoload = v.cargoload,
                            light = v.light,
                            startcoords = v.startcoords,
                            endcoords = v.endcoords,
                            deliverytime = v.deliverytime,
                            showgps = v.showgps,
                            showblip = v.showblip
                        },
                        arrow = true,
                    }
                end
                lib.registerContext({
                    id = 'hanoverse_delivery_menu',
                    title = locale('cl_lang_31'),
                    position = 'top-right',
                    options = options
                })
                lib.showContext('hanoverse_delivery_menu')

            end

            -- Manzanita Post
            if currentstock >= 25 and speakeasyid == 'manzanitase' then

                local options = {}
                for _,v in pairs(Config.ManzanitaPostDeliveryLocations) do
                    options[#options + 1] = {
                        title = v.name,
                        description = v.description,
                        icon = 'fa-solid fa-circle-user',
                        event = 'rex-speakeasy:client:startdelivery',
                        args = { 
                            deliveryid = v.deliveryid,
                            speakeasy = v.speakeasy,
                            cartspawn = v.cartspawn,
                            cart = v.cart,
                            cargo = v.cargo,
                            cargoload = v.cargoload,
                            light = v.light,
                            startcoords = v.startcoords,
                            endcoords = v.endcoords,
                            deliverytime = v.deliverytime,
                            showgps = v.showgps,
                            showblip = v.showblip
                        },
                        arrow = true,
                    }
                end
                lib.registerContext({
                    id = 'manzanitase_delivery_menu',
                    title = locale('cl_lang_32'),
                    position = 'top-right',
                    options = options
                })
                lib.showContext('manzanitase_delivery_menu')

            end

        end, speakeasyid)
        
    end)

end)

----------------------------------------------------
-- function format delivery time
----------------------------------------------------
function secondsToClock(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local seconds = math.floor(seconds % 60)
    return string.format("%02d:%02d:%02d", hours, minutes, seconds)
end

----------------------------------------------------
-- function drawtext
----------------------------------------------------
function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(9)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
end

----------------------------------------------------
-- delivery timer
----------------------------------------------------
local function DeliveryTimer(deliverytime, vehicle, endcoords)
    
    DeliverySecondsRemaining = (deliverytime * 60)

    CreateThread(function()
        while true do
            if DeliverySecondsRemaining > 0 then
                Wait(1000)
                DeliverySecondsRemaining = DeliverySecondsRemaining - 1
                if DeliverySecondsRemaining == 0 and wagonSpawned == true then
                    ClearGpsMultiRoute(endcoords)
                    endcoords = nil
                    DeleteVehicle(vehicle)
                    wagonSpawned = false
                    deliveryactive = false
                    TriggerServerEvent('rex-speakeasy:server:addstock', cargoload, speakeasy)
                    lib.notify({ title = locale('cl_lang_33'), description = locale('cl_lang_34'), type = 'error' })
                end
            end

            if deliveryactive == true then
                local formattedTime = secondsToClock(DeliverySecondsRemaining)
                lib.showTextUI(locale('cl_lang_35')..formattedTime, {
                    position = "top-center",
                    icon = 'fa-regular fa-clock',
                    style = {
                        borderRadius = 0,
                        backgroundColor = '#82283E',
                        color = 'white'
                    }
                })
                Wait(0)
            else
                lib.hideTextUI()
                return
            end
            Wait(0)
        end
    end)
end

----------------------------------------------------
-- spawn wagon / set delivery
----------------------------------------------------
RegisterNetEvent('rex-speakeasy:client:startdelivery', function(data)

    if not wagonSpawned and not deliveryactive then
        local carthash = joaat(data.cart)
        local cargohash = joaat(data.cargo)
        local lighthash = joaat(data.light)
        local cartspawn = vector3(data.cartspawn.x, data.cartspawn.y, data.cartspawn.z)
        local endcoords = data.endcoords
        local distance = #(cartspawn - endcoords)
        local distancereward = (math.floor(distance) / 100)

        RequestModel(carthash, cargohash, lighthash)
        while not HasModelLoaded(carthash, cargohash, lighthash) do
            RequestModel(carthash, cargohash, lighthash)
            Wait(0)
        end

        local coords = vector3(data.cartspawn.x, data.cartspawn.y, data.cartspawn.z)
        local heading = data.cartspawn.w
        local vehicle = CreateVehicle(carthash, coords, heading, true, false)
        
        SetVehicleOnGroundProperly(vehicle)
        Wait(200)
        SetModelAsNoLongerNeeded(carthash)
        AddPropSetForVehicle(vehicle, cargohash)
        AddLightPropSetToVehicle(vehicle, lighthash)
        TaskEnterVehicle(cache.ped, vehicle, 10000, -1, 1.0, 1, 0)
        if data.showgps == true then
            StartGpsMultiRoute(joaat("COLOR_YELLOW"), true, true)
            AddPointToGpsMultiRoute(endcoords)
            SetGpsMultiRouteRender(true)
        end
        wagonSpawned = true
        deliveryactive = true

        -- alert lawman of the delivery
        if math.random(100) <= Config.CallLawChance then
            TriggerServerEvent('rsg-lawman:server:lawmanAlert', 'monshine delivery is active!')
        end

        -- set constants
        currentDeliveryWagon = vehicle
        cargoload = data.cargoload
        speakeasy = data.speakeasy
        
        TriggerServerEvent('rex-speakeasy:server:removestock', data.cargoload, data.speakeasy)
        DeliveryTimer(data.deliverytime, vehicle, endcoords)

        while true do
            local sleep = 1000
            if wagonSpawned == true then
                local vehpos = GetEntityCoords(vehicle, true)
                local tracker = #(vehpos - endcoords)

                if #(vehpos - endcoords) < 250.0 then
                    sleep = 0
                    DrawText3D(data.endcoords.x, data.endcoords.y, data.endcoords.z + 0.98, 'Delivery Point')
                    if #(vehpos - endcoords) < 3.0 then
                        if data.showgps == true then
                            ClearGpsMultiRoute(endcoords)
                        end
                        endcoords = nil
                        DeleteVehicle(vehicle)
                        SetEntityAsNoLongerNeeded(vehicle)
                        wagonSpawned = false
                        deliveryactive = false
                        lib.hideTextUI()
                        lib.notify({ title = locale('cl_lang_36'), type = 'success' })
                        TriggerServerEvent('rex-speakeasy:server:diliverysuccess', data.cargoload, distancereward, data.speakeasy)
                    end
                end

            end
            Wait(sleep)
        end
        
    end

end)

---------------------------------------------------------------------
-- get wagon state / fail delivery if damaged
---------------------------------------------------------------------
CreateThread(function()
    while true do
        Wait(1000)
        if wagonSpawned then
            local drivable = IsVehicleDriveable(currentDeliveryWagon, false, false)
            if not drivable then
                lib.notify({ title = locale('cl_lang_37'), description = locale('cl_lang_38'), type = 'inform', duration = 7000 })
                DeleteVehicle(currentDeliveryWagon)
                wagonSpawned = false
                deliveryactive = false
                DeliverySecondsRemaining = 0
                SetEntityAsNoLongerNeeded(currentDeliveryWagon)
                wagonSpawned = false
                ClearGpsMultiRoute()
                TriggerServerEvent('rex-speakeasy:server:addstock', cargoload, speakeasy)
                lib.hideTextUI()
            end
        end
    end
end)
