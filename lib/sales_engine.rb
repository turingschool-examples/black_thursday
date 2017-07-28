require 'csv'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/customer_repository'

class SalesEngine

  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(csv_data)
    @items         = ItemRepository.new(csv_data[:items], self)
    @merchants     = MerchantRepository.new(csv_data[:merchants], self)
    @invoices      = InvoiceRepository.new(csv_data[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(csv_data[:invoice_items], self)
    @transactions  = TransactionRepository.new(csv_data[:transactions], self)
    @customers     = CustomerRepository.new(csv_data[:customers], self)
  end

  def self.from_csv(csv_data)
    SalesEngine.new(csv_data)
  end

end
