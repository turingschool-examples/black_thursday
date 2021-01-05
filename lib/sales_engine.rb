require "csv"
require "pry"

class SalesEngine
  attr_reader :items_path,
              :merchants_path

  def initialize(sales_data)
    @items_path = sales_data[:items]
    @merchants_path = sales_data[:merchants]
  end

  def self.from_csv(sales_data)
    SalesEngine.new(sales_data)
  end 

  def items
    ItemRepository.new(@items_path)    
    binding.pry
  end

  def merchants
    MerchantRepository.new(@merchants_path)
  end


end


