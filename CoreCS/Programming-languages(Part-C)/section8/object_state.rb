# Section 7 : Object State

class A
  def initialize (f=0)
    @foo=f
  end
  
  def m1
    @foo = 0
  end

  def m2 x
    @foo += x
  end

  def m3 a
    @foo += a.foo
  end

  protected
  def foo
    @foo
  end
  
end

class C
  # we add a class-veriable(bar), class-constants(Jennys_age), and class-method(reset_bar)
  Jennys_age = 31
  def self.reset_bar
    @@bar = 0
  end

  def initialize(f=0)
    @foo=f
  end

  def m2 x
    @foo += x
    @@bar += 1
  end

  def foo
    @foo
  end

  def bar
    @@bar
  end
end


