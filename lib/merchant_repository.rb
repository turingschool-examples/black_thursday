require './lib/merchant.rb'
require './lib/sales_engine.rb'

class MerchantRepository
  attr_accessor :merchants

  def initialize(merchants_data)
    @merchants = create_merchants(merchants_data)
  end

  def create_merchants(merchants_data)
    merchants = merchants_data.map do |name_id|
    Merchant.new(name_id)
    end
  p  merchants
  end

   def all
     merchants
   end

   def find_by_id(id)
    @id = id
    find = merchants.find do |m|
      m.id == id
    end
    find
   end

  def find_by_name
    @name = name
    find = merchants.find do |m|
      m.downcase == name.downcase
    end
    find
  end

  def find_all_by_name
    @name = name
    find = merchants.find do |m|
      m.downcase == name.downcase
    end
    find
  end


end
