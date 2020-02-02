class MoveParser
  def parse(code)
    Move.new(direction(code), num_of_steps(code))
  end

  private

  def num_of_steps(code)
    code[1..-1].to_i
  end

  def direction(code)
    case code[0]
    when "U"
      :up
    when "D"
      :down
    when "L"
      :left
    when "R"
      :right
    else
      raise "Unsupported code #{code}"
    end
  end
end
