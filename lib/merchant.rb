class Merchant
  attr_reader :id,
              :name

  def initialize(merchant_data)
  @id = merchant_data[:id]
  @name = merchant_data[:name]
  end

  # def items
  #   self.id
  # end
end
