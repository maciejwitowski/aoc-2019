class Traverser
  def initialize(moves)
    @moves = moves
  end

  def traverse
    current_position = Point.new(0, 0)
    path = []

    moves.each do |move|
      move.num_of_steps.times {
        current_position = perform_move(current_position, move.direction)
        path << current_position
      }
    end

    path
  end

  private

  def perform_move(point, direction)
    case direction
    when :up
      Point.new(point.x, point.y + 1)
    when :down
      Point.new(point.x, point.y - 1)
    when :left
      Point.new(point.x - 1, point.y)
    when :right
      Point.new(point.x + 1, point.y)
    else
      raise "Unsupported direction #{direction}"
    end
  end

  attr_reader :moves
end
