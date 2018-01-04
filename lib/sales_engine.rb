require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require 'pry'

class SalesEngine

  attr_reader :item_repository,
              :merchant_repository

  def initialize(items, merchants)
    @item_repository = ItemRepository.new(items, self)
    @merchant_repository = MerchantRepository.new(merchants, self)
  end

  def self.from_csv(csv_files)
    SalesEngine.new(csv_files[:items], csv_files[:merchants])
  end



end
