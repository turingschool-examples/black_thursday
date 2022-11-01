class Merchant
  attr_reader :name,
              :id
  def initialize(merchant_details)
    @id = merchant_details[:id]
    @name = merchant_details[:name]
  end
end
