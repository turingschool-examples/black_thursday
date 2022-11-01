class MerchantRepository

  def initialize(merchants)
    @merchants = merchants
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find { |merchant| merchant.id == id}
  end

  def find_by_name(name)
    @merchants.find { |merchant| merchant.name.upcase == name.upcase}
  end

  def find_all_by_name(name)
    @merchants.find_all { |merchant| merchant.name.upcase == name.upcase}
  end

  def create(attributes)
    ids = @merchants.map { |merchant| merchant.id}
    attributes[:id] = ids.max + 1
    new_merchant = Merchant.new(attributes)
    @merchants.push(new_merchant)
    new_merchant
  end
end
