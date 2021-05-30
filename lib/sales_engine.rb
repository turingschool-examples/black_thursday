require_relative 'item_repository'
require_relative 'merchant_repository'
require 'csv'

class SalesEngine
  def initialize
  end

  def self.from_csv(path)
    @items = path[:items]
    @merchants = path[:merchants]

    SalesEngine.new
  end

  def items
    item_repository = ItemRepository.new(@items)
  end

  def merchants
    merchant_repository = MerchantRepository.new(@merchants)
  end

  def analyst
    SalesAnalyst.new
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
