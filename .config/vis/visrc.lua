-- load standard vis module, providing parts of the Lua API
require('vis')
require('vis-go/vis-go')

vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	-- Your per window configuration options e.g.
	vis:command('set theme nord')
	vis:command('set number')
	vis:command('set ai on')
	vis:command('map! insert <C-h> <Left>')
	vis:command('set tabwidth 4')

	if vis.win.syntax == "python" then
		vis:command('set et on')
		vis:command('set cc 100')
	end
end)
