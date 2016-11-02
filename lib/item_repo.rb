require_relative '../lib/item'
require_relative '../lib/data_parser'

class ItemRepo
  include DataParser
  attr_reader :all

  def initialize(file_path = nil)
    raw_file = file_path || './data/items.csv'
    @all     = parse_data(raw_file).map { |row| Item.new(row) }
  end

  def find_by_id(id)
    @all.find(id) {|item| item.id.eql?(id)}
  end

  def find_by_name(name)
    @all.find(name) {|item| item.name.downcase.eql?(name.downcase)}
  end

  def find_all_with_description(description_fragment)
    @all.find_all {|item| item.description.downcase.include?(description_fragment)}
  end

  def find_all_by_price(price)
    @all.find_all {|item| item.unit_price.eql?(price)}
  end

  def find_all_by_price_in_range(price_range)
    @all.find_all {|item| price_range.include?(item.unit_price)}
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all {|item| item.merchant_id.eql?(merchant_id)}
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end
end
