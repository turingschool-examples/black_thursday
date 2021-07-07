require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'

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

  def merchant_by_merchant_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def items_by_merchant_id(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end

  def invoices_by_merchant_id(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
  end

end
