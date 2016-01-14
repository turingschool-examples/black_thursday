require          'csv'
require          'pry'
require_relative 'item'

class ItemRepository
  attr_reader   :all, :item_instances
  attr_accessor :merchant_repo

  def initialize(csv_hash)
    @item_instances = csv_hash.map {|csv_hash| Item.new(csv_hash, merchant_repo)}
    @all = item_instances
  end

  def stdrd(item_name_inputed)
    item_name_inputed.to_s.downcase.gsub(" ", "")
  end

  def find_by_id(item_id_inputed)
    stdrd_item_id = stdrd(item_id_inputed)
    found_item_instances = item_instances.find {|item| stdrd(item.id) == stdrd_item_id}
    found_item_instances.nil? ? nil : found_item_instances
  end

  def find_by_name(item_name_inputed)
    stdrd_item_name = stdrd(item_name_inputed)
    found_item_instances = item_instances.find {|item| stdrd(item.name) == stdrd_item_name}
    found_item_instances.nil? ? nil : found_item_instances
  end

  def find_all_with_description(inputed_description)
    stdrd_inputed_description = stdrd(inputed_description)

    found_item_instances = item_instances.find_all { |item|
      stdrd(item.description).gsub("\n","").include?(stdrd_inputed_description)}

    found_item_instances.nil? ? [] : found_item_instances
  end

  def make_sure_decimal_was_put_in(input_price)
    check_for_decimal = input_price.to_s.chars
    if check_for_decimal[-3] == "."
      input_price
    else
      added_decimal = check_for_decimal << ["0","0"]
      added_decimal.join
    end
  end

  def std_price(input_price)
    input_price_in_cents = make_sure_decimal_was_put_in(input_price)
    input_price_in_cents.to_s.gsub(/\D/,"")
  end

  def find_all_by_price(input_price)
    std_input_price = std_price(input_price)

    found_item_instances = item_instances.find_all {|item|
      item.unit_price.to_i == std_input_price.to_i}

      found_item_instances.nil? ? [] : found_item_instances
  end

  def find_all_by_price_in_range(range_input)
    std_range_begin = std_price(range_input.first)
    std_range_end   = std_price(range_input.last)

    found_item_instances = item_instances.find_all {|item|
      item.unit_price.to_i > std_range_begin.to_i &&
      item.unit_price.to_i < std_range_end.to_i}

    found_item_instances.nil? ? [] : found_item_instances
  end

  def find_all_by_merchant_id(inputed_merchant_id)
    found_item_instances = item_instances.find_all { |item|
      item.merchant_id.to_i == inputed_merchant_id.to_i}

    found_item_instances.nil? ? [] : found_item_instances
  end
end
