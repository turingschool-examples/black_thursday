require 'pry'
require 'csv'
require_relative 'item'
class ItemRepository
  attr_reader :file_path,
              :content

  def initialize(file_path)
    @file_path = file_path
    @content = nil
    # @item = Item.new
  end

  def item_info
    CSV.read(file_path)
  end

  def organize
    header = item_info[0]
    content = item_info[2..-1]
    final = []
    content.each do |line|
      x = header.zip(line).flatten.compact
      final << x
    end
    l = []
    final.map do |i|
      h = Hash[*i]
      l << h
    end
    @content = l
  end

  def all
    #returns array of all known Item instances
  end

  def find_by_id(id_number)
    content.each do |item|
      i = Item.new(item)
      i.id == id_number ? i : nil
    end
  end

  def find_by_name(name)
    content.each do |item|
      i = Item.new(item)
      i.name == name ? i : nil
    end
  end

  def find_all_with_description(str)
    list = []
    content.each do |item|
      i = Item.new(item)
      list << i if i.description.split.include?(str)
    end
    list
  end

  def find_all_by_price(price)
    list = []
    content.each do |item|
      i = Item.new(item)
      list << i if i.unit_price.to_f == price.to_f
    end
    list
  end

  def find_all_by_price_range(price_range)
    list = []
    content.each do |item|
      i = Item.new(item)
      list << i if price_range.include?(i.unit_price.to_f)
    end
    list
  end

  def find_all_by_merchant_id(id_number)
    list = []
    content.each do |item|
      i = Item.new(item)
      list << i if i.merchant_id == id_number
    end
    list
  end
end
