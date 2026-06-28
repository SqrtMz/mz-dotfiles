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