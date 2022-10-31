class MerchantRepository

  def initialize(merchants)
    @merchants = merchants
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find {|merchant| merchant.id == id}
  end

  def find_by_name(name)
    @merchants.find {|merchant| merchant.name.upcase == name.upcase}
  end
end
