scale = 8
addlength = 3
size = 64

head_color = 12
food_color = 2
border_color = 8
body_color = 11

x = 1
y = 1
deltay = 0
deltax = 0
count = 1
body = {}
adding = false
addcount = 0
food_x = 1
food_y = 1

function _init()
    x = 1
    y = 1
    deltay = 0
    deltax = 0
    count = 1
    body = {}
    adding = false
    addcount = 0
    place_food()
end

function _update()
    if btn(0) and
       deltax!=1 then -- left
        deltax=-1
        deltay=0
    end
    if btn(1) and
       deltax!=-1 then -- right
        deltax=1
        deltay=0
    end
    if btn(2) and
       deltay!=1 then -- up
        deltay=-1
        deltax=0
    end
    if btn(3) and
       deltay!=-1 then -- down
        deltay=1
        deltax=0
    end

    move()
end

function _draw()
    cls()
    color(border_color)
    rect(0,0,size + 1, size + 1)
    draw_food()
    draw_snake()
end

function draw_food()
    color(food_color)
    rectfill(food_x,food_y,food_x,food_y)
end

function place_food()
    food_x = flr(rnd(size))+1
    food_y = flr(rnd(size))+1
end

function draw_snake()
    color(head_color)
   
    rectfill(x,y,x,y)
   
    for i=1,#body do
        color(body_color)
        rectfill(body[i].x,body[i].y,body[i].x,body[i].y)
    end
end

function move()
    eat() 
   
    x+=deltax
    y+=deltay
   
    for i=1,#body do
        if body[i].x==x and body[i].y==y then
            _init()
            return
        end
    end

    -- if your off the sceen die
    if x>(size - 1) then 
        _init()
    end
    if x<1 then 
        _init()
    end
    if y>(size - 1) then 
        _init()
    end
    if y<1 then 
        _init()
    end
end

function eat()
    if x==food_x and y==food_y then
        place_food()
        adding=true
    end

    if adding then
        if addcount==addlength then
            adding=false
            addcount=0
        else
            addcount+=1
            count+=1
        end
    end
    if count-1==#body then
        for i=1,#body-1 do 
            body[i] = body[i+1]
        end
    end
   
    body[count-1] = {}
    body[count-1].x = x
    body[count-1].y = y
end