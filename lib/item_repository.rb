require 'CSV'
require_relative 'item'

class ItemRepository
  attr_reader :file_path,
              :all_items

  def initialize(file_path)
    @file_path = file_path
    @all_items = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all_items << Item.new({:id => row[:id], :name => row[:name], :description => row[:description], :unit_price => row[:unit_price], :created_at => row[:created_at], :updated_at => row[:updated_at], :merchant_id => row[:merchant_id]})
    end
  end

  def find_by_id(item_id)
    @all.find { |item| item.id == item_id}
  end

  def find_by_name(item_name)
    @all.find {|item| item.name.downcase == item_name.downcase}
  end

  def find_all_with_description(item_description)
    @all.find_all do |item|
      item.description.downcase.include?(item_description.downcase)
    end
  end

  def find_all_by_price_in_range(range)
    min = range.min
    max = range.max

    @all_items.find_all do |item|
      item.unit_price.to_i.between?(min, max)
    end
  end
end
