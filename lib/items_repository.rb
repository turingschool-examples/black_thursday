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

  def find_by_name(item_name)
    @all.find do |item|
      item.name.downcase == item_name.downcase
    end
  end

  def find_all_with_description(desc)
    @all.find_all do |item|
      item.description.downcase.include?(desc.downcase)
    end
  end

  def find_all_by_price(value)
    @all.find_all do |item|
      item.unit_price == value.to_s
    end
  end
end
