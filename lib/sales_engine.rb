require 'CSV'
require_relative 'item_repo'
require_relative 'merchant_repo'
# require_relative 'sales_analyst'
<<<<<<< transaction
# require_relative 'invoices'
# require_relative 'invoice_items'
require_relative 'transaction'
require_relative 'customer'
=======
require_relative 'invoice_repo'
# require_relative 'invoice_items'
require_relative 'transaction_repo'
>>>>>>> refactor_spec_tests

class SalesEngine
  attr_reader :items,
              :merchants,
<<<<<<< transaction
              :transactions

  def initialize(paths)
    @items = ItemRepo.new(paths[:items], self)
   @merchants = MerchantRepo.new(paths[:merchants], self)
   # @analyst = SalesAnalyst.new(self)
   @invoices = InvoiceRepo.new(path[:invoices], self)
   # @invoice_items = InvoiceItemRepo.new(path[:invoice_items], self)
   @transactions = TransactionRepo.new(paths[:transacionts], self)
   @customers = CustomerRepo.new(paths[:customers], self)
=======
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
>>>>>>> refactor_spec_tests
  end

  def self.from_csv(paths)
    new(paths)
  end

end
