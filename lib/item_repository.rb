require_relative 'item'
require 'csv'
require 'BigDecimal'
require_relative 'inspector'

class ItemRepository
  include Inspector
  attr_reader :all
  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Item.new(row)
    end
  end

  # def find_by_id(id)
  #   @all.find do |item|
  #     item.id ==  id
  #   end
  # end

  def find_by_name(name)
    @all.find do |item|
      item.name.upcase == name.upcase
    end
  end

  def find_all_with_description(description)
    @all.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @all.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_with_price(price)
    items = []
    @all.each do |item|
      if item.unit_price == BigDecimal(price)/100
        items << item
      end
    end
    items
  end

  def find_all_by_price_in_range(range)
    items = []
    @all.each do |item|
      if range.include?(item.unit_price)
        items << item
      end
    end
    items
  end

  def find_all_by_merchant_id(merchant_id)
    items = []
    @all.each do |item|
      if item.merchant_id == merchant_id
        items << item
      end
    end
    items
  end

  def assign_attributes(item, attributes)
    item.name = attributes[:name] unless attributes[:name].nil?
    item.description = attributes[:description] unless attributes[:description].nil?
    item.unit_price = attributes[:unit_price] unless attributes[:unit_price].nil?
    item.updated_at = Time.now
    item
  end

  def update (id, attributes)
    @all.each do |item|
      if item.id == id
        assign_attributes(item, attributes)
      end
    end
  end
end
