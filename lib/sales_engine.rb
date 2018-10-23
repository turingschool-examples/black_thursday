require 'csv'

require_relative 'merchant_repository'
require_relative 'item_repository'

require 'pry'

class SalesEngine
  def self.from_csv(file_hash)
    items_file = CSV.read(file_hash[:items], headers: true, header_converters: :symbol)
    merchants_file = CSV.read(file_hash[:items], headers: true, header_converters: :symbol)
    item_repository = ItemRepository.new
    merchant_repository = MerchantRepository.new

    merchants_file.each do |row|
      merchant_repository.create(row.to_hash)
    end

    items_file.each do |row|
      item_repository.create(row.to_hash)
    end

    self.new(item_repository, merchant_repository)
  end

  attr_reader :items, :merchants
  def initialize(item_repository, merchant_repository)
    @items = item_repository
    @merchants = merchant_repository
  end
end
