require 'csv'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(data_files)
    @items = ItemRepository.new(data_files)
    @merchants = MerchantRepository.new(data_files)
  end

  def self.from_csv(data_files)
    se = SalesEngine.new(data_files)
  end

end
