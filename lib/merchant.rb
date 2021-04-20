class Merchant
  attr_accessor :id,
                :name

  def initialize(merchant_info)
    @id = merchant_info[:id].to_i
    @name = merchant_info[:name]
  end

  def update_name(attributes)
    @name = attributes[:name]
  end
end
