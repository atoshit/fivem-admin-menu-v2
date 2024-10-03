local webhookQueue = {}
local isProcessingWebhooks = false

function queueWebhook(webhook, color, title, message, footer)
    table.insert(webhookQueue, {webhook = webhook, color = color, title = title, message = message, footer = footer})
    if not isProcessingWebhooks then
        processWebhookQueue()
    end
end

function processWebhookQueue()
    isProcessingWebhooks = true
    Citizen.CreateThread(function()
        while #webhookQueue > 0 do
            local webhookData = table.remove(webhookQueue, 1)
            sendLog(webhookData.webhook, webhookData.color, webhookData.title, webhookData.message, webhookData.footer)
            Citizen.Wait(1000)
        end
        isProcessingWebhooks = false
    end)
end

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