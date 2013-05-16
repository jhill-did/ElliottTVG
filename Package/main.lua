
require("Scripts.Elliott");

function love.load()
	-- create structures
	canvas = love.graphics.newCanvas();
	objects = {};
	love.physics.setMeter(64);
	world  = love.physics.newWorld(0, 9.86*64, true);

	-- set defaults
	love.graphics.setBackgroundColor(255,245,227);
	world:setCallbacks(edgeCollide);
	love.graphics.setColorMode("modulate");
	displayFont = love.graphics.setNewFont("Assets/LUZRO.TTF", 18);

	-- create elliott
	objects.elliott = newElliott(100,100);

	-- init everything dependant on window size
	windowWidth, windowHeight = 800, 600;
	love.graphics.setCaption("Elliot: The Video Game")
	windowSize(windowWidth, windowHeight, false)
end

function love.update(dt)
	world:update(dt);
	objects.elliott:update(dt);
end

function love.draw()
	-- draw on unstretched canvas

	love.graphics.setColor(50,50,0,255);
	love.graphics.setCanvas();
	objects.elliott:draw();

	love.graphics.setColor(0,0,0,255);
	love.graphics.print("Use W, A, S, and D\nto move around.", 200,200,0,1,1);

end

function windowSize(w, h, becomeFullscreen)
	 -- defaults arguments
	w = w or 800;
	h = h or 600;
	becomeFullscreen = becomeFullscreen or false;

	-- if edges already present, destroy them (resizing window)
	if objects.edges then
		for name, edge in pairs(objects.edges) do
			edge.fixture:destroy();
			edge.body:destroy();
		end
	end

	-- create edge shapes
	objects.edges = {}
	objects.edges.top 			= {shape= love.physics.newEdgeShape(0, 0, w, 0)}
	objects.edges.right 		= {shape= love.physics.newEdgeShape(w, 0, w, h)}
	objects.edges.left 			= {shape= love.physics.newEdgeShape(0, 0, 0, h)}
	objects.edges.bottom		= {shape= love.physics.newEdgeShape(0, h, w, h)}

	-- loop and create the common properties
	for i, v in ipairs({"top", "right", "bottom", "left"}) do
		objects.edges[v].body 	 = love.physics.newBody(world, 0, 0, "static")
		objects.edges[v].fixture = love.physics.newFixture(objects.edges[v].body, objects.edges[v].shape, 1)
		objects.edges[v].fixture:setUserData(v)
	end

	love.graphics.setMode(w, h, becomeFullscreen, true, 2)

	-- replace elliott if needed
	local bb = objects.elliott.body
	if bb:getX() > w or bb:getY() > h then
		bb:setX(w/2)
		bb:setY(h/2)
	end
end


