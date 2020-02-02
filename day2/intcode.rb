class Intcode
  def initialize(input)
    @input = input
  end

  def run
    prepare

    until operation.halt?
      operation.perform(memory, address)
      advance
    end

    memory
  end

  private

  def prepare
    @memory = @input.dup
    @address = 0
  end

  def advance
    @address += 4
  end

  def operation
    opcode = memory[address]
    case opcode
    when 1
      Add
    when 2
      Multiply
    when 99
      Halt
    else
      raise "Unsupported opcode #{opcode}"
    end
  end

  private

  attr_reader :memory, :address
end

class Operation
  def self.halt?
    false
  end
end

class Add < Operation
  def self.perform(state, position)
    augend = state[state[position + 1]]
    addend = state[state[position + 2]]
    sum_index = state[position + 3]
    state[sum_index] = augend + addend
  end
end

class Multiply < Operation
  def self.perform(state, position)
    multiplicand = state[state[position + 1]]
    multiplier = state[state[position + 2]]
    product_index = state[position + 3]
    state[product_index] = multiplicand * multiplier
  end
end

class Halt < Operation
  def self.halt?
    true
  end
end
