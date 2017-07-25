require_relative 'merchant_repository'
require_relative 'item_repository'
require 'csv'

class SalesEngine
  attr_reader :items, :merchants, :invoices
  
  def initialize(se_hash)
    @items = ItemRepository.new(se_hash[:item])
    @merchants = MerchantRepository.new(se_hash[:merchant])
    @invoices = InvoiceRepository.new(se_hash(:invoice))
  end

  def self.from_csv(se_hash)
    item_data = Item.load_data(se_hash[:items])
    merchant_data = Merchant.load_data(se_hash[:merchants])
    invoice_data = Invoice.load_data(se_hash[:invoices])

    Salesengine.new(item_data, merchant_data, invoice_data)
  end

  def self.load_data(se_hash)
    CSV.open(se_path, headers: true)
  end

end
