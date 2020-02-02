class InputReader
  def initialize(path)
    @path = path
  end

  def read
    File.readlines(path).map { |line| line.split(",") }
  end

  private

  attr_reader :path
end
