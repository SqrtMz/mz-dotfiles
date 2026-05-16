hl.config({
	plugin = {
		split_monitor_workspaces = {
			count = 10;
			keep_focused = 0;
			enable_notifications = 0;
			enable_persistent_workspaces = 0;
			enable_wrapping = 1;
			monitor_priority = {"DP-1", "DP-2"};
			link_monitors = 0;
		},
	},
})

local smw = hl.plugin.split_monitor_workspaces

smw.max_workspaces({monitor = "DP-1", max = 10})
smw.max_workspaces({monitor = "DP-2", max = 10})

for i = 0, 9 do
    local key = tostring(i)
    hl.bind("SUPER + " .. key, function() return smw.workspace(i) end)
    hl.bind("SUPER + SHIFT + " .. key, function() return smw.move_to_workspace_silent(i) end)
end