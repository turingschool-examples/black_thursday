require_relative '../lib/invoice_repo'
# require_relative '../lib/merchant_repo'
# require_relative '../lib/item_repo'

class SalesEngine
  attr_reader :invoices

  def initialize(data)
    @invoices = InvoiceRepo.new(data[:invoices], self)
    # @merchants = MerchantRepo.new(data[:merchants], self)
    # @items     = ItemRepo.new(data[:items], self)
  end
end
