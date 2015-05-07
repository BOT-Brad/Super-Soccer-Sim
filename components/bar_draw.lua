local bd = {}

function bd.draw(bar, ox, oy)
	ox, oy = ox or 0, oy or 0
	if bar.x + ox > g.width or bar.y + oy > g.height or bar.x + ox + bar.w < 0 or bar.y + oy + bar.h < 0 then return end
	love.graphics.setColorAlpha(bar.color, bar.alpha)
	love.graphics.rectangle("fill", bar.x + ox, bar.y + oy, bar.w, bar.h)
	if bar.rects then
		for i=1, #bar.rects do
			local rect = bar.rects[i]
			love.graphics.setColorAlpha(rect.color, rect.alpha or 255)
			if rect.rounded then
				love.graphics.roundrect("fill", bar.x + rect.x + ox, bar.y + rect.y + oy, rect.w, rect.h, rect.rounded)
			else
				love.graphics.rectangle("fill", bar.x + rect.x + oy, bar.y + rect.y + oy, rect.w, rect.h)
			end
		end
	end
	if bar.labels then
		for i=1, #bar.labels do
			local label = bar.labels[i]
			g.font.set(label.font)
			love.graphics.setColorAlpha(label.color, label.alpha or 255)
			if label.align then
				love.graphics.printf(label.text, bar.x + label.x + ox, bar.y + label.y + oy, label.w, label.align)
			else
				love.graphics.print(label.text, bar.x + label.x + ox, bar.y + label.y + oy)
			end
			if label.underline==true then
				love.graphics.rectangle("fill", bar.x + label.x + ox, bar.y + label.y + label.h + oy - 1, label.w, 1)
			end
		end
	end
	if bar.images then
		love.graphics.setColor(255, 255, 255, 255)
		for i=1, #bar.images do
			bar.images[i]:draw(bar.x + ox, bar.y + oy)
		end
	end
end

return bd