local Kirmizibolge = {
    { -- ÖRNEK SENERYO
        x = 2349.61, -- X konumu
        y = 2557.08, -- Y Konumu
        z = 46.67, -- Z Konumu
        radius = 92.0,  -- Yarı Çapı
        visibleDistance = 300.0,
        color = {r = 255, g = 0, b = 0, a = 75} -- Renk kodları
    },


}

local isInRedZone = {}

for i = 1, #Kirmizibolge do
    isInRedZone[i] = false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for i, redZone in ipairs(Kirmizibolge) do
            local distance = #(vector3(redZone.x, redZone.y, redZone.z) - playerCoords)

            if distance < redZone.visibleDistance then
                DrawMarker(28, redZone.x, redZone.y, redZone.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, redZone.radius, redZone.radius, redZone.radius, redZone.color.r, redZone.color.g, redZone.color.b, redZone.color.a, false, false, 2, false, nil, nil, false)
            end
        end
    end
end)

Citizen.CreateThread(function()
    for _, redZone in ipairs(Kirmizibolge) do
        local blip = AddBlipForRadius(redZone.x, redZone.y, redZone.z, redZone.radius)
        SetBlipColour(blip, 1) -- Blip renk kodu
        SetBlipAlpha(blip, 128) -- Blip saydamlık
    end
end)