require './lib/merchant'
require 'pry'

class MerchantRepository
  attr_reader  :all_merchants

  def initialize(merchant_data, parent = nil)
    @parent = parent
    @all_merchants = []
    add_merchant(merchant_data)
  end

  def add_merchant(merchant_data)
    merchant_data.each do |row|
    require 'pry'; binding.pry
      @all_merchants << Merchant.new(row, self)
    end
  end
  def find_by_id(id)
    @all_merchants.find { |merchant| merchant.id.to_i == id.to_i }
  end 

  def find_by_name(name)
   @all_merchants.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(fragment)
    @all_merchants.find_all do |merchant|
      merchant.name.downcase.include?(fragment.downcase)
    end
  end

  def find_all_items_by_merchant(merchant)
    parent.find_all_items_by_merchant_id(merchant["id"])
  end

end


