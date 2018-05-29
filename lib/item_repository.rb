require_relative 'repo_methods'
require_relative 'item'
require 'bigdecimal'

class ItemRepository
  include RepoMethods
  attr_reader :collection

  def initialize(data_from_csv)
    @collection = get_data_from_csv(data_from_csv)
  end

  def get_data_from_csv(data_from_csv)
    data_from_csv.map do |line|
      [line[:id].to_i, Item.new(line)]
    end.to_h
  end

  def create(attributes)
    attributes[:id] = new_id
    @collection[new_id] = Item.new(attributes)
  end

  def find_all_by_price(price)
    all.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    all.find_all do |item|
      range.include?(item.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @collection.find_all do |item|
      item == merchant_id
    end
  end
end
