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
    collection.find_all do |element|
      element.unit_price == bigdec  #.truncate(2).to_f.round(2)
    end
  end

  def find_all_by_price_in_range(range)
      collection.find_all do |element|
      range.include? element.unit_price.truncate(2).to_f
    end
  end

  def all
    @collection
  end

  def find_all_by_merchant_id(string)
    collection.find_all do |element|
      element.merchant_id == string
    end
  end

  def loader(filepath)
    item_table = load(filepath)
     item_table.map do |item|
       item[:id] = item[:id].to_i
       item[:unit_price] = (item[:unit_price].insert (-3), ".").to_d
       item[:updated_at] = Time.parse(item[:updated_at])
       item[:created_at] = Time.parse(item[:created_at])
       item[:merchant_id] = item[:merchant_id].to_i
      @collection << Item.new(item, @parent)
     end
   end

   def update(id, attributes)
     if find_by_id(id) != nil
       it = collection.find { |element| element.id == id }
         # it.name = attributes[:name]
         it.description = attributes[:description]
         it.unit_price = attributes[:unit_price]
         it.updated_at = Time.now
     else
       []
     end
   end

end
