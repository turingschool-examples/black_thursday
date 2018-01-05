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
    parent.call_sales_engine_items(id)
  end

end
