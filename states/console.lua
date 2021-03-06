local console = {}
console.name = "Console"

local data = {}

function console:init()
	self.__z = 9
	self.visible = false
	self.game_identity = love.filesystem.getIdentity()
	self.user_directory = love.filesystem.getUserDirectory()
	self.symlinks_enabled = love.filesystem.areSymlinksEnabled()
	self.appdata_directory = love.filesystem.getAppdataDirectory()
	self.save_directory = love.filesystem.getSaveDirectory()
	self.source_directory = love.filesystem.getSourceBaseDirectory()
	self.is_fused = love.filesystem.isFused()
	--
	g.console:log("console:init")
end

function console:added()

end

function console:update(dt)

end

function console:draw()
	if self.visible==false then return end
	local pm = g.skin.console.padding + g.skin.console.margin
	love.graphics.setColor(0, 0, 0, g.skin.console.alpha)
	love.graphics.roundrect("fill", g.skin.console.margin, g.skin.console.margin, g.width - g.skin.console.margin*2, g.height - g.skin.console.margin*2, g.skin.console.rounded)
	love.graphics.setColor(255, 255, 255, 255)
	g.font.set(g.skin.console.font)
	local y = g.height - g.skin.console.margin - g.skin.console.padding - g.font.height()
	for i = 1, #data do
		love.graphics.setColor(data[i].color)
		love.graphics.print(data[i].text, pm, y)
		y = y - g.font.height()
	end
	-- Display draw stats
	local stats = love.graphics.getStats()
	local arr = {}
	arr[1] = string.format("LÖVE Version: %s.%s.%s", g.v_major, g.v_minor, g.v_revision)
	arr[2] = string.format("Game Version: %s", g.version)
	arr[3] = string.format("Current FPS: %s", love.timer.getFPS())
	arr[4] = string.format("RAM: %i MB", collectgarbage("count")/1024)
	arr[5] = string.format("VRAM: %.2f MB", stats.texturememory/1024/1024)
	arr[6] = string.format("Draw Calls: %i", stats.drawcalls)
	arr[7] = string.format("Loaded Images: %s (0x%x)", stats.images, stats.images)
	arr[8] = string.format("Loaded Fonts: %s (0x%x)", stats.fonts, stats.fonts)
	arr[9] = string.format("mx %i , my %i", g.mouse.x, g.mouse.y)

	local arr2 = {}
	arr2[1] = "Game Identity: " .. self.game_identity
	arr2[2] = "User Directory: " .. self.user_directory
	arr2[3] = "Symlinks Enabled: " .. tostring(self.symlinks_enabled)
	arr2[4] = "AppData Dir: " .. self.appdata_directory
	arr2[5] = "Save Dir: " .. self.save_directory
	arr2[6] = "Source Dir: " .. self.source_directory
	arr2[7] = "Is Game Fused? - " .. tostring(self.is_fused)

	love.graphics.setColor(255, 255, 255, 255)
	for i=1, #arr do
		love.graphics.print(arr[i], pm, pm + (i-1)*g.font.height())
	end
	for i=1, #arr2 do
		love.graphics.print(arr2[i], g.width - pm - 600, pm + (i-1)*g.font.height())
	end
end

function console:keypressed(k, ir)
	if k=="`" then self.visible = not self.visible end
	if k=="p" then self:print(g.state.order(), g.skin.green); self:print(g.state.z_order(), g.skin.blue) end
	if k=="delete" then data = {} end
end

-- Functions

function console:log(...)
	local str = ""
	local a = {...}
	for i, v in ipairs(a) do
		str = str .. tostring(v) .. "\t"
	end
	table.insert(data, 1, {text = str; color = {123,123,123,255};} )
	console:trim()
end

function console:hr()
	table.insert(data, 1, {text = "────────────────────"; color = {123, 123, 123, 255};} )
	console:trim()
end

function console:print(text, color)
	color = color or {123,123,123,255}
	table.insert(data, 1, {text = text; color = color;} )
	console:trim()
end

function console:trim()
	while #data > 50 do
		data[#data] = nil
	end
end

return console