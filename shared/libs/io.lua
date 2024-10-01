Io = {}

function Io.Debug(message)
    if Config.Debug then
        print("[Admin Menu] [~p~DEBUG~s~] " .. message)
    end
end

function Io.Error(message)
    print("[Admin Menu] [~r~ERROR~s~] " .. message)
end

function Io.Info(message)
    print("[Admin Menu] [~b~INFO~s~] " .. message)
end

function Io.Success(message)
    print("[Admin Menu] [~g~SUCCESS~s~] " .. message)
end

function Io.Warning(message)
    print("[Admin Menu] [~y~WARNING~s~] " .. message)
end