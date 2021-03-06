local ui = 1
local panel = {}
panel.__index = panel
panel.__type = "UI.Panel"

function panel.init(ui_ref) ui = ui_ref end

panel.__defaultAlpha = 190

function panel.new(x, y, w, h, color1, color2, alpha)
	local p = {}
	setmetatable(p, panel)
	p:set(x, y, w, h, color1, color2, alpha)
	return p
end

function panel:set(x, y, w, h, color1, color2, alpha)
	self.x, self.y = x or self.x or 0, y or self.y or 0
	self.w, self.h = w or self.w or 10, h or self.h or 10
	self:set_colors(color1, color2)
	self.alpha = alpha or self.alpha or panel.__defaultAlpha
end

function panel:set_colors(c1, c2)
	self.color1, self.color2 = c1 or self.color1 or ui.__defaultColor1, c2 or self.color2 or ui.__defaultColor3
end

function panel:draw(ox, oy)
	ox, oy = ox or 0, oy or 0
	--
	ui.setColorAlpha(self.color2, self.alpha)
	ui.roundrect("fill", self.x, self.y, self.w, self.h, ui.__defaultRounded)
	ui.setColorAlpha(self.color1, self.alpha)
	ui.roundrect("fill", self.x + 1, self.y + 1, self.w - 2, self.h - 2, ui.__defaultRounded)
end

setmetatable(panel, {_call = function(_, ...) return panel.new(...) end})

return panel