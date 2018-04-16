require 'csv'
require_relative 'item'
require_relative 'repository'

# This class is a repo for items
class ItemRepository
  include Repository
  def initialize
    @elements = {}
    @merchant_ids = Hash.new{ |h, k| h[k] = [] }

  end

  def build_elements_hash(elements)
    elements.each do |element|
      item = Item.new(element)
      @elements[item.id] = item
      @merchant_ids[item.merchant_id] << item

    end
  end

  def find_all_with_description(text)
    all.find_all do |element|
      element.description.downcase.include?(text.downcase)
    end
  end

  def create(attributes)
    create_id_number
    attributes[:id] = create_id_number
    item = Item.new(attributes)
    @elements[create_id_number] = item
  end
end
