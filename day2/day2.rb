require "test/unit"
require_relative "intcode"
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
  assert_equal([2,0,0,0,99], Intcode.new([1,0,0,0,99]).run)
end

def get_answer_a
  input = InputReader.new('input/day2').read
  input[1] = 12
  input[2] = 2
  Intcode.new(input).run[0]
end

run_basic_test
assert_equal 5866714, get_answer_a

