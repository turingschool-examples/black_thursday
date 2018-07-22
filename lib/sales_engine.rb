require 'csv'

class SalesEngine

  attr_reader :items,
              :merchants

  def self.from_csv(hash)
    @items = CSV.open(hash[:items], headers: true, header_converters: :symbol)
    @merchants = CSV.open(hash[:merchants], headers: true, header_converters: :symbol)
  end

  def items
    #get the CSV and create item instances
    #serve up those item instances
  end

  def merchants
    #get the CSV and create the merchant instances
    #serve up those merchant instances
  end

end
