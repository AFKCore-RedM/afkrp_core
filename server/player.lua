function CreatePlayer(playerID)
    local self = {}

    self.source = playerID
    self.coords = coords or vector3(0, 0, 0)
    self.characters = getCharactersFromID(playerID)

    function self.setCoords(coordinates)
        local ped = GetPlayerPed(self.source)
        local vector = type(coordinates) == "vector4" and coordinates or type(coordinates) == "vector3" and vector4(coordinates, 0.0) or vec(coordinates.x, coordinates.y, coordinates.z, coordinates.heading or 0.0)
        SetEntityCoords(ped, vector.xyz, false, false, false, false)
        SetEntityHeading(ped, vector.w)
    end

    return self
end