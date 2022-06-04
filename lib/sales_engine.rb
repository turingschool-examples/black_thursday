class SalesEngine
  attr_reader :items, :merchants, :invoices

  def initialize(items_path, merchants_path, invoice_path)
    @items = ItemRepository.new(items_path)
    @merchants = MerchantRepository.new(merchants_path)
    @invoices = InvoiceRepository.new(invoice_path)
  end

  def self.from_csv(data)
    return SalesEngine.new(data[:items], data[:merchants], data[:invoices])
  end

	def analyst
		return SalesAnalyst.new(items, merchants, invoices)
	end

end
