class Merchant
  attr_reader :merchant_attributes

  def initialize(attributes)
    @merchant_attributes = attributes
    @merchant_attributes[:id] = merchant_attributes[:id].to_i
    @merchant_attributes[:name] = merchant_attributes[:name].downcase
  end
end
