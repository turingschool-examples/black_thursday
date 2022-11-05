require_relative './sales_engine'
require_relative './merchant_repo'
require_relative './merchant'
require_relative './item_repo'
require_relative './item'

class SalesAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
    # require 'pry'; binding.pry
  end
# require 'pry'; binding.pry
  # def average_items_per_merchant
  #   @sales_engine.each do |sales_engine|
  #     require "pry"; binding.pry
  #   end
  #
  #   # how many merchants are in list
  #
  #   # divide by how many differnt merchants are in lists
  # end
end
