class Merchant
  attr_reader :id, :created_at
  attr_accessor :name, :updated_at

  def initialize(input)
    @id = input[:id].to_i
    @name = input[:name]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
  end
end
