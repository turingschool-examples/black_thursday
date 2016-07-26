class Merchant
  attr_reader :id,
              :name

  def initialize(merchant_details)
    @id   = merchant_details[:id].to_i
    @name = merchant_details[:name]
  end
end
