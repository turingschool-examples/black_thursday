require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'item'
require_relative 'merchant'
require "./lib/sales_engine"
require_relative 'sales_engine'
require 'pry'
class SalesAnalyst < SalesEngine

  def initialize(items_path, merchants_path)
    super
  end
  # binding.pry
  # def average_items_per_merchant
  #
  # end
end
