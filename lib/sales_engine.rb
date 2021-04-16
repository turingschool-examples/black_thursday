require 'CSV'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class SalesEngine
  attr_reader :merchants, :items
  def initialize(csv_data)
    @merchants = MerchantRepository.new(csv_data[:merchants])
    @items = ItemRepository.new(csv_data[:items])
  end

  def self.from_csv(csv_data)
     SalesEngine.new(csv_data)
  end

  # def merchants
  #   MerchantRepository.new(SalesEngine.parse_csv(@merchants))
  # end
  #
  # def items
  #   ItemRepository.new(SalesEngine.parse_csv(@items))
  # end
end
