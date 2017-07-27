<<<<<<< HEAD
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
=======
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
>>>>>>> origin

class SalesEngine

  attr_reader :items,
              :merchants,
              :invoices

  def initialize(item_file, merchant_file, invoice_file)
    @items = ItemRepository.new(item_file, self)
    @merchants = MerchantRepository.new(merchant_file, self)
    @invoices = InvoiceRepository.new(invoice_file, self)
  end

  def self.from_csv(file = {})
    SalesEngine.new(file[:items], file[:merchants], file[:invoices])
  end

end
