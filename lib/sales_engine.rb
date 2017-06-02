require 'csv'
# require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(data_files)
    @items = ItemRepository.new(data_files)

    # all_merchants = open_csv(data_files[:merchants]) #self
    # @merchants = MerchantRepository.new(all_merchants)
  end

  def self.from_csv(data_files)
    se = SalesEngine.new(data_files)
  end

end
