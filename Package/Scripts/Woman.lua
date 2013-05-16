

function newWoman()

	local this = {};
		this.graphics 	= love.graphics.newImage("Assets/elliot.png");
		this.body 		= love.physics.newBody(world, 800/2, 800/2, "dynamic");
		this.shape 		= love.physics.newRectangleShape(64, 64);
		this.fixture 	= love.physics.newFixture(this.body, this.shape, 1);

		this.movementSpeed = 200;
		this.body:setMass(100);

	

end