require 'csv'
require_relative 'item'

class ItemRepository

  attr_reader :all

  def initialize(filepath)
    @filepath = filepath
    @all = []

    CSV.foreach(@filepath, headers: true, header_converters: :symbol) do |row|
      @all << Item.new({id: row[:id], name: row[:name], description: row[:description], unit_price: row[:unit_price], created_at: row[:created_at], updated_at: row[:updated_at], merchant_id: row[:merchant_id]})
    end
  end

  def find_by_id(id)
    @all.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @all.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    @all.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @all.find_all do |item|
      item.unit_price.to_i == price
    end
  end

  def find_all_by_price_in_range(range)
    @all.find_all do |item|
      range.include?(item.unit_price.to_i)
    end
  end

  def find_all_by_merchant_id(id)
    @all.find_all do |item|
      item.merchant_id == id
    end
  end

end
