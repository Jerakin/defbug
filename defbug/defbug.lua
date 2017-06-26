

local M = {}

M.RENDER_ORDER = 15
M.UPDATE_MEMORY_INTERVAL = 0.5

M.messages = {}
M.messages.TOGGLE_ESSENTIALS = hash("toggle_essentials")
M.messages.TOGGLE_INFO = hash("toggle_info")

M.info_url = nil
M.essentials_url = nil

function M.toggle_info()
	msg.post(info_url, "async_load")
end

return M