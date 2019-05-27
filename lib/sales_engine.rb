require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_repository'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices

  def self.from_csv(data)
    new(data)
  end

  def initialize(data)
    @invoices = InvoiceRepository.new(data, self)
    @items = ItemRepository.new(data[:items], self)
    @merchants = MerchantRepository.new(data[:merchants], self)
  end

  def invoice_items
    @invoices.invoice_items
  end

  def transactions
    @invoices.transactions
  end

  def customers
    @invoices.customers
  end

  def find_items_by_merchant_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def find_merchant_by_merchant_id(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

  def find_invoices_by_merchant_id(id)
    @invoices.find_all_by_merchant_id(id)
  end

  def find_item_by_item_id(item_id)
    @items.find_by_id(item_id)
  end
end
