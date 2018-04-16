require 'csv'
require_relative 'merchant'
require_relative 'repository'

# This class is a repo for items
class MerchantRepository
  include Repository
  def initialize
    @elements = {}
  end

  def build_elements_hash(elements)
    elements.each do |element|
      item = Merchant.new(element)
      @elements[item.id] = item
    end
  end

  def create(attributes)
    create_id_number
    attributes[:id] = create_id_number
    item = Merchant.new(attributes)
    @elements[create_id_number] = item
  end
end
