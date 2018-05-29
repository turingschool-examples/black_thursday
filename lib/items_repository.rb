require_relative 'item'
require 'bigdecimal'

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

  def find_all_by_price_in_range(range)
    @all.find_all do |item|
      range.include?(item.unit_price.to_i)
    end
  end

  def find_all_by_merchant_id(id)
    @all.find_all do |item|
      item.merchant_id == id.to_s
    end
  end

  def create(attributes)
    attributes[:id] = @all.map do |item|
                        item.id.to_i
                      end.max + 1
    attributes[:unit_price] = (attributes[:unit_price].to_f * 100).to_i
    item = Item.new(attributes)
    @all.push(item)
  end

  def update(id, attributes)
    @all.each do |item|
      if item.id.to_i == id
        item.update_name(attributes[:name])
        item.update_description(attributes[:description])
        item.update_unit_price((attributes[:unit_price].to_f * 100).to_i)
      end
    end
  end

  def delete(id)
    @all.each do |item|
      if item.id.to_i == id
        @all.delete(item)
      end
    end
  end
end
