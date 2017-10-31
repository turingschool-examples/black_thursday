# require 'csv'
require './lib/item'

class ItemRepository

  attr_reader :items, :parent

  def initialize(parent)
    @items = []
    @parent = parent
  end
  # attr_reader :parent, :load_repo
  #
  # def initialize(filename, parent)
  #   @parent = parent
  #   @load_repo = load_repo
  # end
  def count
    items.count
  end

  def create_item(data)
    items << Item.new(data, self)
  end

  def merchant(id)
    parent.merchant(id)
  end


end
