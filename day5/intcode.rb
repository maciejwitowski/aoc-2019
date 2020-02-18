class IntcodePartTwo
  def initialize(input)
    @input = input
  end

  def run(options = {})
    reset(options)

    until next_instruction.halt?
      next_instruction.run(memory)
      go_to_next_address
    end

    memory
  end

  private

  attr_reader :memory, :address

  def reset(options = {})
    @memory = @input.dup
    @address = 0

    @memory[1] = options[:noun] if options[:noun]
    @memory[2] = options[:verb] if options[:verb]
  end

  def go_to_next_address
    @address += 4
  end

  def next_instruction
    opcode = memory[address]
    case opcode
    when 1
      Add.new(
          augend_index: memory[address + 1],
          addend_index: memory[address + 2],
          sum_index: memory[address + 3]
      )
    when 2
      Multiply.new(
          multiplicand_index: memory[address + 1],
          multiplier_index: memory[address + 2],
          product_index: memory[address + 3]
      )
    when 99
      Halt.new
    else
      raise "Unsupported opcode #{opcode}"
    end
  end

  class Instruction
    def halt?
      false
    end
  end

  class Add < Instruction
    def initialize(augend_index:, addend_index:, sum_index:)
      @augend_index = augend_index
      @addend_index = addend_index
      @sum_index = sum_index
    end

    def run(memory)
      memory[@sum_index] = memory[@augend_index] + memory[@addend_index]
    end
  end

  class Multiply < Instruction
    def initialize(multiplicand_index:, multiplier_index:, product_index:)
      @multiplicand_index = multiplicand_index
      @multiplier_index = multiplier_index
      @product_index = product_index
    end

    def run(memory)
      memory[@product_index] = memory[@multiplicand_index] * memory[@multiplier_index]
    end
  end

  class Halt < Instruction
    def halt?
      true
    end
  end
end