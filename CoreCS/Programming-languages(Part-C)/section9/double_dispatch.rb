
class Exp
end

class Value < Exp
end

class Int < Value
  attr_reader :i
  def initialize(i)
    @i = i
  end
  def eval
    self
  end
  def toString
    @i.to_s
  end
  def hasZero
    i == 0
  end
  def noNegConstants
    if i < 0
      Negate.new(Int.new(-i))
    else
      self
    end
  end

  # double dispatch
  def add_values v
    v.add_int self
  end
  def add_int v
    Int.new(i+v.i)
  end
  def add_string v
    MyString.new(v+i.to_s)
  end
  def add_rational v
    MyRational.new(i*v.j+v.i,v.j)
  end
end

class Negate < Exp
  attr_reader :e
  def initialize e
    @e=e
  end
  def eval
    Int.new(-@e.eval.i) # error if e.eval has no i method
  end
  def toString
    "-(" + e.toString + ")"
  end
  def hasZero
    e.hasZero
  end
  def noNegConstants
    Negate.new(e.noNegConstants)
  end
end

class Add < Exp
  attr_reader :e1,:e2
  def initialize(e1,e2)
    @e1 = e1
    @e2 = e2
  end
  def eval
    # Int.new(e1.eval.i + e2.eval.i)
    # now we can not only add Same type but also can add string +int or (rational+int)
    e1.eval.add_values e2.eval
  end
  def toString
    "(" + e1.toString + " + " + e2.toString + ")"
  end
  def hasZero
    e1.hasZero or e2.hasZero
  end
  def noNegCostants
    Add.new(e1.noNegConstants, e2.noNegConstants)
  end
end

class Mult < Exp
  attr_reader :e1,:e2
  def initialize(e1,e2)
    @e1 = e1
    @e2 = e2
  end
  def eval
    Int.new(e1.eval.i * e2.eval.i) 
  end
  def toString
    "(" + e1.toString + " * " + e2.toString + ")"
  end
  def hasZero
    e1.hasZero or e2.hasZero
  end
  def noNegCostants
    Mult.new(e1.noNegConstants, e2.noNegConstants)
  end
end

class MyString < Value
  attr_reader :s
  def initialize s
    @s = s
  end
  def eval
    self
  end
  def toString
    s
  end
  def hasZero
    false
  end
  def noNegCostants
    self
  end

  # double dispatch
  def add_values v
    v.add_string self
  end
  def add_int v
    MyString.new(v.i.to_s+s)
  end
  def add_string v
    MyString.new(v.s+s)
  end
  def add_rational v
    MyString.new(v.i.to_s + "/" + v.j.to_s + s)
  end
end

class MyRational < Value
  attr_reader :i,:j
  def initialize (i,j)
    @i = i
    @j = j
  end
  def eval
    self
  end
  def toString
    @i.to_s + "/" + @j.to_s
  end
  def hasZero
    i==0
  end
  def noNegConstants
    if i < 0 and j < 0
      MyRational.new(-i,-j)
    elsif i < 0
      Negate.new(MyRational.new(-i,j))
    elsif j < 0
      Negate.new(MyRational.new(i,-j))
    else self
    end
  end

  # double dispatch
  def add_values v
    v.add_rational self
  end
  def add_int v
    MyRational.new(v.i*j+i,j)
  end
  def add_string v
    MyString.new(v.s + i.to_s + "/" + j.to_s)
  end
  def add_rational v
    # MyRational.new(v.i*j+v.j*i,v.j*j)
    # this seems more concise
    a,b,c,d = i,j,v.i,v.j
    MyRational.new(a*d+b*c,b*d)
  end
end


# test
class A
  attr_accessor :m
 
end

class B < A

end
