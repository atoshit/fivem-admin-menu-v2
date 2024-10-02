function sendLog(webhook, color, title, message, footer)
    local embeds = {
        {
            ['title'] = title,
            ['description'] = message,
            ['color'] = color,
            ["footer"] = {
                ["text"] = footer,
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }
    }

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({embeds = embeds}), {['Content-Type'] = 'application/json'})
end