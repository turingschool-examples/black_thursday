require_relative 'merchant'
require_relative 'item_repository'

class MerchantRepository
  attr_reader :merchants

  def initialize(merchants_data)
    @merchants = create_merchants(merchants_data)
  end

  def create_merchants(merchants_data)
    merchants_data.map { |name_id| Merchant.new(name_id) }
  end

  def all
    merchants
  end

  def find_by_id(id)
    merchants.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    merchants.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(name_fragment = "")
    merchants.find_all { |m| m.name.downcase.include?(name_fragment.downcase) }
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
