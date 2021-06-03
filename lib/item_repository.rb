require 'CSV'
require 'bigdecimal'
require_relative 'item'

class ItemRepository
  attr_reader :file_path, :all, :items, :id

  def initialize(file_path, engine)
    @file_path = file_path
    @engine = engine
  end

  def create_repo
    @items = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      item = Item.new(row, self)
      @items << item
    end
    self
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def all
    items
  end

  def find_by_id(id)
    items.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    items.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    items.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    items.find_all do |item|
      item.unit_price == price
      #require "pry"; binding.pry
    end
  end

  def find_all_by_price_in_range(range)
  end

  def find_all_by_merchant_id(merchant_id)
  end

  def create(attributes)
  end

  def update(id, attributes)
  end

  def delete(id)
  end
end
