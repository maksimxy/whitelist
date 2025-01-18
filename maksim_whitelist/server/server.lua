 AddEventHandler("playerConnecting", function(name, kickReason, deferrals)
    local _src = source 
    local dcId = --Discord Idenitfier 

    deferrals.defer() 

    for k, v in pairs(GetPlayerIdentifiers(_src)) do
        if string.match(v, "discord:") then
          dcId = string.gsub(v, "discord:", "")
        end
    end
    
    if dcId ~= nil then 
      local query = MySQL.query.await('SELECT * FROM whitelist WHERE discordId = @discordId', {['@discordId'] = dcId})

      if query ~= nil and #query > 0 then 
        log('your_webhook', Config.Languages[Config.Language].join_message_success .. GetPlayerName(_src))
        print(Config.Languages[Config.Language].join_message_success .. GetPlayerName(_src))
        deferrals.done()
      else 
        log('your_webhook', Config.Languages[Config.Language].not_whitelisted .. GetPlayerName(_src))
        deferrals.done(Config.Languages[Config.Language].not_whitelisted .. GetPlayerName(_src))
      end
    else 
      deferrals.done(Config.Languages[Config.Language].open_discord)
    end
     
end)

RegisterCommand('whitelist', function(source, args)
  local _src = source 
  
  if _src == 0 then  --Source of the Server Console

    local query = MySQL.query.await('SELECT * FROM whitelist WHERE discordId = @discordId', {['@discordId'] = dcId})

    if not (query ~= nil and #query > 0) then
      local result = MySQL.insert.await('INSERT INTO `whitelist` (discordId) VALUES (?)', {
        args[1]
      })
    
      if result then
        log('your_webhook', Config.Languages[Config.Language].creation_success)
        print(Config.Languages[Config.Language].creation_success)
      else
        log('your_webhook', Config.Languages[Config.Language].creation_error)
        print(Config.Languages[Config.Language].creation_error)
      end
    else 
      print(Config.Languages[Config.Language].creation_already_exists)
    end
  end
end)
 
function log(webhook, message)
  if message == nil or message == '' then
      return false
  end

  local embeds = {{
      ["description"] = message,
      ["color"] = 16711680,  --Red
      ["footer"] = {
          ["text"] = "Logs - " .. os.date("%d.%m.%y") .. " - " .. os.date("%X") .. " Uhr"
      }
  }}

  PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({
      username = "Whitelist Log", 
      embeds = embeds
  }), {
      ['Content-Type'] = 'application/json'
  })
end
 