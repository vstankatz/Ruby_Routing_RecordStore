class Triangle
  attr_reader :a, :b, :c

  def initialize(a, b, c)
    @a = a
    @b = b
    @c = c
  end

  def is_a_triangle?()
    if @a > (@b + @c) || @b > (@a + @c) || @c > (@a + @b)
      return false
    else
      return true
    end
  end

  def type
    if (@b != @c) && (@a != @c) && (@a != @b)
      return 'scalene'
    elsif (@b == @c) && (@a == @c) && (@a == @b)
      return 'equilateral'
    elsif (@b == @c) || (@a == @c) || (@a == @b)
      return "isosceles"
    else
      return false
    end
  end
end
