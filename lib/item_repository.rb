require 'csv'
require_relative '../lib/item'
require_relative '../lib/file_opener'

class ItemRepository
  include FileOpener
  attr_reader :all_item_data

  def initialize(data_files)
    all_items = open_csv(data_files[:items])
    @all_item_data = all_items.map{|row| Item.new(row)}
  end

  def all
    @all_item_data
  end

  def find_by_id(id)
    @all_item_data.find{|item| item.id == id.to_s}
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
    @all_item_data.find_all{|item| merchant_id == item.merchant_id.to_s }
  end

end
