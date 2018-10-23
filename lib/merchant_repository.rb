class MerchantRepository

  def initialize
    @merchants = []
  end

  def add_merchant(merchant)
    @merchants << merchant
  end

  def all
    @merchants
  end

  # def inspect
  # "#<#{self.class} #{@merchants.size} rows>"
  # end

end
