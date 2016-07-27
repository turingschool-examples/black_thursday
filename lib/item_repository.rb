require_relative '../lib/item'
require 'pry'

class ItemRepository
  attr_reader :items

  def initialize
    @items = {}
  end

  def format_item_info(item)

    { :id          => item[:id],
      :name        => item[:name],
      :description => item[:description],
      :unit_price  => item[:unit_price],
      :created_at  => item[:created_at],
      :updated_at  => item[:updated_at],
      :merchant_id => item[:merchant_id] }
  end

  def populate(items)
    items.each do |item|
      item_formatted = format_item_info(item)
      @items[item[:id]] = Item.new(item_formatted)
    end
  end

  def all
    items.values
  end

  def find_by_id(item_id)
    items[item_id]
  end

  def find_by_name(item_name)
    items.values.find do |item|
      item.name.downcase == item_name.downcase
      # binding.pry
    end
  end

  def find_all_with_description(description_fragment)
    items.values.find_all do |item|
      # binding.pry
      item.description.downcase.include?(description_fragment.downcase)
    end
  end


end
