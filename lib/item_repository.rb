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
    if item_info.nil?
      []
    else
      item_info.map {|item_info| Item.new(item_info)}
    end
  end

  def stdprice(input_price)
    input_price.gsub(/\D/,"")
  end

  def only_search_sig_digits(std_input_price, data_price)
    significant_digits = std_input_price.length
    data_price.chars.drop(significant_digits).join
  end

  def find_all_by_price(input_price)
      std_input_price = stdprice(input_price)
      item_price = @all.find_all do |line|
        only_search_sig_digits(std_input_price, line[:unit_price]) == std_input_price
      end
      if item_price.nil?
        []
      else
        item_price.map {|item_info| Item.new(item_info).description}
      end
  end


  #notes for find_all_by_price_in_range
  #within the argument for our tests have the range like this
  #ex: (700..900) => which will be a range object check methods on ruby docs
  #use the method include? to check through given range!
  #call the method .to_i to the BigDecimal objects to compare the classes
  #range is a collection of integers that need BigDecimal to turn to one in order
  #to compare it with each other



  def find_all
  end
end
