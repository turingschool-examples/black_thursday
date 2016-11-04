require_relative 'merchant'
require 'pry'

class MerchantRepository
  attr_reader   :all,
                :parent,
                :all

  def initialize(merchants_data, parent = nil)
    @parent = parent
    @all = []
    populate(merchants_data)
  end

  def populate(merchants_data)
    merchants_data.each do |merchant|
      @all << Merchant.new(merchant, self)
    end
  end

  def find_by_id(id_number)
    @all.find do |merchant|
      if merchant.id == id_number.to_i
        merchant.name
      else
        nil
      end
    end
  end

  def find_by_name(merch_name)
    @all.find do |merchant|
      if merchant.name.downcase == merch_name.downcase
        merchant.id
      else
        nil
      end
    end
  end

  def find_all_by_name(fragment)
    @all.find_all do |merchant|
      merchant.name.downcase.include?(fragment.downcase)
    end
  end

  def find_all_items_by_merchant(merchant_id)
    parent.find_all_items_by_merchant_id(merchant_id)
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end
end


