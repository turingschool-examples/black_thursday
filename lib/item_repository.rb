require_relative '../lib/item'
require_relative '../lib/repo_module'
require 'bigdecimal'
require 'time'

class ItemRepository
  include RepoModule

  def initialize
    @data = []
  end

  def find_all_with_description(search_description)
    @data.find_all do |item|
      item.description.downcase.include?(search_description.downcase)
    end
  end

  def find_all_by_price(search_price)
    @data.find_all do |item|
      item.unit_price_to_dollars == search_price
    end
  end

  def find_all_by_price_in_range(range)
   @data.find_all do |item|
     item.unit_price.to_f.between?(range.first, range.last)
   end
  end

  def find_all_by_merchant_id(search_merchant_id)
    @data.find_all do |item|
      item.merchant_id == search_merchant_id
    end
  end

  def create(attributes)
    if attributes[:id] != nil
      #Coming From CSV
      hash = {
        id: attributes[:id],
        name: attributes[:name],
        description: attributes[:description],
        #TODO This line is very ugly
        unit_price: BigDecimal.new(attributes[:unit_price].to_f/100, attributes[:unit_price].length),
        updated_at: Time.parse(attributes[:updated_at]),
        created_at: Time.parse(attributes[:created_at]),
        merchant_id: attributes[:merchant_id]
        }
      item = Item.new(hash)
      @data << item

    else
      #Gererated on the fly
      hash = {
        id: find_next_id,
        name: attributes[:name],
        description: attributes[:description],
        unit_price: attributes[:unit_price],
        updated_at: attributes[:updated_at],
        created_at: attributes[:created_at]
      }
      item = Item.new(hash)
      @data << item
    end
  end

  def update(id, attributes)
    if find_by_id(id) != nil
      update_attributes(id, attributes)
      find_by_id(id).updated_at = Time.now
    end
  end
end
