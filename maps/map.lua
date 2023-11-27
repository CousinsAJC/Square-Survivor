function mapUpdate(dt)
    
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    local mapW = testMap.width * testMap.tilewidth
    local mapH = testMap.height * testMap.tileheight

    --camera bounds 4 sides
    if cam.x < w/2 then
        cam.x = w/2
    end
    if cam.x > (mapW - w/2) then
        cam.x = (mapW - w/2)
    end

    if cam.y < h/2 then
        cam.y = h/2
    end
    if cam.y > (mapH - h/2) then
        cam.y = (mapH - h/2)
    end
end
