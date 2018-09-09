require_relative './item'
require_relative './merchant'
require 'pry'

class ItemRepository
    attr_reader :all

  def initialize(filepath = nil)
    @filepath = filepath
    @all = []
  end

  def add_individual_item(item)
    @all << item
  end

  def split(filepath)
    item_objects = CSV.open(filepath, headers: true, header_converters: :symbol)

    item_objects.map do |object|
      object[:id] = object[:id].to_i
      @all << object.to_h
    end
  end

  def find_by_id(id)
    @all.find do |item|
      item.id == id
    end
  end



    # def find_all_by(attr_sym, search_string)
    #   @items.find_all do |item|
    #     item[:data][attr_sym] == search_string.downcase
    #   end
    # end
    #
    # def find_by(attr_sym, search_string)
    #   @items.find do |item|
    #     item[attr_sym] == search_string.downcase
    #   end
    # end




end
