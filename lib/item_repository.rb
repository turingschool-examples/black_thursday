require 'csv'
require_relative 'item'
require_relative 'sales_module'

class ItemRepository
  attr_reader :all
  def initialize(csv)
    @all = Item.read_file(csv)
  end

  include SalesModule

end
