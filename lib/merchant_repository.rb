require './lib/SalesEngine'
require './lib/merchant'

class MerchantRepository

  def initialize(se)
    # se = SalesEngine.from_csv({
    #   :items     => "./data/items.csv",
    #   :merchants => "./data/merchants.csv",})
    #
    # mr = se.merchants
    # merchant = mr.find_by_name("CJsDecor")
    #   # => <Merchant>
  end

  def all
    # returns an array of all known Merchant instances
  end

  def find_by_id
    # returns either nil or an instance of Merchant with a matching ID
  end

  def find_by_name
    # returns either nil or an instance of Merchant having done a case insensitive search
  end

  def find_all_by_name
    # returns either [] or one or more matches which contain the supplied name fragment, case insensitive
  end
end
