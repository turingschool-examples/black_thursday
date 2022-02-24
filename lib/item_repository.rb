require 'CSV'
require 'pry'
require_relative '../lib/sales_engine.rb'
require_relative '../lib/findable.rb'

class ItemRepository < SalesEngine
  include Findable
  attr_reader :all

  def initialize array
    @all = array
  end

  def self.from_csv (path_string)
    csv_array = CSV.read(path_string, headers: true, header_converters: :symbol)
    item_object_array = []
    csv_array.each do |line|
      item = Item.new({ id: line[:id], name: line[:name], description: line[:description], merchant_id: line[:merchant_id], created_at: line[:created_at], updated_at: line[:updated_at] })
      item_object_array << item
    end
    self.new(item_object_array)
  end

  def find_all_with_description (descriptive_string)
    @all.find_all {|item| item.description.downcase.include?(descriptive_string.downcase)}
  end

  def find_all_by_price (desired_price)
    @all.find_all {|item| item.unit_price == desired_price}
  end

  def find_all_by_price_in_range(price_range_object)
    @all.find_all {|item| price_range_object.member?(item.unit_price)}
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all {|item| item.merchant_id == merchant_id}
  end

  def create(info_hash)
    current_largest_item_id = (@all.max {|current, subsequent| current.id <=> subsequent.id}).id #@all.max returns an Item instance, on which we can call id
    info_hash[:id] = current_largest_item_id + 1
    info_hash[:created_at] = Time.now.getutc if !(info_hash[:created_at])
    info_hash[:updated_at] = Time.now.getutc
    new_item = Item.new(info_hash)
    @all << new_item
  end

  def update(id, info_hash)
    find_by_id(id).update(info_hash)
  end
end
