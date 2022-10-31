class MerchantRepository
  attr_reader :merchants
  def initialize
    @merchants = []
  end

  def add(merchant)
    @merchants << merchant
  end
end