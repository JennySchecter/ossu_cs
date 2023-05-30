# Section 8 : A Longer Example

class MyRational
  
  def initialize(num,den=1)
    if den == 0
      raise "MyRational received an inappropriate argument"
    elsif den < 0
      @num = - num
      @den = - den
    elsif
      @num = num
      @den = den
    end
    reduce # i.e., self.reduce() but private
  end

  def to_s
    ans = @num.to_s
    if @den != 1
      ans += "/"
      ans += @den.to_s
    end
    ans
  end

  def to_s2
    ans = @num.to_s 
    ans += "/" +  @den.to_s if @den != 1
    ans
  end
  
  def to_s3 # using like racket's quasiquote and unquote
    "#{@num}#{if @den!=1 then "/"+ @den.to_s else "" end}"
  end

  def add! r
    a = r.num
    b = r.den
    c = @num
    d = @den
    @num = (a*d) + (c*b)
    @den = (b*d)
    reduce
    self
  end

  # a functional addition, so we can write r1.+ r2 to
  # make a new rational
  # and built-in syntactic sugar will work: can write r1 + r2
  def + r
    ans = MyRational.new(@num,@den)
    ans.add! r
  end

  protected
  # there is a very common sugar for this (attr_reader)
  # the better way:
  # attr_reader :num,:den
  # protected :num,:den
  # we do not want these methods public
  # but we cantnot make these methods private
  # because the add! mtehod above
  def num
    @num
  end
  def den
    @den
  end

  private
  def gcd(x,y)
    if x == y
      x
    elsif x > y
      gcd(x-y,y)
    else
      gcd(y,x)
    end
  end

  def reduce
    if @num == 0
      @den = 1
    else
      d = gcd(@num.abs,@den)
      @num = @num/d
      @den = @den/d
    end
  end

end

# top-level for testing
def use_rationals
  r1 = MyRational.new(3,4)
  r2 = r1 + r1 + MyRational.new(-5,2)
  puts r2.to_s
  (r2.add! r1).add! (MyRational.new(1,-4))
  puts r2.to_s
  puts r2.to_s2
  puts r2.to_s3
end

      
