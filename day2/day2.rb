require "test/unit"
require_relative "intcode"
require_relative "intcode_part_two"
include Test::Unit::Assertions

class InputReader
  def initialize(path)
    @path = path
  end

  def read
    File.read(path).split(",").map(&:to_i)
  end

  private

  attr_reader :path
end

def run_basic_test
  assert_equal([2, 0, 0, 0, 99], Intcode.new([1, 0, 0, 0, 99]).run)
  assert_equal([2, 0, 0, 0, 99], IntcodePartTwo.new([1, 0, 0, 0, 99]).run)
end

def get_answer(intcode, noun, verb)
  intcode.run({noun: noun, verb: verb})[0]
end

def part_one_answer(input)
  input[1] = 12
  input[2] = 2
  Intcode.new(input).run[0]
end

def part_two_answer(input)
  intcode = IntcodePartTwo.new(input)

  (0..99).each do |noun|
    (0..99).each do |verb|
      answer = get_answer(intcode, noun, verb)
      if answer == 19690720
        return 100 * noun + verb
      end
    end
  end
end

run_basic_test

input = InputReader.new('input/day2').read
assert_equal 5866714, part_one_answer(input)
assert_equal 5208, part_two_answer(input)
