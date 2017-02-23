class MerchantRepository
  attr_reader :merchant_contents
  
  def initialize(merchant_contents)
    @merchant_contents = merchant_contents
  end
end
