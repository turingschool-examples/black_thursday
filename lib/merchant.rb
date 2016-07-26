class Merchant
  attr_reader :id,
              :name

  def initialize(merchant_details)
    @id   = merchant_details[:id]
    @name = merchant_details[:name]
  end
end
