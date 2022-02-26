require_relative '../lib/item'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/sales_analyst'
require 'CSV'

class SalesEngine

  attr_reader :items, :merchants
  def initialize(data_hash)
    @items = ItemRepository.new(data_hash[:items])
    @merchants = MerchantRepository.new(data_hash[:merchants])
    # @invoices = InvoiceRepository.new(data_hash[:invoices])
  end

  def self.from_csv(data_hash)
    SalesEngine.new(data_hash)
  end

  def analyst
    SalesAnalyst.new(@merchants,@items)
  end
end
