local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_arevive")

RegisterCommand('arevive', function(source, args, msg)
  local user_id = vRP.getUserId({source})
  msg = msg:sub(9)
  if msg:len() >= 1 then
    msg = tonumber(msg)
    local target = vRP.getUserSource({msg})
    if target ~= nil then
      if vRP.hasPermission({user_id, "player.tpto"}) then -- moderator sau mai mare.
        vRPclient.varyHealth(target,{100})

        TriggerClientEvent('chatMessage', source, "^1ARevive^7: I-ai dat revive lui "..GetPlayerName(target)..".")
        TriggerClientEvent('chatMessage', target, "^1ARevive^7: Adminul "..GetPlayerName(source).." ti-a dat revive.")
      else
        TriggerClientEvent('chatMessage', source, "^1Eroare^7: Nu ai acces la aceasta comanda.")
      end
    else
      TriggerClientEvent('chatMessage', source, "^1Eroare^7: Player-ul nu este conectat.")
    end
  else
    TriggerClientEvent('chatMessage', source, "^1Syntax^7: /arevive <user-id>")
  end
end)
