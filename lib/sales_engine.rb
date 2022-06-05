class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :analyst

  def initialize(items_path, merchants_path, invoice_path)
    @items      = ItemRepository.new(items_path)
    @merchants  = MerchantRepository.new(merchants_path)
    @invoices   = InvoiceRepository.new(invoice_path)
    @analyst    = SalesAnalyst.new(items, merchants, invoices)
  end

  def self.from_csv(data)
    return SalesEngine.new(data[:items], data[:merchants], data[:invoices])
  end

end
