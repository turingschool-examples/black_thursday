require './lib/merchant_repository'
require 'pry'

class Merchant
  attr_reader  :merchant

  def initialize(merchant_data, parent = nil)
    @parent = parent
    @name = merchant_data[:name]
    @id = merchant_data[:id]
  end

  # def id
  #   @line[:id]
  # end

  # def name
  #   @line[:name]
  # end

  def items
    parent.find_all_items_by_merchant(self)
  end
end
