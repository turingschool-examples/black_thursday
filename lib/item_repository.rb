require 'CSV'
require_relative 'csv_adapter'
require 'bigdecimal'
require 'bigdecimal/util'
require 'time'

require_relative 'item.rb'
require_relative 'crud.rb'

class ItemRepository
include Crud

  attr_reader :collection,
              :changeable_attributes

  def initialize(filepath, parent)
    @collection = []
    loader(filepath)
    @parent = parent
    @changeable_attributes = [:name]
    # @collection = []
    # loader(filepath)
    # @collection.each do |item|
    #   item[:unit_price] = item[:unit_price].to_d
    # end
    # @changeable_attributes = [ :name, :description, :unit_price  ]
  end

  def create(attributes)
    largest = (collection.max_by {|element| element[:id]})[:id]
    attributes[:id] = (largest + 1)
    new = Item.new(attributes)
    @collection << new
  end

  def find_all_with_description(string)
    find_all_by(:description, string)
  end

  # def find_all_by_price(string)
  #   find_all_by_exact(:unit_price, string)
  # end

  def find_all_by_price(bigdec)
    collection.keep_if do |element|
      element[:unit_price] == bigdec
    end
  end


  def find_all_by_price_in_range(big_range)
    # big_range = ((range.begin.to_d)..(range.end.to_d))
    collection.keep_if do |element|
      big_range.include? element[:unit_price]
    end
  end

  def all
    @collection
  end

  def find_all_by_merchant_id(string)
    find_all_by_exact(:merchant_id, string)
  end

  def loader(filepath)
    item_table = load(filepath)
     item_table.map do |item|
       item[:id] = item[:id].to_i
       item[:updated_at] = Time.parse(item[:updated_at])
       item[:created_at] = Time.parse(item[:created_at])
      @collection << Item.new(item, @parent)
     end
   end

end
