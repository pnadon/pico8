scale = 8
speedinticks = 5
tick = 1
addlength = 3
size = 64

head_color = 12
food_color = 2
border_color = 8
body_color = 11

game = {}
snake = {}
food = {}

function _init()
    snake.x = 1
    snake.y = 1
    snake.deltay = 0
    snake.deltax = 0
    snake.count = 1
    snake.body = {}
    snake.adding = false
    snake.addcount = 0
    food:move()
end

function _update()
    snake:keypress()
    if tick==speedinticks then
        snake:move()
        tick=1
    else
        tick+=1
    end
end

function _draw()
    cls()
    color(border_color)
    rect(0,0,size + 1, size + 1)
    food:draw()
    snake:draw()
end

function food:draw()
    color(food_color)
    rectfill(self.x,self.y,self.x+scale - 1,self.y+scale - 1)
end

function food:move()
    self.x = (flr(rnd(size/scale))*scale)+1
    self.y = (flr(rnd(size/scale))*scale)+1
end

function snake:draw()
    color(head_color)
   
    rectfill(self.x,self.y,self.x+scale - 1,self.y+scale - 1)
   
    for i=1,#self.body do
        color(body_color)
        rectfill(self.body[i].x,self.body[i].y,self.body[i].x+scale - 1,self.body[i].y+scale - 1)
    end
end

function snake:keypress()
    if btn(0) and
       self.deltax!=1 then -- left
        self.deltax=-1
        self.deltay=0
    end
    if btn(1) and
       self.deltax!=-1 then -- right
        self.deltax=1
        self.deltay=0
    end
    if btn(2) and
       self.deltay!=1 then -- up
        self.deltay=-1
        self.deltax=0
    end
    if btn(3) and
       self.deltay!=-1 then -- down
        self.deltay=1
        self.deltax=0
    end
end

function snake:move()
    self:eat() 
   
    self.x+=self.deltax*(scale)
    self.y+=self.deltay*(scale)
   
    for i=1,#self.body do
        if self.body[i].x==self.x and self.body[i].y==self.y then
            _init()
            return
        end
    end

    -- if your off the sceen die
    if self.x>(size - 1) then 
        _init()
    end
    if self.x<1 then 
        _init()
    end
    if self.y>(size - 1) then 
        _init()
    end
    if self.y<1 then 
        _init()
    end
end

function snake:eat()
    if self.x==food.x and self.y==food.y then
        food:move()
        self.adding=true
    end

    if self.adding then
        if self.addcount==addlength then
            self.adding=false
            self.addcount=0
        else
            self.addcount+=1
            self.count+=1
        end
    end
    if self.count-1==#self.body then
        for i=1,#self.body-1 do 
            self.body[i] = self.body[i+1]
        end
    end
   
    self.body[self.count-1] = {}
    self.body[self.count-1].x = self.x
    self.body[self.count-1].y = self.y
end