require          'csv'
require          'pry'
require_relative 'item'

class ItemRepository
  attr_reader :all

  def initialize(all)
    @all = all
  end

  def stdrd(item_name_inputed)
    item_name_inputed.to_s.downcase.gsub(" ", "")
  end

  def find_by_id(item_id_inputed)
    stdrd_item_id = stdrd(item_id_inputed)
    item_info = @all.find {|line| stdrd(line[:id]) == stdrd_item_id}
    item_info.nil? ? item = nil : item = Item.new(item_info)
    item
  end

  def find_by_name(item_name_inputed)
    stdrd_item_name = stdrd(item_name_inputed)
    item_info = @all.find {|line| stdrd(line[:name]) == stdrd_item_name}
    item_info.nil? ? item = nil : item = Item.new(item_info)
    item
  end

  def find_all_with_description(inputed_description)
    stdrd_inputed_description = stdrd(inputed_description)
    item_info = @all.find_all do |line|
      stdrd(line[:description]).gsub("\n","").include?(stdrd_inputed_description)
    end
    array_of_items_found_that_match(item_info)
  end

  def make_sure_decimal_was_put_in(input_price)
    check_for_decimal = input_price.to_s.chars
    if check_for_decimal[-3] != "."
      check_for_decimal << ["0","0"]
      check_for_decimal.join
    else
      check_for_decimal
    end
  end

  def std_price(input_price)
    input_price_in_cents = make_sure_decimal_was_put_in(input_price)
    input_price_in_cents.to_s.gsub(/\D/,"")
  end

  def significant_digits(std_input_price)
    std_input_price.length
  end

  def find_all_by_price(input_price)
    std_input_price = std_price(input_price)
    item_price = @all.find_all do |line|
      line[:unit_price].to_i == std_input_price.to_i
    end
    array_of_items_found_that_match(item_price)
  end


  def array_of_items_found_that_match(items_info)
    if items_info.nil?
      []
    else
      items_info.map {|item_info| Item.new(item_info)}
    end
  end

  def find_all_by_price_in_range(range_input)
    std_range_begin = std_price(range_input.first)
    std_range_end   = std_price(range_input.last)
    items_within_range = @all.find_all do |line|
      line[:unit_price].to_i > std_range_begin.to_i && line[:unit_price].to_i < std_range_end.to_i
    end
    array_of_items_found_that_match(items_within_range)
  end

end
