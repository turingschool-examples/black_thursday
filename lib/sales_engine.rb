require_relative 'item_repo'
require_relative 'merchant_repo'
require_relative 'invoice_repo'

class SalesEngine
  attr_reader :invoices, :merchants, :items

  def initialize(data)
    @invoices      = InvoiceRepo.new(data[:invoices], self)
    @merchants     = MerchantRepo.new(data[:merchants], self)
    @items         = ItemRepo.new(data[:items], self)
    # @customers     = CustomerRepo.new(data[:customers], self)
    # @transactions  = TransactionRepo.new(data[:transactions], self)
    # @invoice_items = InvoiceItemsRepo.new(data[:invoice_items], self)
  end

  def self.from_csv(data)
    se = SalesEngine.new(data)
  end
end
