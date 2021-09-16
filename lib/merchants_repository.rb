class MerchantsRepository
  attr_reader :merchant_array

  def initialize(merchant_array)
    @merchant_array = merchant_array
  end
end
