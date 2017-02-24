require_relative 'merchant_repository'
require_relative 'sales_engine'
require_relative 'item_repository'
require_relative 'item'
require_relative 'csv_parser'
require_relative 'merchant'
require 'pry'


class Merchant
  attr_reader :id,
              :name,
              :parent

  def initialize(data, parent)
    @id = data[:id].to_i
    @name = data[:name]
    @parent = parent
  end

  def items
    parent.find_items(id)
  end

end