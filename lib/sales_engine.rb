require 'csv'
# require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesEngine

  attr_reader :items, :merchants
  def initialize(data)
     @items ||= ItemRepository.new(data[:items])
     # @merchants = MerchantRepository.new(data[:merchants])
  end
# by passing data in hash, you don't have to know exact name of csv, can
# be called by the key value
  def self.from_csv(data)
    new(data)
  end

end
