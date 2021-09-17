require_relative './lib/merchant_repository'
require_relative './lib/item_repository'
require 'csv'
require 'pry'

class SalesEngine

  include ItemRepository
  include MerchantRepository
  # other Repo classes

  attr_reader :items,
              :merchants

  def initialize(data)
    @items     = ItemRepository.new(data[:items])
    @merchants = MerchantRepository.new(data[:merchants])
   # @merchants = data[:merchants]
   # @ite ms = data[:items]
  end

  def self.from_csv(data)
    stats             = {}
    stats[:merchants] = create_obj_csv(locations[merchants], Merchant)
    stats[:items]     = create_obj_csv(locations[items], Item)

    SalesEngine.new(data)
  end

  def self.create_obj_csv(locations, obj_type)
    objects = []
    CSV.foreach(locations, headers: true, header_converters: :symbol) do |row|
      object = obj_type.new(row)
      objects << object
    end
    objects
  end
end
