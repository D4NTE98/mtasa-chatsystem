ChatBox = {
    allowedMessageTypes = {"normal", "admin", "error"},
    maxMessageLength = 120
}

function ChatBox:new()
    local instance = setmetatable({}, {__index = self})
    return instance
end

function ChatBox:processMessage(player, message)
    if #message > self.maxMessageLength then
        self:sendError(player, "Too long message!")
        return false
    end
    
    if not self:validateMessage(message) then
        self:sendError(player, "Invalid message!")
        return false
    end
    
    local messageType = self:detectMessageType(message)
    self:broadcastMessage(player, message, messageType)
    return true
end

function ChatBox:validateMessage(text)
    return not text:match("[<>/\\]")
end

function ChatBox:detectMessageType(text)
    if text:sub(1, 1) == "!" then
        return "admin"
    end
    return "normal"
end

function ChatBox:broadcastMessage(player, message, mtype)
    triggerClientEvent(root, "chatbox:receiveMessage", player, message, mtype)
end

function ChatBox:sendError(player, text)
    triggerClientEvent(player, "chatbox:receiveMessage", player, text, "error")
end

addEvent("chatbox:messageFromClient", true)
addEventHandler("chatbox:messageFromClient", root,
    function(message)
        local handler = ChatBox:new()
        handler:processMessage(client, message)
    end
)