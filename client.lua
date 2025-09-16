-- Suggerimenti chat
Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/givecar', 'Dai un veicolo a un player', {
        { name = "model", help = "Nome del modello veicolo (es: adder)" },
        { name = "playerId", help = "ID del player target" }
    })

    TriggerEvent('chat:addSuggestion', '/givecarplate', 'Dai un veicolo con targa personalizzata', {
        { name = "model", help = "Nome del modello veicolo (es: sultan)" },
        { name = "plate", help = "Targa personalizzata (max 8 caratteri)" },
        { name = "playerId", help = "ID del player target" }
    })

    TriggerEvent('chat:addSuggestion', '/delcar', 'Elimina un veicolo dal database', {
        { name = "plate", help = "Targa del veicolo da eliminare (es: ABC123)" }
    })
end)
