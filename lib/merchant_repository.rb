#Lauren doing this one!

=begin
The MerchantRepository is responsible for holding and searching our Merchant instances. It offers the following methods:

all - returns an array of all known Merchant instances
find_by_id - returns either nil or an instance of Merchant with a matching ID
  -- for each instance, check the id. use .find?
find_by_name - returns either nil or an instance of Merchant having done a case insensitive search
find_all_by_name - returns either [] or one or more matches which contain the supplied name fragment, case insensitive
The data can be found in data/merchants.csv so the instance is created and used like this:
=end
require "csv"


class MerchantRepository

  attr_reader :all

  def initialize(FILENAME)
    @all = []

    CSV.foreach('./FILENAME.csv', headers: true, header_converters: :symbol) do |row|
      @all << Merchant.load_from_csv(row)
    end

  end

  def find_by_id
  end



end
