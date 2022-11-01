class MerchantRepository
  attr_reader :all
  def initialize
    @all = []
  end

  def add_merchant(merchant_object)
    @all << merchant_object
  end
end
