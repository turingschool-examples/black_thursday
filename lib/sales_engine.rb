require 'csv'
require 'pry'
require_relative './item_repository'
require_relative './merchant_repository'

class SalesEngine

  attr_reader :merchants,
              :items

  def initialize(data)
    @items = ItemRepository.new(self)
    @merchants = MerchantRepository.new(self)
    # @items = ItemRepository.new(data[:items], self)
    # @merchants = MerchantRepository.new(data[:merchants], self)
  end

  # def self.initialize
  #   @items = ItemRepository.new
  #   @merchants = MerchantRepository.new
  # end

  def self.from_csv(input)
    # SalesEngine.new(input)
    created = SalesEngine.new(input)
    input.each_pair do |key, value|
      row = CSV.open value, headers: true, header_converters: :symbol
      if key == :items
        row.each do |data|
          created.items.add_data(data.to_hash)
        end
      elsif key == :merchants
        row.each do |data|
          created.merchants.add_data(data.to_hash)
        end
      end
    end
    created
  end

end
