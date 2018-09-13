require 'CSV'
require_relative 'csv_adapter'
require 'bigdecimal'
require 'bigdecimal/util'
require 'time'

require_relative 'merchant.rb'
require_relative 'crud.rb'

class MerchantRepository
include Crud

  attr_reader :collection,
              :changeable_attributes

  def initialize(filepath, parent)
    @collection = []
    loader(filepath)
    @parent = parent
    @changeable_attributes = [:name]
  end

  def create(attributes)
    if @collection != []
      largest = (@collection.max_by {|element| element.id})
      attributes[:id] = (largest.id + 1)
    else
      attributes[:id] = 1
    end
    merch = Merchant.new(attributes, self)
    @collection << merch
  end

  def find_all_by_name(string)
    find_all_by("name", string)
  end

  def all
    @collection
  end

  def loader(filepath)
    merchant_table = load(filepath)
     merchant_table.map do |merchant|
       merchant[:id] = merchant[:id].to_i
       merchant[:updated_at] = Time.parse(merchant[:updated_at])
       merchant[:created_at] = Time.parse(merchant[:created_at])
      @collection << Merchant.new(merchant, @parent)
     end
  end

  def update(id, attributes)
    if @changeable_attributes + attributes.keys != []
      it = collection.find { |element| element.id == id }
      attributes.map do |attribute|
        it.name = attribute[1]
      end
    else
      []
    end
  end
end
