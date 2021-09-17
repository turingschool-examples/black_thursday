require './lib/merchant_repository'
require './lib/item_repository'
require './lib/item'
require './lib/merchant'
require 'csv'
require 'pry'

class SalesEngine

  # include ItemRepository
  # include MerchantRepository
  # other Repo classes

  attr_reader :items,
              :merchants

  def initialize(data)
    @items     = data[:items]
    @merchants = data[:merchants]
  end

  def self.from_csv(data)
    sales            = {}
    data[:merchants] = create_obj_csv(data[:merchants], Merchant)
    # data[:items]     = create_obj_csv(data[:items], Item)

    SalesEngine.new(data)
  end

  def self.create_obj_csv(data, obj_type)
    objects = []
    CSV.foreach(data, headers: true, header_converters: :symbol) do |row|
      object = obj_type.new(row)
      objects << object
    end
    objects
  end
end
