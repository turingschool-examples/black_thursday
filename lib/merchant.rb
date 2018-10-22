class Merchant
  attr_reader :id, :name
  def initialize(input_hash)
    @id = input_hash[:id]
    @name = input_hash[:name]
  end
end
