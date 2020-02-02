require "test/unit"
require_relative "move_parser"
require_relative "traverser"
require_relative "input_reader"
include Test::Unit::Assertions

Point = Struct.new(:x, :y)
Move = Struct.new(:direction, :num_of_steps)

def parse(input)
  parser = MoveParser.new
  input.map do |code|
    parser.parse(code)
  end
end

def manhattan_distance(point)
  point.x.abs + point.y.abs
end

def lowest_manhattan_distance(moves_a, moves_b)
  path_one = Traverser.new(parse(moves_a)).traverse
  path_two = Traverser.new(parse(moves_b)).traverse

  (path_one & path_two)
      .map { |i| manhattan_distance(i) }
      .min { |a, b| a <=> b }
end

assert_equal(135, lowest_manhattan_distance(
    %w(R98 U47 R26 D63 R33 U87 L62 D20 R33 U53 R51),
    %w(U98 R91 D20 R16 D67 R40 U7 R15 U6 R7))
)

assert_equal(159, lowest_manhattan_distance(
    %w(R75 D30 R83 U83 L12 D49 R71 U7 L72),
    %w(U62 R66 U55 R34 D71 R55 D58 R83))
)

input = InputReader.new('input/day3').read
assert_equal(2180, lowest_manhattan_distance(input[0], input[1]))