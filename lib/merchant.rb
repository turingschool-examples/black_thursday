class Merchant

  attr_reader :id

  attr_accessor :name

  def initialize(input)
    @id = input[:id].to_i
    @name = input[:name]
  end

end
