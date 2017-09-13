require_relative 'item'
require 'csv'

class ItemRepository
  attr_accessor :all

  def initialize(file_path, parent=nil)
    @all    = csv_parse(file_path).map {|row| Item.new(row, self)}
    @parent = parent
  end

  def csv_parse(file_path)
    CSV.open file_path, headers: true, header_converters: :symbol
  end

  def find_by_id(id_number)
    all.find {|item| item.id.to_i == id_number.to_i}
  end

  def find_by_name(name)
    all.find {|item| item.name.downcase == name.downcase}
  end

  def find_all_with_description(info)
    all.select {|item| item.description.downcase.include?(info.downcase)}
  end

  def find_all_by_price(number)
    all.select {|item| item.unit_price == number}
  end

  def find_all_by_price_in_range(price_range)
    all.select {|item| price_range.include?(item.unit_price)}
  end

  def find_all_items_per_merchant(merchant_id)
    all.select {|item| item.merchant_id.include?(merchant_id.to_s)}
  end

  def find_merchant_that_owns_item(item_id)
    @parent.find_merchant_that_owns_item(item_id)
  end

  def inspect
    "#{self.class}"
  end
end
