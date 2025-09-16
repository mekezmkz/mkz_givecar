# MKZ GiveCar - FiveM Vehicle Management Script

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![FiveM](https://img.shields.io/badge/FiveM-Compatible-blue.svg)](https://fivem.net/)
[![QBCore](https://img.shields.io/badge/QBCore-Compatible-green.svg)](https://github.com/qbcore-framework)

A comprehensive vehicle management script for FiveM servers using QBCore/QBox framework. This script allows administrators to give and remove vehicles from players with advanced permission management.

## 🌍 Languages / Lingue
- [🇺🇸 English](#english)
- [🇮🇹 Italiano](#italiano)

---

## English

### 📋 Features

- **Give Vehicle**: Spawn vehicles directly to player's garage
- **Give Vehicle with Custom Plate**: Spawn vehicles with custom license plates
- **Delete Vehicle**: Remove vehicles from database by license plate
- **Dual Permission System**: Supports both FiveM ACE permissions and QBCore groups
- **Player Notifications**: Real-time notifications for both admin and target player
- **Chat Suggestions**: Auto-complete suggestions for all commands
- **Error Handling**: Comprehensive error checking and user feedback

### 🛠️ Commands

| Command | Description | Usage | Permission |
|---------|-------------|-------|------------|
| `/givecar` | Give a vehicle to a player | `/givecar [model] [playerId]` | Admin |
| `/givecarplate` | Give a vehicle with custom plate | `/givecarplate [model] [plate] [playerId]` | Admin |
| `/delcar` | Delete a vehicle by plate | `/delcar [plate]` | Admin |

### 📦 Installation

1. **Download** the script and place it in your `resources/[ext]/` folder
2. **Add** the following line to your `server.cfg`:
   ```
   ensure mkzgivecar
   ```
3. **Configure permissions** in your `server.cfg`:
   ```
   # For FiveM ACE permissions
   add_principal identifier.fivem:YOUR_ID group.admin
   
   # Or use QBCore database groups (admin/god)
   ```

### ⚙️ Configuration

#### Permission System
The script supports two permission systems:

**FiveM ACE Permissions:**
```
add_principal identifier.fivem:15054597 group.admin
```

**QBCore/QBox Groups:**
- Database groups: `admin`, `god`

#### Dependencies
- **QBCore/QBox Framework**
- **oxmysql** (MySQL handling)
- **okokNotify** (Notifications)

### 🔧 Database Structure
The script uses the standard QBCore `player_vehicles` table:
```sql
CREATE TABLE IF NOT EXISTS `player_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `vehicle` varchar(50) DEFAULT NULL,
  `hash` varchar(50) DEFAULT NULL,
  `mods` longtext DEFAULT NULL,
  `plate` varchar(50) NOT NULL,
  `garage` varchar(50) DEFAULT 'pillboxgarage',
  `state` int(11) DEFAULT 1,
  PRIMARY KEY (`id`)
);
```

### 📝 Examples

```bash
# Give an Adder to player ID 1
/givecar adder 1

# Give a Sultan with custom plate to player ID 2
/givecarplate sultan MEKEZ99 2

# Delete vehicle with plate ABC123
/delcar ABC123
```

### 🐛 Troubleshooting

**Permission Issues:**
- Ensure your identifier is correctly added to `server.cfg`
- Check if you have the correct group in QBCore database
- Restart the resource after permission changes

**Database Issues:**
- Verify oxmysql is running
- Check database connection
- Ensure `player_vehicles` table exists

### 📄 License
This project is licensed under the MIT License.

### 👨‍💻 Author
**Mekez** - *Initial work*

---

## Italiano

### 📋 Caratteristiche

- **Dare Veicolo**: Spawna veicoli direttamente nel garage del giocatore
- **Dare Veicolo con Targa Personalizzata**: Spawna veicoli con targhe personalizzate
- **Eliminare Veicolo**: Rimuove veicoli dal database tramite targa
- **Sistema Doppio Permessi**: Supporta sia i permessi ACE di FiveM che i gruppi QBCore
- **Notifiche Giocatori**: Notifiche in tempo reale per admin e giocatore target
- **Suggerimenti Chat**: Suggerimenti auto-completamento per tutti i comandi
- **Gestione Errori**: Controllo errori completo e feedback utente

### 🛠️ Comandi

| Comando | Descrizione | Utilizzo | Permesso |
|---------|-------------|----------|----------|
| `/givecar` | Dai un veicolo a un giocatore | `/givecar [modello] [playerId]` | Admin |
| `/givecarplate` | Dai un veicolo con targa personalizzata | `/givecarplate [modello] [targa] [playerId]` | Admin |
| `/delcar` | Elimina un veicolo tramite targa | `/delcar [targa]` | Admin |

### 📦 Installazione

1. **Scarica** lo script e posizionalo nella cartella `resources/[ext]/`
2. **Aggiungi** la seguente riga al tuo `server.cfg`:
   ```
   ensure mkzgivecar
   ```
3. **Configura i permessi** nel tuo `server.cfg`:
   ```
   # Per i permessi ACE di FiveM
   add_principal identifier.fivem:TUO_ID group.admin
   
   # Oppure usa i gruppi database QBCore (admin/god)
   ```

### ⚙️ Configurazione

#### Sistema Permessi
Lo script supporta due sistemi di permessi:

**Permessi ACE FiveM:**
```
add_principal identifier.fivem:15054597 group.admin
```

**Gruppi QBCore/QBox:**
- Gruppi database: `admin`, `god`

#### Dipendenze
- **Framework QBCore/QBox**
- **oxmysql** (Gestione MySQL)
- **okokNotify** (Notifiche)

### 🔧 Struttura Database
Lo script utilizza la tabella standard QBCore `player_vehicles`:
```sql
CREATE TABLE IF NOT EXISTS `player_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `vehicle` varchar(50) DEFAULT NULL,
  `hash` varchar(50) DEFAULT NULL,
  `mods` longtext DEFAULT NULL,
  `plate` varchar(50) NOT NULL,
  `garage` varchar(50) DEFAULT 'pillboxgarage',
  `state` int(11) DEFAULT 1,
  PRIMARY KEY (`id`)
);
```

### 📝 Esempi

```bash
# Dai un Adder al giocatore ID 1
/givecar adder 1

# Dai una Sultan con targa personalizzata al giocatore ID 2
/givecarplate sultan MEKEZ99 2

# Elimina veicolo con targa ABC123
/delcar ABC123
```

### 🐛 Risoluzione Problemi

**Problemi Permessi:**
- Assicurati che il tuo identifier sia correttamente aggiunto al `server.cfg`
- Controlla di avere il gruppo corretto nel database QBCore
- Riavvia il resource dopo le modifiche ai permessi

**Problemi Database:**
- Verifica che oxmysql sia in esecuzione
- Controlla la connessione al database
- Assicurati che la tabella `player_vehicles` esista

### 📄 Licenza
Questo progetto è concesso in licenza sotto la Licenza MIT.

### 👨‍💻 Autore
**Mekez** - *Lavoro iniziale*

---

## 🤝 Contributing / Contribuire

Contributions are welcome! Please feel free to submit a Pull Request.

I contributi sono benvenuti! Sentiti libero di inviare una Pull Request.

## 📞 Support / Supporto

If you need help or have questions, please open an issue on GitHub.

Se hai bisogno di aiuto o hai domande, apri un issue su GitHub.