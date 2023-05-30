# section 8 : Blocks and Using Blocks

def t i
  (1..i).each do |j|
    print "  " * j
    (j..i).each {|k| print k; print " "}
    print "\n"
  end
end

t 9

class Foo
  def initialize(max)
    @max=max
  end

  def silly i
    yield(3,4) + yield(@max,@max)
  end

  def count base
    if base > @max
      raise "reached max"
    elsif yield base
      1
    else
      1 + count(base+1) {|i| yield i}
    end
  end

  def test i
    puts i
  end

  def test2 i
    puts i
    puts "\n"
    (test(i+3))
  end
end


