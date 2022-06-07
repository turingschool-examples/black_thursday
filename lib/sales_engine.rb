require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/customer_repository'
require_relative '../lib/invoice_item_repository'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :customers

  def initialize(items_path, merchants_path, invoices_path, invoice_items_path, customers_path)
    @items = ItemRepository.new(items_path)
    @merchants = MerchantRepository.new(merchants_path)
    @invoices = InvoiceRepository.new(invoices_path)
    @invoice_items = InvoiceItemRepository.new(invoice_items_path)
    @customers = CustomerRepository.new(customers_path)
  end

  def self.from_csv(data)
    SalesEngine.new(data[:items], data[:merchants], data[:invoices], data[:invoice_items], data[:customers])
  end

  def analyst
    SalesAnalyst.new(@item_repository, @merchant_repository, @invoice_repository, @invoice_item_repository, @customer_repository)
  end
end
