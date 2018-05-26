class MerchantRepository
  def initialize
    @merchants = []

  end

  def all
    @merchants
  end

  def create(attributes)
    new_merchant = Merchant.new(attributes)
    @merchants << new_merchant
    new_merchant
  end

  def find_by_id(id)
    @merchants.detect do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @merchants.detect do |merchant|
      merchant.name == name
    end
  end


end
