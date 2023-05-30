# Section 8: Subclassing and Inheritance

class Point
  attr_accessor :x, :y  # defines methods x,y,x=,y=
  def initialize(x,y)
    @x = x
    @y = y
  end
  def distFromOrigin
    Math.sqrt(@x * @x + @y * @y) # uses instance variables
  end
  def distFromOrigin2
    Math.sqrt(x * x + y * y) # uses getter methods
  end
end

class ColorPoint < Point
  attr_accessor :color
  def initialize(x,y,c = "clear")
    super(x,y)   # super is key word, call same method in superclass
    @color = c
  end
end

class A
  attr_accessor :x, :y
  def initialize(x,y)
    @x = x
    @y = y
  end

  private
  def bigger
    x > y
  end
  
end

class B < A
  def initialize(x,y)
    super
  end

  def m
    if bigger
    then puts "yes"
    else puts "no"
    end
  end
end
