require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require 'pry'

class SalesEngine

  attr_reader :item_repository,
              :merchant_repository

  def initialize(repository)
    @item_repository = ItemRepository.new(repository[:items], self)
    @merchant_repository = MerchantRepository.new(repository[:merchants], self)
  end

  def self.from_csv(csv_file_hash)
    csv_file_hash
  end

end
