require_relative 'item_repository'
require_relative 'merchant_repository'
require 'csv'

class SalesEngine
  attr_reader :items, :merchants
  def initialize(data)
    @items = data[:items]
    @merchants = data[:merchants]
  end

  def items
    item_repository = ItemRepository.new(@items)
  end

  def merchants
    merchant_repository = MerchantRepository.new(@merchants)
  end
end


# class ItemRepository < SalesEngine
#   def initialize(items)
#     @items = items
#     #for each item in csv
#     @item_instances = []
#     CSV.foreach(items, headers: true, header_converters: :symbol).each do |row|
#       item_instances << Item.new(row)
#       #can pull when initializing item object to creat instance variables from hash key/value pairs.
#       require "pry"; binding.pry
#     end
#     require "pry"; binding.pry
#   end
# end
