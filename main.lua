function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    require "requires"
    
    world = wf.newWorld(0, 0)
    testMap = sti("maps/testMap.lua")
    p1 = Player(700, 450, "Purple")
    cam = camera()


    walls = {}
    if testMap.layers["Walls"] then
        for i, obj in pairs(testMap.layers["Walls"].objects) do
            local wall = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            wall:setType("static")
            table.insert(walls, wall)
        end
    end

end


function love.update(dt)
    cam:lookAt(p1.x, p1.y)
    p1.update(p1, dt)

    mapUpdate(dt)

    world:update(dt)
    p1.x = p1.collider:getX() - 48
    p1.y = p1.collider:getY() - 48
end


function love.draw()
    cam:attach()
        testMap:drawLayer(testMap.layers["Ground Layer"])
        testMap:drawLayer(testMap.layers["Fencing"])
        testMap:drawLayer(testMap.layers["Mounds"])
        p1.draw(p1)
        world:draw()
    cam:detach()   
end
