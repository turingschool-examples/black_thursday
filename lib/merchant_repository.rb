require_relative './repository'

class MerchantRepository < Repository

  def initialize
    @merchants = []
    @collection = @merchants
  end

  def add_merchant(merchant)
    @merchants << merchant
  end

  def merchants
    @merchants
  end

  def create(name)
    add_merchant(Merchant.new({id: find_new_id, name: name}))
  end

  # find all by name - Maddie

end
