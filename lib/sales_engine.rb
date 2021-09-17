require 'csv'
require_relative './item_repository'
require_relative './merchant_repository'
require_relative './items'
require_relative './merchants'

class SalesEngine
  attr_accessor :items,
                :merchants

  def self.from_csv(paths)
    data = {}
    data[:items]     = create_obj_csv(paths[:items], Items)
    data[:merchants] = create_obj_csv(paths[:merchants], Merchants)
    SalesEngine.new(data)
  end

  def initialize(data)
    @items     = ItemRepository.new(data[:items])
    @merchants = ItemRepository.new(data[:merchants])
  end

  def self.create_obj_csv(locations, obj_type)
    objects = []
    CSV.foreach(locations, headers: true, header_converters: :symbol,
                           quote_char: '"', liberal_parsing: true) do |row|
      object = obj_type.new(row)
      objects << object
    end
    objects
  end
end
