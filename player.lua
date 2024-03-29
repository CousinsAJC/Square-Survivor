Player = Object:extend()

function Player:new(x, y, name)

    self.x = x
    self.y = y
    self.name = name
    self.scaleX = 2
    self.scaleY = 2
    self.speed = 250
    self.facing = "right"
    self.centerX = self.x + (24 * self.scaleX)
    self.centerY = self.y + (24 * self.scaleY)

    self.collider = world:newBSGRectangleCollider(self.x, self.y, 48 * self.scaleX * .8, 48 * self.scaleY, 14)
    self.collider:setFixedRotation(true)

    --Equips

    self.sprite_Sheet = love.graphics.newImage("assets/sprites/purpleSquareRun.png")
    self.grid = anim8.newGrid(48, 48, 288, 96)

    self.animations = {}
    self.animations.left = anim8.newAnimation(self.grid("1-6", 1), 0.2)
    self.animations.right = anim8.newAnimation(self.grid("1-6", 2), 0.2)

    self.anim = self.animations.right
end

function Player.update(self, dt)
    self.move(self, dt)
    self.centerX = self.x + (24 * self.scaleX)
    self.centerY = self.y + (24 * self.scaleY)
    self.anim:update(dt)
end


function Player.draw(self)
    self.anim:draw(self.sprite_Sheet, self.x, self.y, nil, self.scaleX, self.scaleY)
end


function Player.move(self, dt)
    local isMoving = false
    local pace = 1

    local vx = 0
    local vy = 0

    --make diagonal movement feel more in line with vert/horiz movement
    --if (love.keyboard.isDown("a") or love.keyboard.isDown("d")) and (love.keyboard.isDown("w") or love.keyboard.isDown("s")) then
        --pace = 0.85
    --end

    --accept input, move player, play animation
    if love.keyboard.isDown("a") then
        self.x = self.x - (self.speed * dt)
        vx = self.speed * -1
        self.facing = "left"
        self.anim = self.animations.left
        isMoving = true
    end

    if love.keyboard.isDown("w") then
        self.y = self.y - (self.speed * dt)
        vy = self.speed * -1
        isMoving = true
        if self.facing == "left" then
            self.anim = self.animations.left
        end
        if self.facing == "right" then
            self.anim = self.animations.right
        end
    end

    if love.keyboard.isDown("s") then
        self.y = self.y + (self.speed * dt)
        vy = self.speed
        isMoving = true
        if self.facing == "left" then
            self.anim = self.animations.left
        end
        if self.facing == "right" then
            self.anim = self.animations.right
        end
    end

    if love.keyboard.isDown("d") then
        self.x = self.x + (self.speed * dt)
        vx = self.speed
        self.facing = "right"
        self.anim = self.animations.right
        isMoving = true
    end

    if isMoving == false then
        self.anim:gotoFrame(2)
    end

    --local length = math.sqrt(vx^2+vy^2)
    --vx,vy = vx/length, vy/length

    --self.x = self.x + vx * self.speed * dt
    --self.y = self.y + vy * self.speed * dt

    self.collider:setLinearVelocity(vx, vy)
end