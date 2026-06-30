package.path = package.path .. ";./?.lua;./?/init.lua"
local smw = require("plugins.split-monitor-workspaces")

smw.setup({
	workspace_count 			    = 10,
	keep_focused 					= false,
	enable_notifications 			= false,
	enable_persistent_workspaces 	= false,
	enable_wrapping 				= true,
	link_monitors 					= false,
	enable_hy3 						= false,

	monitor_priority = { "DP-1", "DP-2" },
})

for i = 0, 9 do
	local n = tostring(i)
	hl.bind("SUPER + " .. n, smw.workspace(n))
	hl.bind("SUPER + SHIFT + " .. n, smw.move_to_workspace(n))
end

hl.bind("ALT + Tab", 			hl.dsp.focus({ workspace = "m+1" }))
hl.bind("SHIFT + ALT + Tab", 	hl.dsp.focus({ workspace = "m-1" }))

hl.bind("SUPER + mouse_up", 	hl.dsp.focus({ workspace = "m+1" }))
hl.bind("SUPER + mouse_down", 	hl.dsp.focus({ workspace = "m-1" }))

local function switch_monitor_workspaces()
	return function()
		local monitors = hl.get_monitors()
		local windows = hl.get_windows()
		local active_monitor = hl.get_active_monitor().name

		if monitors[2] then

			local ws1 = {}
			local ws2 = {}
			for _, w in ipairs(windows) do
				if w.workspace.id == monitors[1].active_workspace.id then
					hl.dispatch(hl.dsp.window.move({ window = w, workspace = monitors[2].active_workspace.id }))
				elseif  w.workspace.id == monitors[2].active_workspace.id then
					hl.dispatch(hl.dsp.window.move({ window = w, workspace = monitors[1].active_workspace.id }))
				end
			end

			hl.dispatch(hl.dsp.focus({ monitor = active_monitor }))
		else
			hl.notification.create({
				text = "No secondary monitor to swap to...",
				color = "rgba(ff0055ee)",
				timeout = 5000,
			})
		end
	end
end

hl.bind("SUPER + Z", switch_monitor_workspaces())