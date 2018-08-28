platform = {}

player = {x = 50, y = 300, speed = 200, img = love.graphics.newImage('purple.png'),
	y_velocity = 0,
	jump_height = -300,
	gravity = -500}
	
entities = {
	x = 200,
	y = 200,
	img = love.graphics.newImage('purple.png')
	
}

function entities:new (o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
	self.img = love.graphics.newImage(('purple.png'), x, y, 0, 1, 1, 0, 32)
    return o
end

function love.load()
	platform.width = love.graphics.getWidth()
	platform.height = love.graphics.getHeight()
	
	platform.x = 0 
	platform.y = platform.height/1.5
	
	player.ground = player.y
	
end

function love.update(dt)

	if love.keyboard.isDown('d') then
		if player.x < (love.graphics.getWidth() - player.img:getWidth()) then 
			player.x = player.x + (player.speed * dt)
		end	
	elseif love.keyboard.isDown('a') then
		if player.x > 0 then 
			player.x = player.x - (player.speed * dt) 
		end 	
	end 

	if love.keyboard.isDown('space') then
		if player.y_velocity == 0 then
			player.y_velocity = player.jump_height
		end
	end
	
	if love.keyboard.isDown('s') then
		entities:new()
		entities.x = entities.x +1 
		print(entities.img)
		
	end

	if player.y_velocity ~= 0 then
		player.y = player.y + player.y_velocity * dt
		player.y_velocity = player.y_velocity - player.gravity * dt
	end

	if player.y > player.ground then
		player.y_velocity = 0
		player.y = player.ground
	end
end

function love.draw()
	love.graphics.setColor(33,133, 132)

	love.graphics.rectangle('fill', platform.x, platform.y, platform.width,platform.height)
	love.graphics.draw(entities.img, entities.x, entities.y, 0, 1, 1, 0, 32)
	love.graphics.draw(player.img, player.x, player.y, 0, 1, 1, 0, 32)
end
