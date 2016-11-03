require_relative './item'
require_relative './data_parser'

class ItemRepo
  include DataParser
  attr_reader :all

  def initialize(file, parent = nil)
    @all = parse_data(file).map { |row| Item.new(row, self) }
    @parent = parent
  end

  def find_by_id(id)
    @all.find {|item| item.id.eql?(id)}
  end

  def find_by_name(name)
    @all.find {|item| item.name.downcase.eql?(name.downcase)}
  end

  def find_all_with_description(description_fragment)
    @all.find_all {|item| item.description.downcase.include?(description_fragment.downcase)}
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
