#merchant_repository
class MerchantRepository
  attr_reader :merchants

  def initialize(merchants)
    @merchants = merchants
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find {|merchant| merchant.id == id }
  end

  def find_by_name(name)
    @merchants.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(fragment)
    @merchants.find_all { |merchant| merchant.name.downcase.include?(fragment)}
  end
end
