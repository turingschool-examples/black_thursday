class Merchant
  attr_reader :merchant_attributes

  def initialize(attributes)
    merchant_attributes = {}
    merchant_attributes[:id] = attributes[:id].to_i
    merchant_attributes[:name] = attributes[:name]
    merchant_attributes[:created_at] = attributes[:created_at]
    merchant_attributes[:updated_at] = attributes[:updated_at]
    @merchant_attributes = merchant_attributes

    # @id = attributes[:id]
    # @name = attributes[:name]
    # @created_at = attributes[:created_at]
    # @updated_at = attributes[:updated_at]
  end
end
