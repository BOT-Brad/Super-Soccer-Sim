local skin = {}

local hex = love.graphics.hexToRgb

skin.red = hex("ff3333")
skin.green = hex("33ff33")
skin.blue = hex("3333ff")
skin.white = hex("ffffff")
skin.black = hex("333333")

-- Load fonts
g.font.new("console", "assets/fonts/consolas/regular.ttf",		{12, 13, 14, 24, 36, 48})
g.font.new("regular", "assets/fonts/opensans/regular.ttf", 		{12, 13, 14, 24, 36, 48})
g.font.new("semibold", "assets/fonts/opensans/semibold.ttf",	{12, 13, 14, 24, 36, 48})
g.font.new("bold", "assets/fonts/opensans/bold.ttf",			{12, 13, 14, 24, 36, 48})
g.font.new("bebas", "assets/fonts/bebasneue/regular.otf",	 	{12, 13, 14, 24, 36, 48})

skin.colors = {
	hex("090909ff"); -- Primary color used for navbar bg, etc
	hex("a7dbd8ff");
	hex("e0e4ccff");
	hex("f38630ff");
	hex("fa6900ff");
}

skin.margin = 4
skin.padding = 8
skin.tab = 22

skin.darken = 0.8 -- 20% color reduction for darken

skin.console = {
	font = { "console", 14 };
	margin = skin.margin;
	padding = skin.padding;
}

skin.navbar = {
	x = 0;
	y = 0;
	w = 52;
	h = g.width;
}

skin.ribbon = {
	font = { "bold", 36 };
	x = skin.navbar.w;
	y = 0;
	w = g.width - skin.navbar.w;
	h = 74;
	border = 2;
	shadow_x = 2;
	shadow_y = 2;
	large_logo_alpha = 50;
	tween_time = .4;
	tween_type = "out-circ";
	tween_ox = 0;
	tween_oy = -20;
	tween_alpha = 0;
}

skin.screen = {
	x = skin.navbar.w; -- Width of the navbar
	y = skin.ribbon.h; -- Height of the ribbon
	w = g.width - skin.navbar.w;
	h = g.height - skin.ribbon.h;
}

skin.ui = {
	button = {
		font = { "semibold", 12 };
	};
}

return skin