class SalesEngine
  attr_reader :item_repository,
              :merchant_repository,
              :invoice_repository,
              :invoice_items_repository

  def initialize(items_path, merchants_path, invoices_path, invoice_items_path)
    @item_repository = ItemRepository.new(items_path)
    @merchant_repository = MerchantRepository.new(merchants_path)
    @invoice_repository = InvoiceRepository.new(invoices_path)
    @invoice_items_repository = InvoiceItemRepository.new(invoice_items_path)
  end

  def self.from_csv(data)
    SalesEngine.new(data[:items], data[:merchants], data[:invoices], data[:invoice_items])
  end

  def analyst
    SalesAnalyst.new(@item_repository, @merchant_repository, @invoice_repository, @invoice_items_repository)
  end
end
