local league_overview = {}
league_overview.name = "League Overview"

function league_overview:init()
	self.__z = 1
	--
	g.console:log("league_overview:init")
end

function league_overview:added()
	local total_h = g.skin.screen.h - g.skin.margin * 2
	local total_w = g.skin.screen.w - g.skin.margin * 2
	local team_ribbon_h = 42
	local rest_h = total_h - team_ribbon_h - g.skin.margin
	local split_w = math.floor(g.skin.screen.w/2 - g.skin.margin * 1.5 +.5)
	local split_rest_h = math.floor(rest_h/2 - g.skin.margin * .5 + .5)
	self.teams_ribbon = g.components.teams_ribbon.new(g.skin.screen.x + g.skin.margin, g.skin.screen.y + g.skin.margin, g.skin.screen.w - g.skin.margin * 2, team_ribbon_h)
	self.league_table = g.components.league_table.new(g.skin.screen.x + g.skin.margin, self.teams_ribbon.y + self.teams_ribbon.h + g.skin.margin, split_w, rest_h)
	self.upcoming = g.components.fixture_group.new(g.skin.screen.x + g.skin.margin * 2 + self.league_table.w, self.league_table.y, split_w, split_rest_h) 
	self.results = g.components.fixture_group.new(self.upcoming.x, self.upcoming.y + self.upcoming.h + g.skin.margin, self.upcoming.w, self.upcoming.h)
	g.tween_alpha()
	self:set_league()
end

function league_overview:update(dt)
	self.teams_ribbon:update(dt)
	self.league_table:update(dt)
	self.upcoming:update(dt)
	self.results:update(dt)
end

function league_overview:draw()
	self.teams_ribbon:draw(g.tween.t_alpha)
	self.league_table:draw(g.tween.t_alpha)
	self.upcoming:draw(g.tween.t_alpha)
	self.results:draw(g.tween.t_alpha)
end

function league_overview:set_league()
	self.league = g.database.get_view_league()
	self.teams_ribbon:set(self.league.refs.teams, true)
	self.league_table:set(self.league, "default")
	self.upcoming:set(self.league, g.database.vars.week)
	self.results:set(self.league, g.database.vars.week-1)
	--
	g.ribbon:set_league(self.league)
end

function league_overview:mousepressed(x, y, b)
	self.teams_ribbon:mousepressed(x, y, b)
	self.league_table:mousepressed(x, y, b)
	self.upcoming:mousepressed(x, y, b)
	self.results:mousepressed(x, y, b)
end

function league_overview:mousereleased(x, y, b)
	self.teams_ribbon:mousereleased(x, y, b)
	self.league_table:mousereleased(x, y, b)
	self.upcoming:mousereleased(x, y, b)
	self.results:mousereleased(x, y, b)
end

return league_overview