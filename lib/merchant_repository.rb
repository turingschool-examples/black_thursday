require 'CSV'
require 'bigdecimal'
require 'bigdecimal/util'

require_relative 'merchant.rb'
require_relative 'crud.rb'

class MerchantRepository
include Crud

  attr_reader :collection,
              :changeable_attributes

  def initialize(filepath)
    @collection = []
    load(filepath)
    @changeable_attributes = [:name]
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
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

  def merchants
    collection
  end
  
end
