require 'csv'
require_relative 'item'
require_relative 'csv_loader'
require_relative 'search'


class ItemRepository
  include CsvLoader
  include Search

  attr_reader :items

  def initialize(csv_file_path, engine)
    @items = create_items(csv_file_path, engine)
    @engine = engine
    return self
  end

  def create_items(csv_file_path, engine)
    create_instances(csv_file_path, 'Item', engine)
  end

  def all
    @items
  end

  def find_by_id(id_number)
    find_instance_by_id(@items, id_number)
  end

  def find_by_name(search_name)
    find_instance_by_name(@items, search_name)
  end

  def find_all_with_description(search_term)
    @items.find_all do |item|
      item.description.include?(search_term)
    end
  end

  def find_all_by_price(search_price)
    search_price = search_price.to_i
    @items.find_all do |item|
      item.unit_price == search_price
    end
  end

  def find_all_by_price_in_range(search_price_range)
    @items.find_all do |item|
      search_price_range.cover?(item.unit_price)
    end

  end

  def find_all_by_merchant_id(search_merchant_id)
    find_all_instances_by_merchant_id(@items, search_merchant_id)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

end
