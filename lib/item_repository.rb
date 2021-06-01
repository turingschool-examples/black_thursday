require './lib/item'
require 'CSV'

class ItemRepository
  attr_reader :path,
              :engine

  def initialize(path, engine)
    @all = create_items(path)
    @engine = engine
  end

  def create_items(path)
    items = CSV.load("item_fixture.csv")
    items.map do |item_data|
      Item.new(item_data, self)
    end
  end
end
