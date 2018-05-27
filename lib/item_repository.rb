require './lib/item.rb'

class ItemRepository
  attr_reader :items, :repository

  def initialize(file_contents)
    @items = file_contents
    @repository = make_repository
  end

  def make_repository
    @items.map do |item|
      Item.new(item)
    end
  end

end
