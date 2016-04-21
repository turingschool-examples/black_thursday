require_relative 'merchant'
require_relative 'item_repository'

class MerchantRepository
  attr_reader :merchants, :id, :name

  def initialize(merchants_data)
    @merchants = create_merchants(merchants_data)
  end

  def create_merchants(merchants_data)
    merchants_data.map do |name_id|
      Merchant.new(name_id)
    end
  end

  def all
    merchants
  end

  def find_by_id(id)
    merchants.find {|m| m.id == id}
  end

  def find_by_name(name)
    merchants.find do |m|
      m.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name_fragment="")
    merchants.find_all {|m| m.name.downcase.include?(name_fragment.downcase)}
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
