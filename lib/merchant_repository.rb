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
  end

   def all
     merchants
   end

  # def find_by_id(id)
  # end

end



# The MerchantRepository is responsible for holding and searching our Merchant instances. It offers the following methods:
#
# all - returns an array of all known Merchant instances
# find_by_id - returns either nil or an instance of Merchant with a matching ID
# find_by_name - returns either nil or an instance of Merchant having done a case insensitive search
# find_all_by_name - returns either [] or one or more matches which contain the supplied name fragment, case insensitive
# The data can be found in data/merchants.csv so the instance is created and used like this:
#
# se = SalesEngine.from_csv({
#   :items     => "./data/items.csv",
#   :merchants => "./data/merchants.csv",
# })
#
# mr = se.merchants
# merchant = mr.find_by_name("CJsDecor")
# # => <Merchant>
