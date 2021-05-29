require 'csv'

class SalesEngine
  attr_reader :library

  def initialize
    @library = Hash.new
    @library[:items] = "./data/items.csv"
    @library[:merchants] = "./data/merchants.csv"
  end

  def items
    #access value from library hash to get filepath
    #open csv file
    #call ItemRepository.new(file_path - value from library hash)
    #return items
  end

  def merchants
    mr = MerchantRepository.new(@library[:merchants])
    mr.read_csv
  end

end
