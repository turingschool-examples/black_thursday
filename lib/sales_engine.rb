
require_relative 'item_repository'
require_relative 'sales_analyst'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require 'csv'
require 'pry'

class SalesEngine

  attr_reader :items,
              :merchants,
              :salesanalyst,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(item_path, merchant_path, invoice_path,
                 invoice_items_path, transaction_path, customer_path)

    @items         = ItemRepository.new(item_path, self)
    @merchants     = MerchantRepository.new(merchant_path,self)
    @salesanalyst  = SalesAnalyst.new(self)
    @invoices      = InvoiceRepository.new(invoice_path,self)
    @invoice_items = InvoiceItemRepository.new(invoice_items_path,self)
    @transactions  = TransactionRepository.new(transaction_path, self)
    @customers     = CustomerRepository.new(customer_path, self)
  end

  def self.from_csv(file = {})
    SalesEngine.new(file[:items], file[:merchants], file[:invoices],
    file[:invoice_items], file[:transactions], file[:customers])
  end
end
