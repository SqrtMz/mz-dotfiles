hl.monitor({
	output = "DP-1",
	mode = "2560x1440@210",
	position = "0x0",
	scale = 1,
	vrr = 1,
	cm = "srgb",
})

hl.monitor({
	output = "DP-2",
	mode = "1920x1080@180",
	position = "2560x0",
	scale = 1,
	vrr = 1,
	cm = "srgb",
})

hl.monitor({
	output = "HDMI-A-1",
	disabled = true,
	mode = "1920x1080@75",
	position = "0x0",
	scale = 1,
	vrr = 1,
	cm = "srgb",
	mirror = "DP-1",
})