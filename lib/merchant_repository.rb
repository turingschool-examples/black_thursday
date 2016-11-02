require_relative 'merchant'
require 'pry'

class MerchantRepository
  attr_reader  :all_merchants,
               :parent

  def initialize(merchant_data, parent = nil)
    @parent = parent
    @all_merchants = []
    add_merchant(merchant_data)
  end

  def add_merchant(merchant_data)
    @all_merchants << Merchant.new(merchant_data, self)
  end

  def inspect
  end

  def find_by_id(id_number)
    @all_merchants.find do |merchant|
      if merchant.id == id_number.to_i
        merchant.name
      else
        nil
      end
    end
  end 

  def find_by_name(merch_name)
    @all_merchants.find do |merchant|
      if merchant.name == merch_name
        merchant.id
      else
        nil
      end
    end
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


