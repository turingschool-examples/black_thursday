class MerchantRepository
  def initialize
    @merchants = []

  end

  def all
    @merchants
  end

  def create(attributes)
    @merchants << Merchant.new(attributes)
  end
  
  def find_by_id(id)

  end
end
