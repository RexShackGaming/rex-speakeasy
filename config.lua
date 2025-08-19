Config = {}

Config.Debug = true

---------------------------------
-- law settings
---------------------------------
Config.LawmanOnDuty = 1 -- how many law need to be on duty for deliveries
Config.CallLawChance = 80 -- % chance of calling the law

---------------------------------
-- settings
---------------------------------
Config.DistanceSpawn = 20.0 -- distance for npc to spawn
Config.FadeIn = true -- npc will fade-in if true
Config.KeyBind = 'J' -- keybind
Config.CardCreationCost = 1 -- how much it costs to produce a membership card
Config.MakeTime = 10000 -- how long it takes to prodcue a membership card
Config.ProductionCronJob = '*/10 * * * *' -- cronjob every ten mins
Config.ServerNotify = false -- toggle server notifcations on/off

---------------------------------
-- brewer settings
---------------------------------
Config.CollectTime = 1000 -- when collecting how long per item

---------------------------------
-- brewer max settings
---------------------------------
Config.MaxCorn = 100 -- max corn for production
Config.MaxSugar = 100 -- max sugar for production
Config.MaxWater = 100 -- max water for production
Config.MaxYeast = 100 -- max yeast for production
Config.MaxJug = 100 -- max jugs for production
Config.MaxMoonshine = 100 -- max moonshine for production

---------------------------------
-- brewer process amounts
---------------------------------
Config.CornAmount = 10 -- amount of corn per mash batch
Config.SugarAmount = 10 -- amount of sugar per mash batch
Config.WaterAmount = 10 -- amount of water per mash batch
Config.YeastAmount = 1 -- amount of yeast per mash batch
Config.JugAmount = 10 -- amount of jugs per mash batch
Config.MashPerBatch = 1 -- amount of mash produced per batch run
Config.MoonshinePerBatch = 10 -- amount moonshine produced per mash batch

---------------------------------
-- delivery amounts
---------------------------------
Config.LemoyneMinDelivery   = 25
Config.CattailMinDelivery   = 25
Config.NewAustinMinDelivery = 25
Config.HanoverMinDelivery   = 25
Config.ManzanitaMinDelivery = 25

---------------------------------
-- storage (goods in/out)
---------------------------------
Config.GoodsInMaxWeight = 4000000
Config.GoodsInMaxSlots = 48
Config.GoodsOutMaxWeight = 4000000
Config.GoodsOutMaxSlots = 48

---------------------------------
-- distribution
---------------------------------
Config.CargoPerUnit = 3 -- $ amount per moonshine unit
Config.DistanceReward = 1 -- $ multiplier for player distance reward ( 1 = noraml 2 = double and so on)

---------------------------------
-- speakeasy teleports
---------------------------------
Config.SpeakeasyData = {

    -- Lemoyne Speakeasy (in/out)
    { 
        name = 'Enter Lemoyne Speakeasy', -- prompt name
        item = 'lemoynemember', -- membership card to get access
        prompt = 'lemoyne-speakeasy-in', -- must be unique 
        coords = vector3(1784.90, -821.65, 42.86), -- location of the prompt
        destination = vector4(1785.01,-821.53,191.01, 314.72), -- teleport destination
        showblip = true, -- true/false to toggle blip
        blipsprite = 'blip_business_moonshine', -- blip sprite
        blipscale = 0.2, -- blip scale
        blipname = 'Lemoyne Speakeasy', -- blip name
        jobaccess = 'lemoynese' -- job required for access
    },
    { 
        name = 'Leave Lemoyne Speakeasy',
        item = 'lemoynemember',
        prompt = 'lemoyne-speakeasy-out',
        coords = vector3(1785.03, -821.38, 192.60),
        destination = vector4(1784.65, -821.87, 42.86, 134.88),
        showblip = true,
        blipsprite = 'blip_business_moonshine',
        blipscale = 0.2,
        blipname = 'Lemoyne Speakeasy',
        jobaccess = 'lemoynese'
    },
    
    -- Cattail Pond Speakeasy
    { 
        name = 'Enter Cattail Pond Speakeasy',
        item = 'cattailmember',
        prompt = 'cattail-speakeasy-in',
        coords = vector3(-1085.63, 714.14, 103.32),
        destination = vector4(-1085.63, 714.14, 84.23, 104.45),
        showblip = true,
        blipsprite = 'blip_business_moonshine',
        blipscale = 0.2,
        blipname = 'Cattail Pond Speakeasy',
        jobaccess = 'cattailse'
    },
    {
        name = 'Leave Cattail Pond Speakeasy',
        item = 'cattailmember',
        prompt = 'cattail-speakeasy-out',
        coords = vector3(-1085.63, 714.14, 84.23),
        destination = vector4(-1085.63, 714.14, 104.32, 303.27),
        showblip = true,
        blipsprite = 'blip_business_moonshine',
        blipscale = 0.2,
        blipname = 'Cattail Pond Speakeasy',
        jobaccess = 'cattailse'
    },

    -- New Austin Speakeasy
    { 
        name = 'Enter New Austin Speakeasy',
        item = 'newaustinmember',
        prompt = 'newaustin-speakeasy-in',
        coords = vector3(-2769.23, -3048.90, 11.38),
        destination = vector4(-2769.34, -3048.75, -8.70, 60.58),
        showblip = true,
        blipsprite = 'blip_business_moonshine',
        blipscale = 0.2,
        blipname = 'New Austin Speakeasy',
        jobaccess = 'newaustinse'
    },
    {
        name = 'Leave New Austin Speakeasy',
        item = 'newaustinmember',
        prompt = 'newaustin-speakeasy-out',
        coords = vector3(-2769.3, -3048.87, -9.7),
        destination = vector4(-2769.35, -3049.00, 11.38, 243.99),
        showblip = true,
        blipsprite = 'blip_business_moonshine',
        blipscale = 0.2,
        blipname = 'New Austin Speakeasy',
        jobaccess = 'newaustinse'
    },
    
    -- Hanover Speakeasy
    { 
        name = 'Enter Hanover Speakeasy',
        item = 'hanovermember',
        prompt = 'hanover-speakeasy-in',
        coords = vector3(1627.64, 822.9, 144.03),
        destination = vector4(1627.64, 822.9, 123.94, 0.0),
        showblip = true,
        blipsprite = 'blip_business_moonshine',
        blipscale = 0.2,
        blipname = 'Hanover Speakeasy',
        jobaccess = 'hanoverse'
    },
    {
        name = 'Leave Hanover Speakeasy',
        item = 'hanovermember',
        prompt = 'hanover-speakeasy-out',
        coords = vector3(1627.64, 822.9, 123.94),
        destination = vector4(1627.64, 822.9, 144.03, 151.71),
        showblip = true,
        blipsprite = 'blip_business_moonshine',
        blipscale = 0.2,
        blipname = 'Hanover Speakeasy',
        jobaccess = 'hanoverse'
    },

    -- Manzanita Post
    { 
        name = 'Enter Manzanita Post Speakeasy',
        item = 'manzanitamember',
        prompt = 'manzanita-speakeasy-in',
        coords = vector3(-1861.7, -1722.17, 108.35),
        destination = vector4(-1861.70, -1722.17, 89.25, 152.63),
        showblip = true,
        blipsprite = 'blip_business_moonshine',
        blipscale = 0.2,
        blipname = 'Manzanita Post Speakeasy',
        jobaccess = 'manzanitase'
    },
    {
        name = 'Leave Manzanita Post Speakeasy',
        item = 'manzanitamember',
        prompt = 'manzanita-speakeasy-out',
        coords = vector3(-1861.7, -1722.17, 88.35),
        destination = vector4(-1861.7, -1722.17, 108.35, 0.0),
        showblip = true,
        blipsprite = 'blip_business_moonshine',
        blipscale = 0.2,
        blipname = 'Manzanita Post Speakeasy',
        jobaccess = 'manzanitase'
    },
    
}

---------------------------------
-- speakeasy npcs
---------------------------------
Config.SpeakeasyNPCs = {

    -----------------------
    -- Lemoyne Speakeasy NPCs
    -----------------------
    {
        name = 'Speakeasy Management',
        npcmodel = `mp_outlaw1_males_01`,
        npccoords = vector4(1792.48, -814.39, 192.60, 133.30),
        speakeasyid = 'lemoynese',
        menutype = 'manager'
    },
    {
        name = 'Master Brewer',
        npcmodel = `mp_a_m_m_moonshinemakers_01`,
        npccoords = vector4(1794.66, -817.96, 189.40, 95.99),
        speakeasyid = 'lemoynese',
        menutype = 'brewer'
    },
    {
        name = 'Distribution Agent',
        npcmodel = `mp_a_m_m_moonshinemakers_01`,
        npccoords = vector4(1790.61, -818.72, 189.40, 30.21),
        speakeasyid = 'lemoynese',
        menutype = 'distribution'
    },
    {
        name = 'Delivery Agent',
        npcmodel = `mp_a_m_m_moonshinemakers_01`,
        npccoords = vector4(1786.38, -825.44, 42.80, 147.29),
        speakeasyid = 'lemoynese',
        menutype = 'delivery'
    },

    -----------------------
    -- Cattailse Pond Speakeasy NPCs
    -----------------------
    {
        name = 'Speakeasy Management',
        npcmodel = `mp_outlaw1_males_01`,
        npccoords = vector4(-1094.73, 710.22, 84.23, 300.89),
        speakeasyid = 'cattailse',
        menutype = 'manager'
    },
    {
        name = 'Master Brewer',
        npcmodel = `mp_a_m_m_moonshinemakers_01`,
        npccoords = vector4(-1095.54, 714.19, 81.04, 240.17),
        speakeasyid = 'cattailse',
        menutype = 'brewer'
    },
    {
        name = 'Distribution Agent',
        npcmodel = `mp_a_m_m_moonshinemakers_01`,
        npccoords = vector4(-1091.56, 713.57, 81.04, 185.68),
        speakeasyid = 'cattailse',
        menutype = 'distribution'
    },
    {
        name = 'Delivery Agent',
        npcmodel = `mp_a_m_m_moonshinemakers_01`,
        npccoords = vector4(-1083.28, 709.58, 104.20, 211.12),
        speakeasyid = 'cattailse',
        menutype = 'delivery'
    },

    -----------------------
    -- New Austin Speakeasy NPCs
    -----------------------
    {
        name = 'Speakeasy Management',
        npcmodel = `mp_outlaw1_males_01`,
        npccoords = vector4(-2777.85, -3044.20, -8.70, 244.63),
        speakeasyid = 'newaustinse',
        menutype = 'manager'
    },
    {   
        name = 'Master Brewer',
        npcmodel = `mp_a_m_m_moonshinemakers_01`,
        npccoords = vector4(-2775.51, -3040.88, -11.90, 190.72),
        speakeasyid = 'newaustinse',
        menutype = 'brewer'
    },
    {
        name = 'Distribution Agent',
        npcmodel = `mp_a_m_m_moonshinemakers_01`,
        npccoords = vector4(-2773.80, -3044.44, -11.90, 140.85),
        speakeasyid = 'newaustinse',
        menutype = 'distribution'
    },
    {
        name = 'Delivery Agent',
        npcmodel = `mp_a_m_m_moonshinemakers_01`,
        npccoords = vector4(-2767.49, -3045.85, 11.28, 241.52),
        speakeasyid = 'newaustinse',
        menutype = 'delivery'
    },

    -----------------------
    -- Hanover Speakeasy NPCs
    -----------------------
    {
        name = 'Speakeasy Management',
        npcmodel = `mp_outlaw1_males_01`,
        npccoords = vector4(1631.62, 832.22, 124.94, 162.12),
        speakeasyid = 'hanoverse',
        menutype = 'manager'
    },
    {   
        name = 'Master Brewer',
        npcmodel = `mp_a_m_m_moonshinemakers_01`,
        npccoords = vector4(1635.06, 829.67, 121.74, 94.06),
        speakeasyid = 'hanoverse',
        menutype = 'brewer'
    },
    {
        name = 'Distribution Agent',
        npcmodel = `mp_a_m_m_moonshinemakers_01`,
        npccoords = vector4(1631.54, 827.33, 121.74, 58.57),
        speakeasyid = 'hanoverse',
        menutype = 'distribution'
    },
    {
        name = 'Delivery Agent',
        npcmodel = `mp_a_m_m_moonshinemakers_01`,
        npccoords = vector4(1630.19, 820.30, 144.78, 154.96),
        speakeasyid = 'hanoverse',
        menutype = 'delivery'
    },

    -----------------------
    -- Manzanita Post Speakeasy NPCs
    -----------------------
    {   -- Manzanita Post Speakeasy
        name = 'Speakeasy Management',
        npcmodel = `mp_outlaw1_males_01`,
        npccoords = vector4(-1866.81, -1731.36, 89.25, 332.88),
        speakeasyid = 'manzanitase',
        menutype = 'manager'
    },
    {
        name = 'Master Brewer',
        npcmodel = `mp_a_m_m_moonshinemakers_01`,
        npccoords = vector4(-1869.98, -1728.49, 86.06, 284.52),
        speakeasyid = 'manzanitase',
        menutype = 'brewer'
    },
    {
        name = 'Distribution Agent',
        npcmodel = `mp_a_m_m_moonshinemakers_01`,
        npccoords = vector4(-1866.23, -1726.47, 86.06, 229.14),
        speakeasyid = 'manzanitase',
        menutype = 'distribution'
    },
    {
        name = 'Delivery Agent',
        npcmodel = `mp_a_m_m_moonshinemakers_01`,
        npccoords = vector4(-1858.77, -1722.22, 109.24, 331.18),
        speakeasyid = 'manzanitase',
        menutype = 'delivery'
    },

}

---------------------------------
-- lemoyne speakeasy deliveries
---------------------------------
Config.LemoyneDeliveryLocations = {

    -- Lemoyne Speakeasy -> Saint Dennis
    {   
        name         = 'Saint Dennis Delivery',
        description  = 'delivery of moonshine to xxx',
        deliveryid   = 'lemoyne1',
        speakeasy    = 'lemoynese',
        cartspawn    = vector4(1778.77, -832.91, 41.99, 126.71),
        cart         = 'wagon05x',
        cargo        = 'pg_mission_moonshineSupplies',
        light        = 'pg_teamster_wagon05x_lightupgrade3',
        cargoload    = 25,
        startcoords  = vector3(1778.77, -832.91, 41.99),
        endcoords    = vector3(2810.99, -1179.36, 47.39),
        deliverytime = 10, -- in mins
        showgps      = true,
        showblip     = true
    },

}

---------------------------------
-- cattail pond speakeasy deliveries
---------------------------------
Config.CattailDeliveryLocations = {

    -- Cattail Pond -> Valentine
    {   
        name         = 'Valentine Delivery',
        description  = 'delivery of moonshine to xxx',
        deliveryid   = 'cattail1',
        speakeasy    = 'cattailse',
        cartspawn    = vector4(-1079.41, 706.14, 104.03, 200.66),
        cart         = 'wagon05x',
        cargo        = 'pg_mission_moonshineSupplies',
        light        = 'pg_teamster_wagon05x_lightupgrade3',
        cargoload    = 25,
        startcoords  = vector3(-1079.41, 706.14, 104.03),
        endcoords    = vector3(-310.90, 825.35, 119.32),
        deliverytime = 10, -- in mins
        showgps      = true,
        showblip     = true
    },

}

---------------------------------
-- new austin speakeasy deliveries
---------------------------------
Config.NewAustinDeliveryLocations = {

    -- New Austin -> Tumbleweed
    {   
        name         = 'Tumbleweed Delivery',
        description  = 'delivery of moonshine to xxx',
        deliveryid   = 'newaustin1',
        speakeasy    = 'newaustinse',
        cartspawn    = vector4(-2761.91, -3048.15, 10.46, 160.03),
        cart         = 'wagon05x',
        cargo        = 'pg_mission_moonshineSupplies',
        light        = 'pg_teamster_wagon05x_lightupgrade3',
        cargoload    = 25,
        startcoords  = vector3(-2761.91, -3048.15, 10.46),
        endcoords    = vector3(-5526.14, -2913.95, -2.43),
        deliverytime = 10, -- in mins
        showgps      = true,
        showblip     = true
    },

}

---------------------------------
-- hanover speakeasy deliveries
---------------------------------
Config.HanoverDeliveryLocations = {

    -- Hanover -> Van-Horn
    {   
        name         = 'Van-Horn Delivery',
        description  = 'delivery of moonshine to xxx',
        deliveryid   = 'hanover1',
        speakeasy    = 'hanoverse',
        cartspawn    = vector4(1629.18, 812.71, 143.92, 124.13),
        cart         = 'wagon05x',
        cargo        = 'pg_mission_moonshineSupplies',
        light        = 'pg_teamster_wagon05x_lightupgrade3',
        cargoload    = 25,
        startcoords  = vector3(1629.18, 812.71, 143.92),
        endcoords    = vector3(2958.31, 522.35, 44.69),
        deliverytime = 10, -- in mins
        showgps      = true,
        showblip     = true
    },

}

---------------------------------
-- manzanita post speakeasy deliveries
---------------------------------
Config.ManzanitaPostDeliveryLocations = {

    -- Manzanita Post -> Blackwater
    {   
        name         = 'Blackwater Delivery',
        description  = 'delivery of moonshine to xxx',
        deliveryid   = 'manzanita1',
        speakeasy    = 'manzanitase',
        cartspawn    = vector4(-1858.51, -1713.61, 107.68, 341.49),
        cart         = 'wagon05x',
        cargo        = 'pg_mission_moonshineSupplies',
        light        = 'pg_teamster_wagon05x_lightupgrade3',
        cargoload    = 25,
        startcoords  = vector3(-1858.51, -1713.61, 107.68),
        endcoords    = vector3(-799.88, -1344.07, 43.62),
        deliverytime = 10, -- in mins
        showgps      = true,
        showblip     = true
    },

}
