function loadUser (source, setKickReason, deferrals, identifier, license)
    local result = MySQL.single.await('SELECT * FROM users WHERE identifier = ?', {identifier})

    if result then
        if result.banned == true then
            local banUntil = result.banneduntil
            local currentTime = tonumber(os.time(os.date("!*t")))

            if banUntil == 0 then -- PERMA BANNED
                deferrals.done("You are permanently banned :(")
                setKickReason("You are permanently banned :(")
                return
            elseif banUntil > currentTime then -- STILL BANNED
                local bannedUntil = os.date("%d/%m/%y %H:%M:%S", bannedUntilTime + 10 * 3600)
                deferrals.done("You are banned until: ".. bannedUntil .. " AEST")
                setKickReason("You are banned until: ".. bannedUntil .. " AEST")
                return
            else -- NOT BANNED ANYMORE
                MySQL.update.await('UPDATE users SET banned = ? WHERE identifier = ?', {0, identifier})
            end
        end

        deferrals.done()
        return result
    else
        local plyTbl = {identifier, "user", 0, 0, 0, 5}
        MySQL.insert.await("INSERT INTO users VALUES(?,?,?,?,?,?)", plyTbl)

        result = MySQL.single.await('SELECT * FROM users WHERE identifier = ?', {identifier})
        print(json.encode(result, { indent = true, sort_keys = true }))
        deferrals.done()
        return result
    end
end