class Merchant

  attr_reader :id, :name

  def initialize(input)
    @id = input[:id]
    @name = input[:name]
  end

end
