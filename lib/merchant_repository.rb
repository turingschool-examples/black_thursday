class MerchantRepository
  attr_reader :merchants
  def initialize
    @merchants = []
  end

  def create(attributes)
    @merchants << Merchant.new(attributes)
  end
end
