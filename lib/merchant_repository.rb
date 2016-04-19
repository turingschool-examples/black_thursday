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
      m.downcase == name
    end
    find
  end
# find_by_name - returns either nil or an instance of Merchant having done a case insensitive search

  def find_all_by_name
  end

# find_all_by_name - returns either [] or one or more matches which contain the supplied name fragment, case insensitive

end
