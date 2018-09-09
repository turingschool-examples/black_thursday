require 'CSV'
require 'pry'
require_relative 'item.rb'
require_relative 'crud.rb'

class ItemRepository
include Crud

  attr_reader :collection,
              :changeable_attributes

  def initialize(filepath)
    @collection = []
    load(filepath)
    @changeable_attributes = [ :name, :description, :unit_price  ]
  end

  def create(attributes)
    largest = (collection.max_by {|element| element[:id]})[:id]
    attributes[:id] = (largest + 1)
    new = Item.new(attributes)
    @collection << new.data
  end
end
