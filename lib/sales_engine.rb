require 'csv'
require_relative '../lib/merchant.rb'
require_relative '../lib/merchant_repository.rb'
require_relative '../lib/item_repository.rb'
require_relative '../lib/invoice_repository.rb'
require_relative '../lib/sales_analyst.rb'

require 'pry'

class SalesEngine
  attr_reader :merchants,
              :items,
              :invoices,
              :analyst

  def initialize(merchant_location, item_location, invoice_location)
    @merchants = MerchantRepository.new(merchant_location)
    @items = ItemRepository.new(item_location)
    @invoices = InvoiceRepository.new(invoice_location)
    @analyst = SalesAnalyst.new(@merchants, @items)
  end

  def self.from_csv(csv_hash)
    merchant_location = csv_hash[:merchants]
    item_location = csv_hash[:items]
    invoice_location = csv_hash[:invoices]
    SalesEngine.new(merchant_location, item_location, invoice_location)
  end
end
