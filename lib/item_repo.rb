require 'pry'

require_relative 'item'
require_relative 'create_elements'

class ItemRepo
  attr_reader :items, 
              :parent

  include CreateElements

  def initialize(data, parent)
    @items = create_elements(data).reduce(Hash.new(0)) do |item_collection, item|
      item_collection[item[:id].to_i] = Item.new(item, self)
      item_collection
    end
    @parent = parent
  end

  def all
    items.values
  end

  def find_by_id

  end

  def find_by_name

  end

  def find_all_with_description

  end

  def find_all_by_price

  end

  def find_all_by_price_in_range

  end

  def find_all_by_merchant_id

  end

end
