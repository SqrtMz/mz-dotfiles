--    ____         __  __  ___  
--   / __/__  ____/ /_/  |/  /__
--  _\ \/ _ \/ __/ __/ /|_/ /_ /
-- /___/\_, /_/  \__/_/  /_//__/
--       /_/

local file_manager = "dolphin"
local menu = "rofi -show drun"
local terminal = "kitty"

require("monitors")

hl.on("hyprland.start",
	function()
		hl.exec_cmd("~/mz-dotfiles/scripts/autorun.sh")
	end
)

hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("MANGOHUD", "1")
hl.env("ROCM_PATH", "/opt/rocm")
hl.env("HSA_OVERRIDE_GFX_VERSION", "10.3.0")

hl.config({
	general = {
		gaps_in = 5;
		gaps_out = 5;
		border_size = 2;

		col = {
			active_border = {
				colors = {
					"rgba(33ccffee)", "rgba(00ff99ee)"
				},

				angle = 45,
			},

			inactive_border = "rgba(595959aa)",
		},
		
		resize_on_border = false;
		allow_tearing = false;
		layout = "dwindle";
	},

	decoration = {
		rounding = 10;
		active_opacity = 1.0;
		inactive_opacity = 1.0;

		shadow = {
			enabled = true;
			range = 4;
			render_power = 3;
			color = "rgba(1a1a1aee)";
		};
	
		blur = {
			enabled = true;
			size = 3;
			passes = 1;
			vibrancy = 0.1696;
		};
	},

	animations = {
		enabled = true;
	},

	input = {
		kb_layout = "us";
		kb_variant = "altgr-intl";

		follow_mouse = 1;
		sensitivity = 0;
		accel_profile = "flat";

		touchpad = {
			natural_scroll = false;
		};
	},

	cursor = {
		no_hardware_cursors = true;
	},
})

hl.curve("pan", {type = "bezier", points = {{0.05, 0.9}, {0.1, 1.05}}})

hl.animation({leaf = "windows", 	enabled = true, speed = 7, 	bezier = "pan"})
hl.animation({leaf = "windowsOut", 	enabled = true, speed = 7, 	bezier = "pan", style = "popin 80%"})
hl.animation({leaf = "border", 		enabled = true, speed = 10, bezier = "pan"})
hl.animation({leaf = "borderangle", enabled = true, speed = 8, 	bezier = "pan"})
hl.animation({leaf = "fade", 		enabled = true, speed = 7, 	bezier = "pan"})
hl.animation({leaf = "workspaces", 	enabled = true, speed = 6, 	bezier = "pan"})

local run = hl.dsp.exec_cmd

hl.bind("SUPER + Q", 			run(terminal))
hl.bind("SUPER + Escape", 		hl.dsp.window.close())
hl.bind("SUPER + M", 			run("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind("SUPER + E", 			run(file_manager))
hl.bind("SUPER + W", 			run(menu))
hl.bind("SUPER + P", 			hl.dsp.window.pseudo())
hl.bind("SUPER + J", 			hl.dsp.layout("togglesplit"))
hl.bind("SUPER + F", 			hl.dsp.window.fullscreen({action = "toggle"}))
hl.bind("SUPER + SHIFT + F", 	hl.dsp.window.float({action = "toggle"}))

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind("SUPER + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind("SUPER + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

hl.bind("Print", 			run("flameshot gui | wl-copy"))
hl.bind("SHIFT + Print", 	run("grim -g \"$(slurp)\" - | satty -f -"))

hl.bind("SUPER + left", 	hl.dsp.focus({direction = "left"}))
hl.bind("SUPER + right", 	hl.dsp.focus({direction = "right"}))
hl.bind("SUPER + up", 		hl.dsp.focus({direction = "up"}))
hl.bind("SUPER + down", 	hl.dsp.focus({direction = "down"}))

hl.bind("ALT + Tab", 			hl.dsp.focus({workspace = "e+1"}))
hl.bind("SHIFT + ALT + Tab", 	hl.dsp.focus({workspace = "e-1"}))

hl.bind("SUPER + mouse_down", 	hl.dsp.focus({workspace = "e+1"}))
hl.bind("SUPER + mouse_up", 	hl.dsp.focus({workspace = "e-1"}))

hl.bind("SUPER + S", 			hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT + S", 	hl.dsp.window.move({workspace = "special:magic"}))

hl.bind("SUPER + V" , run("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))

hl.bind("XF86AudioRaiseVolume", 	run("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), 	{locked = true, repeating = true})
hl.bind("XF86AudioLowerVolume", 	run("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), 		{locked = true, repeating = true})
hl.bind("XF86AudioMute", 			run("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), 		{locked = true, repeating = true})
hl.bind("XF86AudioMicMute", 		run("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), 	{locked = true, repeating = true})
hl.bind("XF86MonBrightnessUp", 		run("brightnessctl s 5%+"), 							{locked = true, repeating = true})
hl.bind("XF86MonBrightnessDown", 	run("brightnessctl s 5%-"), 							{locked = true, repeating = true})

hl.bind("XF86AudioNext", 			run("playerctl next", 		{locked = true}))
hl.bind("XF86AudioPause", 			run("playerctl play-pause", {locked = true}))
hl.bind("XF86AudioPlay", 			run("playerctl play-pause", {locked = true}))
hl.bind("XF86AudioPrev", 			run("playerctl previous", 	{locked = true}))

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), 		{mouse = true})
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), 	{mouse = true})

hl.window_rule({
	name = "network-manager-connection-editor",

	match = {
		class = "nm-connection-editor",
		title = ".*"
	},

	float = true,
})

hl.window_rule({
	name = "ark",

	match = {
		class = "org.kde.ark",
		title = ".*"
	},

	float = true,
})

hl.window_rule({
	name = "firefox-picture-in-picture",

	match = {
		class = "firefox",
		title = "Picture-in-Picture",
	},

	float = true,
})

hl.window_rule({
	name = "firefox-library",

	match = {
		class = "firefox",
		title = "Library",
	},

	float = true,
})

hl.window_rule({
	name = "pulseaudio-volume-control",

	match = {
		class = "org.pulseaudio.pavucontrol",
		title = "Volume Control",
	},

	float = true,
	size = {1024, 576},
	move = {"monitor_w*0.5", "monitor_h*0.5"},
})

hl.window_rule({
	name = "file-pickers",

	match = {
		class = "xdg-desktop-portal-gtk",
		title = ".*"
	},

	float = true,
})

hl.window_rule({
	name = "intellij-welcome",

	match = {
		class = "jetbrains-idea",
		title = "Welcome to IntelliJ IDEA",
	},

	float = true,
})

hl.window_rule({
	name = "flameshot",

	match = {
		class = "^$",
		title = "flameshot",
	},

	fullscreen = true;
})

hl.window_rule({
	name = "supress-maximize-events",
	match = {class = ".*"},
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",

	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true;
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})