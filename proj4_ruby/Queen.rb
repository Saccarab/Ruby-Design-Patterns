require_relative 'Algorithm'
require_relative 'Meadow'
require_relative 'Queen'
class Queen
attr_accessor :x_coords, :y_coords,:x_array,:y_array
  def initialize(color)
@anthill=Anthill.new
    @color=color
    @x_array=Array.new
    @y_array=Array.new
  end

 def buildAnthill
   @anthill
 end

 def location
   x_coords =rand(15)
   y_coords = rand 15
   for i in x_array
     for y in y_array
       if x_array[i]==x_coords and y_array==y_coords
         x_coords =rand(15)
         y_coords = rand 15
       end
     end
   end
    @anthill.x_coords =x_coords
    @anthill.y_coords =y_coords
    self
 end
  def setAnthill
   @anthill=Anthill.new
  self
 end

 def setColor
  @anthill.color=@color
  self
 end

  def defineStrategy
      pick=rand(3)
      if(pick==0)
        @anthill.strategy=Aggressive.new
      elsif(pick==1)
        @anthill.strategy=Economy.new
      else
        @anthill.strategy=Growth.new
      end
      self
  end
end
