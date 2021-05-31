class MerchantRepository
  attr_reader :merchants

  def initialize(merchants)
    @merchants = merchants
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def create(attribute)
    new_id = @merchants.max_by do |merchant|
      merchant.id
    end
    merchant = Merchant.new({:id => new_id.id + 1, :name => attribute})
    @merchants << merchant
    merchant
  end
end
