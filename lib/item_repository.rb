require './lib/item'
require 'CSV'

class ItemRepository
  attr_reader :path,
              :engine

  def initialize(path, engine)
    @path = path
    @engine = engine
  end

  # def create_items(path)
  #   items = CSV.read("./data/items.csv")
  #   items.map do |item_data|
  #     Item.new(item_data, self)
  #   end
  # end
end
