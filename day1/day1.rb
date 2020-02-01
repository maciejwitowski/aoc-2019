require "test/unit"
include Test::Unit::Assertions

class FuelCounterUpper
  def initialize(masses)
    @masses = masses
  end

  def count
    masses.map { |mass| module_fuel(mass) }.inject(:+)
  end

  private

  attr_reader :masses

  def module_fuel(mass)
    sum = 0
    while mass > 0 do
      mass = (mass / 3) - 2
      sum += mass if mass > 0
    end
    sum
  end
end

input = File.readlines('input/day1').map(&:to_i)
result = FuelCounterUpper.new(input).count
assert_equal 4837367, result