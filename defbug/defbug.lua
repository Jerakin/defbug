

local M = {}

M.RENDER_ORDER = 15
M.UPDATE_MEMORY_INTERVAL = 0.5

M.DETAILS = hash("defbug_details")
M.INFO = hash("defbug_info")
M.PROFILER = hash("toggle_profile")

M.url = nil

local essential_is_toggled = false
local info_is_toggled = false

M.WIDTH = 720
M.HEIGHT = 1280

local config = {}

function M.set_width_height(w, h)
	M.WIDTH = w
	M.HEIGHT = h
	if info_is_toggled then
		msg.post(msg.url(M.url.socket, "/scenes", "info"), "update_dimensions", {width=w, height=h})
	end
	if essential_is_toggled then
		msg.post(msg.url(M.url.socket, "/scenes", "details"),"update_dimensions", {width=w, height=h})
	end
end

function M.toggle_details()
	local _url = msg.url(M.url.socket, "/scenes", "details")
	if essential_is_toggled then
		msg.post(_url, "unload") 
	else
		msg.post(_url, "async_load")
	end
	essential_is_toggled = not essential_is_toggled
	return essential_is_toggled
end

function M.toggle_info()
	local _url = msg.url(M.url.socket, "/scenes", "info")
	if info_is_toggled then
		msg.post(_url, "unload") 
	else
		msg.post(_url, "async_load") 
		
	end
	info_is_toggled = not info_is_toggled
	return info_is_toggled
end

end

function M.on_input(action_id, action)
	if action_id == M.DETAILS and action.released then
		M.toggle_details()
	elseif action_id == M.INFO and action.released then
		M.toggle_info()
	elseif action_id == M.PROFILER and action.released then
		msg.post("@system:", "toggle_profile")
	end
end

return M