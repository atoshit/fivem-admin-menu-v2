Io = {}

function Io.Debug(message)
    if Config.Debug then
        print("[Admin Menu] [^5DEBUG^7] " .. message)
    end
end

function Io.Error(message)
    print("[Admin Menu] [^1ERROR^7] " .. message)
end

function Io.Info(message)
    print("[Admin Menu] [^4INFO^7] " .. message)
end

function Io.Success(message)
    print("[Admin Menu] [^2SUCCESS^7] " .. message)
end

function Io.Warning(message)
    print("[Admin Menu] [^3WARNING^7] " .. message)
end