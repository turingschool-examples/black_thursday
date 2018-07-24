require 'csv'
require_relative '../lib/item.rb'
require_relative '../lib/merchant.rb'

class SalesEngine
  attr_reader :csv_hash,
              :items,
              :merchants

  def initialize(csv_hash)
    @csv_hash = csv_hash
    # @items = ItemRepository.new(csv_hash[:items])
    @merchants = MerchantRepository.new(csv_hash[:merchants])
  end


  def self.from_csv(csv_hash)#pass in result of read_from_csv
    SalesEngine.new(csv_hash)
  end
end
