require 'CSV'
require 'pry'
require_relative 'merchant.rb'
require_relative 'crud.rb'

class MerchantRepository
include Crud

	attr_reader :collection

  def initialize(filepath)
    @collection = []
    load(filepath)
  end

  def create(attributes)
    largest = (collection.max_by {|element| element[:id]})[:id]
    attributes[:id] = (largest + 1)
    new = Merchant.new(attributes)
    @collection << new.data
  end

  def update(id, attributes)
    merch = collection.find { |element| element[:id] == id}
    merch[:name] = attributes
  end

end
