require_relative 'item'
require_relative 'sales_engine'
class ItemRepository
  attr_reader:path,
             :parent
  def initialize(path, parent)
    @path = path
    @parent = parent
  end
end
