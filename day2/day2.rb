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

assert_equal [2,0,0,0,99], Intcode.new([1,0,0,0,99]).run
input = InputReader.new('input/day2').read