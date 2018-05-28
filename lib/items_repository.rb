require_relative 'item'

class ItemsRepository
  attr_reader :items_csv,
              :items

  def initialize(items_csv)
    @items_csv = items_csv
    @items = []
  end

  def load_items(items_csv)
    items_csv.each do |item|
      @items << Item.new(item)
    end
  end
  
end
