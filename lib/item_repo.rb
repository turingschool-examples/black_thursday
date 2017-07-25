require_relative 'item'
require 'csv'
require 'pry'

class ItemRepository
  attr_reader :items, :engine
  # :grouped_by_merchant_id

  def initialize(csv_data, engine)
    @engine                 = engine
    @items                  = csv_data
    # @grouped_by_merchant_id = @items.group_by(:merchant_id)
  end


  def all
    items
  end

  def find_by_id(id)
    items.detect { |item| item.id == id }
  end

  def find_by_name(name)
    items.detect { |item| item.name.downcase == name.downcase }
  end

  def find_all_with_description(description)
    items.select { |item| item.description.downcase == description.downcase }
  end

  def find_all_by_price(price)
    items.select { |item| item.unit_price == price } || []
  end

  def find_all_by_price_in_range(range)
    items.select { |item| range.include?(item.unit_price) } || []
  end

  def find_all_by_merchant_id(merchant_id)
    grouped_by_merchant_id[merchant_id] || []
  end

end
