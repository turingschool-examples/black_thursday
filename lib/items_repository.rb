require_relative 'item'

class ItemsRepository
  attr_reader :items_csv,
              :all

  def initialize(items_csv)
    @items_csv = items_csv
    @all = []
  end

  def load_items(items_csv)
    items_csv.each do |item|
      @all << Item.new(item)
    end
  end

  def find_by_id(item_id)
    @all.find do |item|
      item.id.to_i == item_id
    end
  end
end
