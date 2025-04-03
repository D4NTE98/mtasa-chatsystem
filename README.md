# MTA:SA Custom Chatbox 🌟

# Author: D4NTE

Advanced Object-Oriented CEF Chatbox System for Multi Theft Auto: San Andreas

## Features ✨
- **CEF-Powered UI** - Modern HTML5/CSS3 interface
- **OOP Architecture** - Clean and maintainable code structure
- **Multiple Message Types** - Normal/Admin/Error messages
- **Message History** - Last 100 messages stored
- **Custom Animations** - Smooth CSS transitions
- **Secure Input Handling** - Protected against XSS

## Example
# Client side:
```lua
-- Send message to chat
bindKey("u", "down", function()
    exports["mtasa-chatsystem"]:addMessage("Hello from client!", "normal")
end)

-- Receive messages
addEventHandler("onClientChatMessage", root,
    function(message, type)
        exports["mtasa-chatsystem"]:addMessage(message, type)
    end
)
```
# Server side:
```lua
-- Broadcast admin message
function broadcastAdminMessage(message)
    exports["mtasa-chatsystem"]:broadcastMessage(message, "admin")
end

-- Player command
addCommandHandler("say",
    function(player, cmd, ...)
        local message = table.concat({...}, " ")
        exports["mtasa-chatsystem"]:broadcastMessage(getPlayerName(player)..": "..message, "normal")
    end
)
```

## Customization 🖌️
Modify ``chat.html`` CSS to change appearance:

```css
.chat-container {
    background: rgba(40, 40, 40, 0.9);
    border: 2px solid #2ecc71;
    font-family: 'Roboto', sans-serif;
}

.admin-message {
    color: #f1c40f;
    font-weight: bold;
}
```

## Installation 💻
1. Download latest release
2. Place `mtasa-chatsystem` in your `resources/` folder
3. Add to `mtaserver.conf`:
```bash
start mtasa-chatsystem
