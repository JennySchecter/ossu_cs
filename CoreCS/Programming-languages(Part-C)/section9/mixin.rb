# Section 9 : MixIn

# Comparable 是ruby中的一个重要的mixin, 数字、字符串的>、=、<等比较操作符均是
# 由mixin的 <=> 扩展而来，下面我们为自己的Name类定义一个比较的方法
class Name
  attr_accessor :first, :middle, :last
  include Comparable
  def initialize(first,last,middle="")
    @first = first
    @last = last
    @middle = middle
  end
  def <=> other
    l = @last <=> other.last # <=> defined on strings
    return l if l != 0
    f = @first <=> other.first
    return f if f != 0
    @middle <=> other.middle
  end
end

# Enumerable 也是ruby另一个重要的mixin, 很多对象的map、count、any?、等迭代方法
# 也要求对象本身必须要有一个each方法。
class MyRange
  include Enumerable
  def initialize(low,high)
    @low = low
    @high = high
  end
  def each
    i=@low
    while i <= @high
      yield i
      i=i+1
    end
  end
end

class A
  def initialize a
    @@arr = a
  end
  def get i
    @@arr[i]
  end
  def sum
    @@arr.inject(0) {|acc,x| acc + x}
  end
end

class B < A
  def initialize a
    super
    @ans = false
  end
  def sum
    if !@ans
      @ans = @@arr.inject(0) {|acc,x| acc + x}
    end
    @ans
  end
end

