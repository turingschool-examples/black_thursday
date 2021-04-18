require 'CSV'
require_relative 'item_repo'
require_relative 'merchant_repo'
# require_relative 'sales_analyst'
require_relative 'invoice_repo'
# require_relative 'invoice_items'
require_relative 'transaction_repo'

class SalesEngine
  attr_reader :items,
              :merchants,
              :analyst,
              :invoices,
              :invoice_items,
              :transactions
  def initialize(paths)
    @items = ItemRepo.new(paths[:items], self)
    @merchants = MerchantRepo.new(paths[:merchants], self)
    # @analyst = SalesAnalyst.new(self)
    @invoices = InvoiceRepo.new(paths[:invoices], self)
    # @invoice_items = InvoiceItemRepo.new(paths[:invoice_items], self)
    # @transactions = TransactionRepo.new(paths[:merchants], self)
  end

  def self.from_csv(paths)
    new(paths)
  end

end
