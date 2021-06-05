require 'csv'
require_relative 'item'

class ItemRepository
  attr_reader :all

  def initialize(path)
    @all = []
    create_items(path)
  end

  # :nocov:
  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
  # :nocov:

  def create_items(path)
    CSV.foreach(path, headers: true, header_converters: :symbol).each do |item|
      @all << Item.new(item, self)
    end
  end

  def find_by_id(id)
    @all.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @all.find do |item|
      item.name.upcase == name.upcase
    end
  end

  def find_all_with_description(description)
    @all.find_all do |item|
      item.description.upcase == description.upcase
    end
  end

  def find_all_by_price(price)
    @all.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    temp = @all.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def new_item_id_number
    item = @all.max_by { |item| item.id }
    item.id + 1
  end

  def create(attributes)
    @all << Item.create_item(attributes, self)
  end

  def update(id, attributes)
    unless find_by_id(id).nil?
      find_by_id(id).update_item(attributes)
    end
  end

  def delete(id)
    @all.delete(find_by_id(id))
  end
end
