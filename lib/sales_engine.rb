require'./test/helper'

class SalesEngine
  attr_reader :merchants,
              :items,
              :invoices,
              :invoice_items

  def initialize(csv_hash)
    @merchants     = MerchantRepository.new(csv_hash[:merchants])
    @items         = ItemRepository.new(csv_hash[:items])
    @invoices      = InvoiceRepository.new(csv_hash[:invoices])
    @invoice_items = InvoiceItemRepository.new(csv_hash[:invoice_items])
  end

  def self.from_csv(csv_hash)
   new(csv_hash)
  end

  def analyst
     SalesAnalyst.new(self)
  end

end
