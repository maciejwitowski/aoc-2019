require "test/unit"
include Test::Unit::Assertions

class SecureContainer
  def initialize(validator)
    @validator = validator
  end

  def find(start, ending)
    matches = []

    current = start
    while current < ending
      if @validator.valid?(current)
        matches << current
      end

      current = generate_next(current)
    end

    matches
  end

  def generate_next(number)
    current = array_from(number)
    i = 1

    # Go from the beginning to the end bumping numbers which are not in non-decreasing order
    while i < current.size
      if current[i] < current[i - 1]
        current[i] = current[i - 1]
      end
      i += 1
    end

    # If anything was changed in 1st loop, this is the next number
    return num_from(current) if num_from(current) != number

    # If this loop is reached it means the number ends with one or more 9s
    i -= 1
    while i >= 0
      # Find first number < 9 and change all subsequent numbers to its value
      if current[i] < 9
        new_value = current[i] + 1
        current[i] = new_value
        i += 1
        while i < current.size
          current[i] = new_value
          i += 1
        end
        break
      end

      i -= 1
    end

    num_from(current)
  end
end

class AdjacentValidator
  def valid?(number)
    digits = array_from(number)
    current = digits[0]
    digits[1..-1].each do |n|
      if n == current
        return true
      end
      current = n
    end
    false
  end
end

class AdjacentValidatorPartTwo
  REQUIRED_GROUP_SIZE = 2

  def valid?(number)
    digits = array_from(number)
    counter = 1
    current = digits[0]
    digits[1..-1].each do |n|
      if n == current
        counter += 1
      elsif counter == REQUIRED_GROUP_SIZE
        return true
      else
        counter = 1
      end

      current = n
    end

    counter == REQUIRED_GROUP_SIZE
  end
end

def array_from(n)
  n.to_s.chars.map(&:to_i)
end

def num_from(a)
  a.join.to_i
end

result = SecureContainer.new(AdjacentValidator.new).find(359282, 820401)
assert_equal(result.size, 511)

validator_two = AdjacentValidatorPartTwo.new
assert_equal(validator_two.valid?(123444), false)
assert_equal(validator_two.valid?(112233), true)
assert_equal(validator_two.valid?(111122), true )
assert_equal(validator_two.valid?(366677), true )
assert_equal(validator_two.valid?(367777), false)
assert_equal(validator_two.valid?(667779), true)
assert_equal(validator_two.valid?(778888), true)

result_two = SecureContainer.new(validator_two).find(359282, 820401)
assert_equal(result_two.size, 316)
