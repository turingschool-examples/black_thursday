require_relative './data_repository'
require_relative './item'

class ItemRepository < DataRepository
  def initialize(data)
    populate(data, Item)
  end

  def items
    return @data_set.values
  end
end
