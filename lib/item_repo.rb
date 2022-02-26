require "pry"

class ItemRepository
  attr_reader :attributes
  def initialize(items_instances_array)
    @items_instances_array = items_instances_array
  end
end
