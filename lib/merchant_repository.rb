require './lib/repository'

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
    max_id = find_max_id
    add_merchant(Merchant.new({id: max_id, name: name}))
  end

  # find all by name

end
