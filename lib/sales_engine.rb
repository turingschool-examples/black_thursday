class SalesEngine
  attr_reader :item_repository, :merchant_repository, :analyst, :invoice_repository, :invoice_item_repository

  def initialize(items_path, merchants_path, invoice_path, invoice_items_path)
    @item_repository = ItemRepository.new(items_path)
    @merchant_repository = MerchantRepository.new(merchants_path)
    @analyst = SalesAnalyst.new(@item_repository, @merchant_repository)
    @invoice_repository = InvoiceRepository.new(invoice_path)
    @invoice_item_repository = InvoiceItemRepository.new(invoice_items_path)
  end

  def self.from_csv(data)
    SalesEngine.new(data[:items], data[:merchants], data[:invoice], data[:invoice_items])
  end


end
