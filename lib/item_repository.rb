require 'csv'
require './lib/item'

class ItemRepository

  attr_reader :all_item_data

  def initialize
    @all_item_data = CSV.open("./data/items.csv",
    headers: true, header_converters: :symbol).map do |row|
      Item.new(row)
    end
  end

  def all
    @all_item_data
  end

  def find_by_id(id)
    @all_item_data.find{|item| item.id == id}
  end

  def find_by_name(name)
    @all_item_data.find{|item| item.name == name}
  end

  def find_all_with_description(description)
    @all_item_data.find_all{|item| /#{description}/i =~ item.description}
  end

  def find_all_by_price(unit_price)
    @all_item_data.find_all{|item| item.unit_price == unit_price }
  end

  def find_all_by_price_in_range(price_range)
    @all_item_data.find_all{|item| price_range === item.unit_price }
  end

  def find_all_by_merchant_id(merchant_id)
    @all_item_data.find_all{|item| merchant_id == item.merchant_id }
  end

end
