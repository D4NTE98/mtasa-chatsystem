ChatBox = {}
ChatBox.__index = ChatBox

function ChatBox:create()
    local instance = setmetatable({}, self)
    instance.browser = nil
    instance.visible = false
    instance.messageHistory = {}
    instance:initBrowser()
    return instance
end

function ChatBox:initBrowser()
    self.browser = createBrowser(400, 250, true, true)
    addEventHandler("onClientBrowserCreated", self.browser, function()
        loadBrowserURL(source, "http://mta/mtasa-chatsystem/assets/ui.html")
    end)

    bindKey("t", "down", function() 
        self:toggleVisibility(true) 
        guiSetInputEnabled(true)
    end)
    
    bindKey("enter", "down", function()
        if self.visible then
            self:toggleVisibility(false)
            guiSetInputEnabled(false)
        end
    end)
end

function ChatBox:toggleVisibility(state)
    self.visible = state or not self.visible
    executeJavaScript(self.browser, "document.querySelector('.chat-container').style.opacity = '{self.visible and 1 or 0}'")
    showCursor(self.visible)
    focusBrowser(self.browser, self.visible)
end

function ChatBox:addMessage(text, messageType)
    table.insert(self.messageHistory, {text = text, type = messageType})
    if #self.messageHistory > 100 then
        table.remove(self.messageHistory, 1)
    end
    
    executeJavaScript(self.browser, 
        "addMessage({toJSON(text)}, {toJSON(messageType or 'normal')})"
    )
end

addEvent("chatbox:receiveMessage", true)
addEventHandler("chatbox:receiveMessage", localPlayer,
    function(message, mtype)
        ChatBox:getInstance():addMessage(message, mtype)
    end
)

function ChatBox:getInstance()
    if not ChatBox.instance then
        ChatBox.instance = ChatBox:create()
    end
    return ChatBox.instance
end