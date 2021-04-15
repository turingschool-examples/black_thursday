require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class SalesEngine
  attr_reader :merchants, :items
  def initialize(csv_data)
    @merchants = csv_data[:merchants]
    @items = csv_data[:items]
  end

  def self.from_csv(csv_data)
     SalesEngine.new(csv_data)
  end

  def merchants
    MerchantRepository.new(@merchants)
  end

  def items
    ItemRepository.new(@items)
  end
end
