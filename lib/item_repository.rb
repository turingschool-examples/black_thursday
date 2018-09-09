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
    @collection.each do |item|
      item[:unit_price] = item[:unit_price].to_d
    end
    @changeable_attributes = [ :name, :description, :unit_price  ]
  end

  def create(attributes)
    largest = (collection.max_by {|element| element[:id]})[:id]
    attributes[:id] = (largest + 1)
    new = Item.new(attributes)
    @collection << new.data
  end

  def find_all_with_description(string)
    find_all_by(:description, string)
  end

  def find_all_by_price(string)
    find_all_by_exact(:unit_price, string)
  end

  def find_all_by_merchant_id(string)
    find_all_by_exact(:merchant_id, string)
  end
end
