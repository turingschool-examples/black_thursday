require './lib/merchant_repo'
require './lib/item_repo'
require './lib/invoice_repo'
require './lib/invoice_item_repo'
require 'csv'

class SalesEngine
  attr_reader :items, :merchants, :invoices, :invoice_items

  def initialize(se_hash)
    @items         = ItemRepository.new(se_hash[:item])
    @merchants     = MerchantRepository.new(se_hash[:merchant])
    @invoices      = InvoiceRepository.new(se_hash(:invoice))
    @invoice_items = InvoiceItemRepository.new(:invoice_items)
  end

  def self.from_csv(se_hash)
    item_data = Item.load_data(se_hash[:items])
    merchant_data = Merchant.load_data(se_hash[:merchants])
    invoice_data = Invoice.load_data(se_hash[:invoices])
    invoice_item_data = InvoiceItem.load_data(se_hash[:invoice_items])

    Salesengine.new(item_data, merchant_data, invoice_data, invoice_item_data)
  end

  def self.load_data(se_hash)
    CSV.open(se_path, headers: true)
  end


end
