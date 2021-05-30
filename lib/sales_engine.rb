require 'csv'

class SalesEngine
  attr_reader :library

  def initialize
    @library = Hash.new
    @library[:items] = "./data/items.csv"
    @library[:merchants] = "./data/merchants.csv"
  end

  def items
    ir = ItemRepository.new(@library[:items])
    ir.all
  end

  def merchants
    mr = MerchantRepository.new(@library[:merchants])
    mr.all
  end

end
