require 'rspec'
require 'triangle'


describe('#is_a_triangle?') do
  it('Checks if inputs create a triangle') do
    triangle = Triangle.new(2, 2, 8)
    puts triangle.c
    expect(triangle.is_a_triangle?).to(eq(false))
  end
end

describe('#type') do
  it('Will say isosceles when isosceles') do
    triangle = Triangle.new(2, 2, 3)
  expect(triangle.type).to(eq("isosceles"))
  end
end

describe('#type') do
  it('Will say equilateral when equilateral') do
    triangle = Triangle.new(2, 2, 2)
    expect(triangle.type).to(eq('equilateral'))
  end
end

describe('#type') do
  it('Will say scalene when scalene') do
    triangle = Triangle.new(1, 2, 3)
    expect(triangle.type).to(eq('scalene'))
  end
end
