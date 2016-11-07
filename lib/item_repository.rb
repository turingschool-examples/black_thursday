require 'pry'
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
    all.find { |item| item.id.eql?(desired_id) }
  end

  def find_by_name(desired_name)
    all.find { |item| item.name.downcase.eql?(desired_name.downcase) }
  end

  def find_all_with_description(fragment)
    response = all.find_all { |item| item.description.downcase.include?(fragment.downcase) }
  end

  def find_all_by_price(desired_price)
    all.find_all { |item| item.unit_price.eql?(desired_price) }
  end

  def find_all_by_price_in_range(desired_range)
    response = all.find_all { |item| desired_range.cover?(item.unit_price) }
  end

  def convert_to_dollar(big_decimal)
    sprintf('%05.2f', (big_decimal/100)).to_f
  end

  def find_all_by_merchant_id(desired_merchant_id)
    all.find_all { |item| item.merchant_id.eql?(desired_merchant_id) }
  end

  def find_merchant_by_merchant_id(merchant_id)
    parent.find_merchant_by_merchant_id(merchant_id)
  end

  def inspect  
  end
end