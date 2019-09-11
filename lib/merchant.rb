class Merchant
  attr_accessor :name
  attr_reader   :id

  def initialize(merchant_attributes)
    @id = merchant_attributes[:id].to_i
    @name = merchant_attributes[:name]
  end
end
