require("Scripts.Vector2D");

--class definition
function newElliott(nx, ny)

	--Constructor
		local this = {};

		--Load anim frames
		this.frames = {};
		this.frames[1] = love.graphics.newImage("Assets/Textures/ElliottTex/ElliottIdleR.png"); --Idle
		this.frames[2] = love.graphics.newImage("Assets/Textures/ElliottTex/ElliottIdleL.png"); --Idle

		this.frames[3] = love.graphics.newImage("Assets/Textures/ElliottTex/ElliottR1.png"); --Move Right
		this.frames[4] = love.graphics.newImage("Assets/Textures/ElliottTex/ElliottR2.png");
		this.frames[5] = love.graphics.newImage("Assets/Textures/ElliottTex/ElliottR3.png");
		this.frames[6] = love.graphics.newImage("Assets/Textures/ElliottTex/ElliottR4.png");
		this.frames[7] = love.graphics.newImage("Assets/Textures/ElliottTex/ElliottR5.png");
		this.frames[8] = love.graphics.newImage("Assets/Textures/ElliottTex/ElliottR6.png");
		this.frames[9] = love.graphics.newImage("Assets/Textures/ElliottTex/ElliottR7.png");

		this.frames[10]  = love.graphics.newImage("Assets/Textures/ElliottTex/ElliottL1.png"); --Move Right
		this.frames[11] = love.graphics.newImage("Assets/Textures/ElliottTex/ElliottL2.png");
		this.frames[12] = love.graphics.newImage("Assets/Textures/ElliottTex/ElliottL3.png");
		this.frames[13] = love.graphics.newImage("Assets/Textures/ElliottTex/ElliottL4.png");
		this.frames[14] = love.graphics.newImage("Assets/Textures/ElliottTex/ElliottL5.png");
		this.frames[15] = love.graphics.newImage("Assets/Textures/ElliottTex/ElliottL6.png");
		this.frames[16] = love.graphics.newImage("Assets/Textures/ElliottTex/ElliottL7.png");

		this.currentFrame = 1;
		this.animTimer = 0;
		this.frameDelay = 0.1;
		this.graphic = this.frames[1];
		this.graphic:setFilter("nearest", "nearest");
		this.facingEnum = { LEFT = 0, RIGHT = 1};
		this.facingDirection = this.facingEnum.RIGHT;

		this.scaleFactor = 4; --Scale character and hit box by 4x
		this.body 		= love.physics.newBody(world, nx, ny, "dynamic");
		this.shape 		= love.physics.newRectangleShape(this.graphic:getWidth()*this.scaleFactor, this.graphic:getHeight()*this.scaleFactor);
		this.fixture 	= love.physics.newFixture(this.body, this.shape, 1);
		
		this.body:setFixedRotation(true);
		this.movementSpeed = 600;
		this.body:setMass(1);
		this.body:setLinearDamping(0.1);

	--End Constructor

	function this:update(dt)

		this.animTimer = this.animTimer + dt;

		local horizontal = 0;

		if(love.keyboard.isDown("d")) then --If our input is right

			this.facingDirection = this.facingEnum.RIGHT;

			if(this.animTimer > this.frameDelay) then
				this.currentFrame = this.currentFrame + 1; --Play anim
				this.animTimer = 0;
			end

			--Clamp anim for moving right.
			if(this.currentFrame > 9) then this.currentFrame = 3 end
			if(this.currentFrame < 3) then this.currentFrame = 3 end

			if(this.body:getLinearVelocity() < 130) then
				horizontal = 1;
			end

		elseif(love.keyboard.isDown("a")) then --If our input is left

			this.facingDirection = this.facingEnum.LEFT;

			if(this.animTimer > this.frameDelay) then
				this.currentFrame = this.currentFrame + 1; --Play left move anim
				this.animTimer = 0;
			end

			if(this.currentFrame > 16) then this.currentFrame = 10 end
			if(this.currentFrame < 10)  then this.currentFrame = 10 end

			if(this.body:getLinearVelocity() > -130) then
				horizontal = -1;
			end
		elseif(this.facingDirection == this.facingEnum.RIGHT) then
			this.currentFrame = 1;
		else
			this.currentFrame = 2;
		end

		local vertical = 0;

		local movementDirection = newVector2D(horizontal, vertical);
		movementDirection:normalize();

		this.body:applyForce(horizontal*this.movementSpeed,vertical*this.movementSpeed);

		this.frames[this.currentFrame]:setFilter("nearest","nearest");

	end --update


	function this:draw()
		love.graphics.setColor(255,255,255,255);
		love.graphics.draw(this.frames[this.currentFrame], this.body:getX()-this.graphic:getWidth()* this.scaleFactor/2, this.body:getY()-this.graphic:getHeight()* this.scaleFactor/2, 0, this.scaleFactor, this.scaleFactor);
	end

	return this; --Return our created prototype
end


