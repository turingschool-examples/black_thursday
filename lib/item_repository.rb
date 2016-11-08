require 'csv'
require 'bigdecimal'
require_relative 'item'
require_relative 'parser'

class ItemRepository
  include Parser
  attr_reader :all, :parent

  def initialize(file_path, parent)
    @all = create_items(file_path)
    @parent = parent
  end

  def create_items(file_path)
    data_rows = parse_items_csv(file_path)
    data_rows.map { |row| Item.new(row, self) }
  end

  def find_by_id(desired_id)
    all.find { |i| i.id.eql?(desired_id) }
  end

  def find_by_name(desired_name)
    all.find { |i| i.name.downcase.eql?(desired_name.downcase) }
  end

  def find_all_with_description(fragment)
    all.find_all { |i| i.description.downcase.include?(fragment.downcase) }
  end

  def find_all_by_price(desired_price)
    all.find_all { |i| i.unit_price.eql?(desired_price) }
  end

  def find_all_by_price_in_range(desired_range)
    all.find_all { |i| desired_range.cover?(i.unit_price) }
  end

  def convert_to_dollar(big_decimal)
    sprintf('%05.2f', (big_decimal/100)).to_f
  end

  def find_all_by_merchant_id(desired_merchant_id)
    all.find_all { |i| i.merchant_id.eql?(desired_merchant_id) }
  end

  def find_merchant_by_merchant_id(merchant_id)
    parent.find_merchant_by_merchant_id(merchant_id)
  end

  def inspect
    "#{self.class}: #{all.count}"
  end
end