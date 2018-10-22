class MerchantRepository

  def initialize
    @merchants = []
  end

  def all
    @merchants
  end

  def add_merchant(merchant)
    @merchants << merchant
  end

end
