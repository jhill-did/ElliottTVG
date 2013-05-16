
function newVector2D(nx, ny)

	local this = {}
	this.x = nx or 0;
	this.y = ny or 0;

	function this:getX()
		return this.x;
	end

	function this:getY()
		return this.y;
	end

	function this:addVector(vec)
		return newVector2D(vec.x + this.x, vec.y + this.y);
	end

	function this:subVector(vec)
		return newVector2D(this.x - vec.x, this.y - vec.y);
	end

	function this:normalize()
		local length = (this.x^2 + this.y^2)^0.5;
		this.x = this.x / length;
		this.y = this.y / length;
	end

	function this:scaled(scale)
		this.x = this.x * scale;
		this.y = this.y * scale;
	end

	function this:toString()
		return "x: "..this:getX().." y: "..this:getY();
	end

	return this;
end