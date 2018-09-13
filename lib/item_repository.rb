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
    @changeable_attributes = [:name, :description, :unit_price]
    # @collection = []
    # loader(filepath)
    # @collection.each do |item|
    #   item[:unit_price] = item[:unit_price].to_d
    # end
    # @changeable_attributes = [ :name, :description, :unit_price  ]
  end

  def create(attributes)
    if @collection != []
      largest = (@collection.max_by {|element| element.id})
      attributes[:id] = (largest.id + 1)
    else
      attributes[:id] = 1
    end
    i = Item.new(attributes, self)
    @collection << i
  end

  def find_all_with_description(string)
    find_all_by("description", string.downcase)
  end

  def find_all_by_price(bigdec)
    find_all_by("unit_price", bigdec)
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
