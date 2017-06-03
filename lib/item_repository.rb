require_relative './item'
require 'bigdecimal'
require 'csv'

class ItemRepository

  attr_reader :all

  def initialize(file_path, parent = nil)
    @parent = parent
    @all = []
    populate_items(file_path)
  end

  def populate_items(file_path)
    CSV.foreach(file_path, row_sep: :auto, headers: true) do |line|
      self.all << Item.new(line, self)
    end
  end

  def find_by_id(id)
    @all.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @all.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    downcased = description.downcase
    @all.find_all do |item|
      item.description.include? downcased
    end
  end

  def find_all_by_price(unit_price)
    @all.find_all do |item|
      # binding.pry
      item.unit_price == unit_price
    end
  end

  def find_all_by_price_in_range(range)
    @all.find_all do |item|
      range.include? item.unit_price
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def mid_to_se(merchant_id)
    @parent.merchant_by_merchant_id(merchant_id)
  end

  def inspect
   "#<#{self.class} #{@all.size} rows>"
  end
end
