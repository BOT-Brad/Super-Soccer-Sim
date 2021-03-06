local league_stats = {}
league_stats.name = "League Full Table"

function league_stats:init()
	self.__z = 1
	--
	g.console:log("league_stats:init")
end

function league_stats:added()
	self.custom_table = g.components.league_table.new(g.skin.screen.x + g.skin.margin, g.skin.screen.y + g.skin.margin, g.skin.screen.w - g.skin.margin * 2, g.skin.screen.h - g.skin.margin * 2)
	g.tween_alpha()
	self:set()
end

function league_stats:set()
	self.league = g.database.get_view_league()
	--
	self.custom_table:set(self.league, "full")
	--
	g.ribbon:set_league(self.league)
end

function league_stats:update(dt)
	self.custom_table:update(dt)
end

function league_stats:draw()
	self.custom_table:draw(g.tween.t_alpha)
end

function league_stats:mousepressed(x, y, b)
	self.custom_table:mousepressed(x, y, b)
end

function league_stats:mousereleased(x, y, b)
	self.custom_table:mousereleased(x, y, b)
end

return league_stats