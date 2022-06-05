require 'pry'
require 'CSV'
require_relative 'item'

class ItemRepository
  attr_reader :file_path,
              :all

  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Item.new({:id => row[:id], :name => row[:name], :description => row[:description], :unit_price => row[:unit_price], :created_at => row[:created_at], :updated_at => row[:updated_at], :merchant_id => row[:merchant_id]})
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

  def find_all_by_price(item_price)
    @all.find_all do |item|
      item.unit_price == item_price
    end
  end

  def find_all_by_price_in_range(range)
      min = range.min
      max = range.max
    @all.find_all do |item|
      item.unit_price.to_i.between?(min, max)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all {|item| merchant_id == item.merchant_id }
  end

  def create(name)
    id = (@all.last.id.to_i + 1)
    @all << Item.new({:id => id, :name => name})
  end

  def update(id, attributes)
    @all.each do |item|
      if item.id == id
        item.name = attributes
      end
    end
  end

  def delete(id)
    array = []
      @all.each do |item|
        if item.id != id
          array << item
        end
      @all = array
    end
  end
end
