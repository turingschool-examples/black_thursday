require_relative 'merchant.rb'
require_relative 'sales_engine.rb'
require_relative 'item_repository.rb'

class MerchantRepository
  attr_reader :merchants, :id, :name

  def initialize(merchants_data)
    @merchants = create_merchants(merchants_data)
  end

  def create_merchants(merchants_data)
    merchants = merchants_data.map do |name_id|
    Merchant.new(name_id)
    end
  end

  def all
    merchants
  end

  def find_by_id(id)
    find = merchants.find {|m| m.id == id}
  end

  def find_by_name(name)
    find = merchants.find do |m|
      m.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name_fragment="")
    find = merchants.find_all {|m| m.name.downcase.include?(name_fragment.downcase)}
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
