#Lauren doing this one!

=begin
The MerchantRepository is responsible for holding and searching our Merchant instances. It offers the following methods:

all - returns an array of all known Merchant instances
find_by_id - returns either nil or an instance of Merchant with a matching ID
find_by_name - returns either nil or an instance of Merchant having done a case insensitive search
find_all_by_name - returns either [] or one or more matches which contain the supplied name fragment, case insensitive
The data can be found in data/merchants.csv so the instance is created and used like this:
=end

class MerchantRepository

  def initialize(merchant_repository)
    all = []
  end


  def all
    [] << Merchant
  end




end
