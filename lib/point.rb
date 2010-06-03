class Point
  include Comparable
  attr_accessor :x, :y, :z

  class InvalidArgument < RuntimeError
  end

  def initialize x=0, y=0, z=0
    raise InvalidArgument unless x.is_a?(Numeric)
    raise InvalidArgument unless y.is_a?(Numeric)
    raise InvalidArgument unless z.is_a?(Numeric)
    @x = x.to_f
    @y = y.to_f
    @z = z.to_f
  end

  def + other
    raise InvalidArgument unless is_a_point(other)
    Point.new(@x + other.x, @y + other.y, @z + other.z)
  end

  def - other
    raise InvalidArgument unless is_a_point(other)
    Point.new(@x - other.x, @y - other.y, @z - other.z)
  end

  def * scalar
    raise InvalidArgument unless scalar.is_a?(Numeric)
    Point.new(@x * scalar, @y * scalar, @z * scalar)
  end

  def / scalar
    raise InvalidArgument unless scalar.is_a?(Numeric)
    Point.new(@x / scalar, @y / scalar, @z / scalar)  
  end 

  def <=> other
    raise InvalidArgument unless is_a_point(other)
    if @x != other.x 
      return @x <=> other.x
    elsif @y != other.y
      return @y <=> other.y
    else
      return @z <=> other.z
    end
  end
  
  def to_s
    "(#{@x},#{@y})"
  end

  private

    def is_a_point other
      other.respond_to?(:x) and other.respond_to?(:y) and other.respond_to?(:z)
    end

end
