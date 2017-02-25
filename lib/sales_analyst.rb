require_relative 'merchant'
require_relative 'sales_engine'
require_relative 'item_repository'
require_relative 'item'
require_relative 'csv_parser'
require 'pry'

class SalesAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

end