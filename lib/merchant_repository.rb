require 'pry'
require './lib/merchant'

class MerchantRepository

  def all
    # all - returns an array of all known Merchant instances
  end

  def find_by_id(id)
    # find_by_id - returns either nil or an instance of Merchant with a matching ID
  end

  def find_by_name(name)
    # find_by_name - returns either nil or an instance of Merchant having done a case insensitive search
  end

  def find_all_by_name(name)
    # find_all_by_name - returns either [] or one or more matches which contain the supplied name fragment, case insensitive
  end

  def add_data(data)

  end


end
