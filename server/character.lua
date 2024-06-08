function getCharacters(identifier)
    return MySQL.query.await('SELECT * FROM characters WHERE identifier = ?', {identifier})
end

function getCharactersFromID(id)
    local steamID = GetSteamID(id)
    return MySQL.query.await('SELECT * FROM characters WHERE identifier = ?', {steamID})
end