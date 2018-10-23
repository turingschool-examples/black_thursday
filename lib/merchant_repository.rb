require './lib/repository'

class MerchantRepository < Repository

  def initialize
    @merchants = []
  end

  def add_merchant(merchant)
    @merchants << merchant
  end

  def all
    @merchants
  end

end
