require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require 'pry'

class SalesEngine
  attr_reader   :paths,
                :items,
                :merchants,
                :invoices,
                :invoice_items

  def initialize(paths)
    @items = ItemRepository.new(paths[:items], self) if paths[:items]
    @merchants = MerchantRepository.new(paths[:merchants], self) if paths[:merchants]
    @invoices = InvoiceRepository.new(paths[:invoices], self) if paths[:invoices]
    @invoice_items = InvoiceItemRepository.new(paths[:invoice_items], self) if paths[:invoice_items]
  end

  def self.from_csv(paths)
    SalesEngine.new(paths)
  end

  def find_merchant(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def find_items_by_merchant_id(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end

  def find_invoices_by_merchant_id(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
  end

end
