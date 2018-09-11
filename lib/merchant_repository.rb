require 'CSV'
require_relative 'csv_adapter'
require 'bigdecimal'
require 'bigdecimal/util'

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
    largest = (collection.max_by {|element| element[:id]})[:id]
    attributes[:id] = (largest + 1)
    new = Merchant.new(attributes)
    @collection << new.data
  end

  def find_all_by_name(string)
    find_all_by(:name, string)
  end

  def all 
    @collection
  end

  def loader(filepath)
    merchant_table = load(filepath)
     merchant_table.map do |merchant|
      @collection << Merchant.new(merchant, @parent)
     end
   end
end
