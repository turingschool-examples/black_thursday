require 'csv'
#require './item'

class ItemRepository
  attr_reader :all

  def initialize(path)
    @all = create_items(path)
  end

  def create_items(path)
    items = CSV.foreach(path, headers: true, header_converters: :symbol)
    items.map do |item|
      Item.new(item, self)
    end
  end

  def find_by_id(id)
    if @all.one? { |item| item.id == id } == true
      @all.find { |item| item.id == id }
    else
      nil
    end
  end

  def find_by_name(name)
    if @all.one? { |item| item.name.upcase == name.upcase } == true
      @all.find { |item| item.name.upcase == name.upcase }
    else
      nil
    end
  end

  def find_all_with_description(description)
    @all.find_all { |item| item.description == description }
  end

  def find_all_by_price(price)
    @all.find_all { |item| item.price == price }
  end

  def find_all_by_price_in_range(range)
    @all.find_all { |item| range.include?(item.price) }
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all { |item| item.merchant_id == merchant_id }
  end
end
