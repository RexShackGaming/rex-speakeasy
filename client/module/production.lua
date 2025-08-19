local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()

RegisterNetEvent('rex-speakeasy:client:brewermenu', function(speakeasyid)

    local Player = RSGCore.Functions.GetPlayerData()
    local job = Player.job.name
    local rank = Player.job.grade.level

    if job ~= speakeasyid then
        lib.notify({ title = locale('cl_lang_65'), duration = 7000, type = 'error' })
        return
    end

    -- job rank must be level 3 or 4
    if job == speakeasyid and rank < 3 then
        lib.notify({ title = locale('cl_lang_40'), duration = 7000, type = 'error' })
        return
    end

    RSGCore.Functions.TriggerCallback('rex-speakeasy:server:getAllBrewerData', function(result)

        local corn = result[1].corn
        local sugar = result[1].sugar
        local water = result[1].water
        local yeast = result[1].yeast
        local mash = result[1].mash
        local jug = result[1].jug
        local moonshine = result[1].moonshine

        lib.registerContext({
            id = 'brewer_menu',
            title = locale('cl_lang_41'),
            options = {
                {
                    title = locale('cl_lang_42'),
                    icon = 'fa-solid fa-plus',
                    event = 'rex-speakeasy:client:addingredience',
                    args = { speakeasy = speakeasyid },
                    arrow = true
                },
                {
                    title = locale('cl_lang_43').. corn,
                    progress = corn,
                    colorScheme = 'green',
                    icon = 'fa-solid fa-box'
                },
                {
                    title = locale('cl_lang_44').. sugar,
                    progress = sugar,
                    colorScheme = 'green',
                    icon = 'fa-solid fa-box'
                },
                {
                    title = locale('cl_lang_45').. water,
                    progress = water,
                    colorScheme = 'green',
                    icon = 'fa-solid fa-box'
                },
                {
                    title = locale('cl_lang_46').. yeast,
                    progress = yeast,
                    colorScheme = 'green',
                    icon = 'fa-solid fa-box'
                },
                {
                    title = locale('cl_lang_47').. jug,
                    progress = jug,
                    colorScheme = 'green',
                    icon = 'fa-solid fa-box'
                },
                {
                    title = locale('cl_lang_48').. mash,
                    progress = mash,
                    colorScheme = 'green',
                    icon = 'fa-solid fa-box'
                },
                {
                    title = locale('cl_lang_49').. moonshine,
                    progress = moonshine,
                    colorScheme = 'green',
                    icon = 'fa-solid fa-right-from-bracket'
                },
                {
                    title = locale('cl_lang_50'),
                    icon = 'fa-solid fa-minus',
                    event = 'rex-speakeasy:client:collectproduct',
                    args = { speakeasy = speakeasyid },
                    arrow = true
                },
            }
        })
        lib.showContext('brewer_menu')

    end, speakeasyid)

end)


---------------------------------
-- add production items
---------------------------------
RegisterNetEvent('rex-speakeasy:client:addingredience', function(data)

    RSGCore.Functions.TriggerCallback('rex-speakeasy:server:getAllBrewerData', function(result)
    
        local corn = result[1].corn
        local sugar = result[1].sugar
        local water = result[1].water
        local yeast = result[1].yeast
        local jug = result[1].jug

        local input = lib.inputDialog('Add Ingredience', {
            { 
                label = 'Incrdient',
                type = 'select',
                options = { 
                    { value = 'corn', label = locale('cl_lang_51') }, 
                    { value = 'sugar', label = locale('cl_lang_52') },
                    { value = 'water', label = locale('cl_lang_53') },
                    { value = 'yeast', label = locale('cl_lang_54') },
                    { value = 'jug', label = locale('cl_lang_55') },
                },
                required = true
            },
            { 
                label = locale('cl_lang_56'),
                type = 'input',
                required = true,
                icon = 'fa-solid fa-hashtag'
            },
        })

        if not input then
            return
        end

        -- corn for production
        if input[1] == 'corn' then
            local totalcorn = corn + tonumber(input[2])
            local hasItem = RSGCore.Functions.HasItem('corn', tonumber(input[2]))
            if hasItem then
                if totalcorn <= Config.MaxCorn then
                    TriggerServerEvent('rex-speakeasy:server:addproduct', input[1], tonumber(input[2]), totalcorn, data.speakeasy)
                else
                    lib.notify({ title = locale('cl_lang_57'), duration = 7000, type = 'error' })
                end
            else
                lib.notify({ title = locale('cl_lang_58'), duration = 7000, type = 'error' })
            end
        end

        -- sugar for production
        if input[1] == 'sugar' then
            local totalsugar = sugar + tonumber(input[2])
            local hasItem = RSGCore.Functions.HasItem('sugar', tonumber(input[2]))
            if hasItem then
                if totalsugar <= Config.MaxSugar then
                    TriggerServerEvent('rex-speakeasy:server:addproduct', input[1], tonumber(input[2]), totalsugar, data.speakeasy)
                else
                    lib.notify({ title = locale('cl_lang_57'), duration = 7000, type = 'error' })
                end
            else
                lib.notify({ title = locale('cl_lang_59'), duration = 7000, type = 'error' })
            end
        end

        -- water for production
        if input[1] == 'water' then
            local totalwater = water + tonumber(input[2])
            local hasItem = RSGCore.Functions.HasItem('water', tonumber(input[2]))
            if hasItem then
                if totalwater <= Config.MaxWater then
                    TriggerServerEvent('rex-speakeasy:server:addproduct', input[1], tonumber(input[2]), totalwater, data.speakeasy)
                else
                    lib.notify({ title = locale('cl_lang_57'), duration = 7000, type = 'error' })
                end
            else
                lib.notify({ title = locale('cl_lang_60'), duration = 7000, type = 'error' })
            end
        end
        
        -- yeast for production
        if input[1] == 'yeast' then
            local totalyeast = yeast + tonumber(input[2])
            local hasItem = RSGCore.Functions.HasItem('yeast', tonumber(input[2]))
            if hasItem then
                if totalyeast <= Config.MaxYeast then
                    TriggerServerEvent('rex-speakeasy:server:addproduct', input[1], tonumber(input[2]), totalyeast, data.speakeasy)
                else
                    lib.notify({ title = locale('cl_lang_57'), duration = 7000, type = 'error' })
                end
            else
                lib.notify({ title = locale('cl_lang_61'), duration = 7000, type = 'error' })
            end
        end
        
        -- empty jug to store moonshine
        if input[1] == 'jug' then
            local totaljug = jug + tonumber(input[2])
            local hasItem = RSGCore.Functions.HasItem('jug', tonumber(input[2]))
            if hasItem then
                if totaljug <= Config.MaxJug then
                    TriggerServerEvent('rex-speakeasy:server:addproduct', input[1], tonumber(input[2]), totaljug, data.speakeasy)
                else
                    lib.notify({ title = locale('cl_lang_57'), duration = 7000, type = 'error' })
                end
            else
                lib.notify({ title = locale('cl_lang_62'), duration = 7000, type = 'error' })
            end
        end

    end, data.speakeasy)

end)

---------------------------------
-- collect product
---------------------------------
RegisterNetEvent('rex-speakeasy:client:collectproduct', function(data)

    RSGCore.Functions.TriggerCallback('rex-speakeasy:server:getAllBrewerData', function(result)

        local moonshine = result[1].moonshine

        if moonshine == 0 then
            lib.notify({ title = locale('cl_lang_64'), duration = 7000, type = 'error' })
            return
        end

        LocalPlayer.state:set("inv_busy", true, true) -- lock inventory
        lib.progressBar({
            duration = moonshine * Config.CollectTime,
            position = 'bottom',
            useWhileDead = false,
            canCancel = false,
            disableControl = true,
            disable = {
                move = true,
                mouse = true,
            },
            label = locale('cl_lang_63'),
        })
        TriggerServerEvent('rex-speakeasy:server:collectproduct', moonshine, data.speakeasy)
        LocalPlayer.state:set("inv_busy", false, true) -- unlock inventory

    end, data.speakeasy)

end)
