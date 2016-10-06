local BASH = BASH;
local draw = draw;

/*
**	PositionIsInArea
**	Checks to see if a screen position is within the specified area.
**		posX: X-position of the coordinate.
**		posY: Y-position of the coordinate.
**		firstPosX: X-position of the first vertex.
**		firstPosY: Y-position of the first vertex.
**		secondPosX: X-position of the second vertex.
**		secondPosY: Y-position of the second vertex.
**	returns: boolean
*/
function PositionIsInArea(posX, posY, firstPosX, firstPosY, secondPosX, secondPosY)
	return ((posX >= firstPosX and posX <= secondPosX) and (posY >= firstPosY and posY <= secondPosY));
end

/*
**	BASH.GUIOpen
**	Returns whether or not major GUI elements (intro/quiz/character menu) are open.
**	returns: boolean
*/
function BASH:GUIOpen()
	return !self.IntroDone or self.CharacterMenu.Open or self.Quiz.Open;
end

/*
**	BASH.GUIOccupied
**	Returns whether or not minor GUI elements are open.
**	returns: boolean
*/
function BASH:GUIOccupied()
	return self.HelpMenu.Open or self.Inventory.Open or self.Scoreboard.Open or self.PDA.Open or self.ContextMenu.Open or self.Writing.Open or self.Market.Open or self.EditingFlags or self.EditingHistory or self.EditingWhitelists or self.EditingAdvert or self.EditingGroup;
end

/*
**	draw.Circle
**	A handler for drawing circles.
**		xPos: X-position of the center of the circle.
**		yPos: Y-position of the center of the circle.
**		r: Radius of the circle.
**		quality: Amount of verticies on the circle.
**		color: Color of the circle.
*/
function draw.Circle(xPos, yPos, r, quality, color)
	local points = {};
	local temp;

	for index = 1, quality do
		temp = math.rad(index * 360) / quality;

		points[index] = {
			x = posX + (math.cos(temp) * r),
			y = posY + (math.sin(temp) * r)
		};
	end

	draw.NoTexture();
	surface.SetDrawColor(color);
	surface.DrawPoly(points);
end

/*
**	draw.Radial
**	A handler for drawing radials (incomplete circles).
**		x: X-position of the center of the radial.
**		y: Y-position of the center of the radial.
**		r: Radius of the radial.
**		ang: Angle of the opening in the radial.
**		rot: Rotation angle of the radial.
**		color: Color of the radial.
*/
function draw.Radial(x, y, r, ang, rot, color)
	local segments = 360;
	local segmentstodraw = 360 * (ang / 360);
	rot = rot * (segments / 360);
	local poly = {};

	local temp = {};
	temp['x'] = x;
	temp['y'] = y;
	table.insert(poly, temp);

	for i = 1 + rot, segmentstodraw + rot do
		local temp = {};
		temp['x'] = math.cos((i * (360 / segments)) * (math.pi / 180)) * r + x;
		temp['y'] = math.sin((i * (360 / segments)) * (math.pi / 180)) * r + y;

		table.insert(poly, temp);
	end

	draw.NoTexture();
	surface.SetDrawColor(color);
	surface.DrawPoly(poly);
end
