local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()

---------------------------------------------
-- get all brewer data
---------------------------------------------
RSGCore.Functions.CreateCallback('rex-speakeasy:server:getAllBrewerData', function(source, cb, speakeasyid)
    MySQL.query('SELECT * FROM rex_speakeasy WHERE speakeasyid = ?', {speakeasyid}, function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

---------------------------------------------
-- membership cards
---------------------------------------------
RegisterNetEvent('rex-speakeasy:server:membershipcards', function(cardname, amount, totalcost)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)

    if not Player.PlayerData.job.isboss then return end

    local job = Player.PlayerData.job.name
    exports['rsg-bossmenu']:RemoveMoney(job, totalcost)
    Player.Functions.AddItem(cardname, amount)
    TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[cardname], 'add', amount)
end)

---------------------------------------------
-- add product
---------------------------------------------
RegisterNetEvent('rex-speakeasy:server:addproduct', function(product, removeamount, totalamount, speakeasy)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)

    if product == 'corn' then
        MySQL.update('UPDATE rex_speakeasy SET corn = ? WHERE speakeasyid = ?', {totalamount, speakeasy})
        Player.Functions.RemoveItem('corn', removeamount)
        TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items['corn'], 'remove', removeamount)
    end

    if product == 'sugar' then
        MySQL.update('UPDATE rex_speakeasy SET sugar = ? WHERE speakeasyid = ?', {totalamount, speakeasy})
        Player.Functions.RemoveItem('sugar', removeamount)
        TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items['sugar'], 'remove', removeamount)
    end

    if product == 'water' then
        MySQL.update('UPDATE rex_speakeasy SET water = ? WHERE speakeasyid = ?', {totalamount, speakeasy})
        Player.Functions.RemoveItem('water', removeamount)
        TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items['water'], 'remove', removeamount)
    end

    if product == 'yeast' then
        MySQL.update('UPDATE rex_speakeasy SET yeast = ? WHERE speakeasyid = ?', {totalamount, speakeasy})
        Player.Functions.RemoveItem('yeast', removeamount)
        TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items['yeast'], 'remove', removeamount)
    end

    if product == 'jug' then
        MySQL.update('UPDATE rex_speakeasy SET jug = ? WHERE speakeasyid = ?', {totalamount, speakeasy})
        Player.Functions.RemoveItem('jug', removeamount)
        TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items['jug'], 'remove', removeamount)
    end
    
end)

---------------------------------------------
-- collect product
---------------------------------------------
RegisterNetEvent('rex-speakeasy:server:collectproduct', function(amount, speakeasyid)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('moonshine', amount)
    TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items['moonshine'], 'add', amount)
    MySQL.update('UPDATE rex_speakeasy SET moonshine = ? WHERE speakeasyid = ?', {0, speakeasyid})
end)

---------------------------------------------
-- add deliver product
---------------------------------------------
RegisterNetEvent('rex-speakeasy:server:addstockproduct', function(amount, stockupdate, speakeasyid)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem('moonshine', amount)
    TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items['moonshine'], 'remove', amount)
    MySQL.update('UPDATE rex_speakeasy SET stock = ? WHERE speakeasyid = ?', {stockupdate, speakeasyid})
end)

---------------------------------------------
-- remove stock during delivery
---------------------------------------------
RegisterNetEvent('rex-speakeasy:server:removestock', function(cargoload, speakeasy)

    -- remove stock while in delivery mode
    local result = MySQL.query.await('SELECT * FROM rex_speakeasy WHERE speakeasyid = ?', {speakeasy})
    local currentstock = result[1].stock
    local updatedstock = currentstock - cargoload
    MySQL.update('UPDATE rex_speakeasy SET stock = ? WHERE speakeasyid = ?', {updatedstock, speakeasy})

end)

---------------------------------------------
-- add stock if delivery fails
---------------------------------------------
RegisterNetEvent('rex-speakeasy:server:addstock', function(cargoload, speakeasy)

    -- add stock back in if delivery fails / timesout
    local result = MySQL.query.await('SELECT * FROM rex_speakeasy WHERE speakeasyid = ?', {speakeasy})
    local currentstock = result[1].stock
    local updatedstock = currentstock + cargoload
    MySQL.update('UPDATE rex_speakeasy SET stock = ? WHERE speakeasyid = ?', {updatedstock, speakeasy})

end)

---------------------------------------------
-- successful delivery
---------------------------------------------
RegisterNetEvent('rex-speakeasy:server:diliverysuccess', function(cargoload, distancereward, speakeasy)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local deliveryReward = cargoload * Config.CargoPerUnit
    -- speakeasy reward
    exports['rsg-bossmenu']:AddMoney(speakeasy, deliveryReward)
    -- delivering player reward
    local totaldistancereward = (distancereward * Config.DistanceReward)
    Player.Functions.AddMoney('cash', totaldistancereward)
end)

---------------------------------------------
-- storage
---------------------------------------------
RegisterServerEvent('rex-speakeasy:server:openstorage', function(title, storagename, maxweight, slots)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end
    local data = { label = title, maxweight = maxweight, slots = slots }
    local stashName = storagename
    exports['rsg-inventory']:OpenInventory(src, stashName, data)
end)

---------------------------------------------
-- moonshine production engine
---------------------------------------------
lib.cron.new(Config.ProductionCronJob, function ()

    local result = MySQL.query.await('SELECT * FROM rex_speakeasy')

    if not result then goto continue end

    for i = 1, #result do

        local speakeasyid = result[i].speakeasyid
        local corn = result[i].corn
        local sugar = result[i].sugar
        local water = result[i].water
        local yeast = result[i].yeast
        local mash = result[i].mash
        local jug = result[i].jug
        local moonshine = result[i].moonshine

        if moonshine <= Config.MaxMoonshine then

            -- create mash
            if corn >= Config.CornAmount and sugar >= Config.SugarAmount and water >= Config.WaterAmount and yeast >= Config.YeastAmount and jug >= Config.JugAmount and mash == 0 then
                MySQL.update('UPDATE rex_speakeasy SET corn = ? WHERE speakeasyid = ?', {corn-Config.CornAmount, speakeasyid})
                MySQL.update('UPDATE rex_speakeasy SET sugar = ? WHERE speakeasyid = ?', {sugar-Config.SugarAmount, speakeasyid})
                MySQL.update('UPDATE rex_speakeasy SET water = ? WHERE speakeasyid = ?', {water-Config.WaterAmount, speakeasyid})
                MySQL.update('UPDATE rex_speakeasy SET yeast = ? WHERE speakeasyid = ?', {yeast-Config.YeastAmount, speakeasyid})
                MySQL.update('UPDATE rex_speakeasy SET mash = ? WHERE speakeasyid = ?', {mash+Config.MashPerBatch, speakeasyid})
            end
            
            -- create moonshine
            if mash == Config.MashPerBatch then
                MySQL.update('UPDATE rex_speakeasy SET mash = ? WHERE speakeasyid = ?', {mash-Config.MashPerBatch, speakeasyid})
                MySQL.update('UPDATE rex_speakeasy SET jug = ? WHERE speakeasyid = ?', {jug-Config.JugAmount, speakeasyid})
                MySQL.update('UPDATE rex_speakeasy SET moonshine = ? WHERE speakeasyid = ?', {moonshine+Config.MoonshinePerBatch, speakeasyid})
            end

        end

    end

    ::continue::

    if Config.ServerNotify then
        print(locale('cl_lang_1'))
    end

end)
