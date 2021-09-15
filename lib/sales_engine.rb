require 'csv'
# require_relative './item_repository'
require_relative './merchant_repository'

class SalesEngine
  attr_accessor :items,
                :merchants

  def initialize(data)
    @items     = data[:items]
    @merchants = data[:merchants]
  end

  def merchant_repo
    MerchantRepository.new(@merchants)
  end

  def item_repo
    ItemRepository.new(@items)
  end
  # def self.from_csv(paths)
  #   hash = {}
  #   hash[:items]     = create_obj_csv(@items)
  #   hash[:merchants] = create_obj_csv(@merchants)
  # end

  # def self.create_obj_csv(locations)
  #   objects = []
  #   CSV.foreach("./data/merchants.csv", headers: true, header_converters: :symbol) do |row|
  #     # object = (row)
  #     objects << row
  #   end
  #   objects
  # end
end

se = SalesEngine.new({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv"
})
require "pry"; binding.pry
# se.items
# mr = se.merchants
