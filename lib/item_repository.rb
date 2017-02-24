require_relative 'item'

class ItemRepository
  attr_reader :item_data, :all

  def initialize(item_data)
    @item_data = item_data
    @all = item_data.map { |row| Item.new(row) }
    binding.pry
  end

end
