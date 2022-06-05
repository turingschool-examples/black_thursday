class SalesEngine
  attr_reader :item_repository,
              :merchant_repository,
              :invoice_repository,
              :customer_repository

  def initialize(items_path, merchants_path, invoices_path, customers_path)
    @item_repository = ItemRepository.new(items_path)
    @merchant_repository = MerchantRepository.new(merchants_path)
    @invoice_repository = InvoiceRepository.new(invoices_path)
    @customer_repository = CustomerRepository.new(customers_path)
  end

  def self.from_csv(data)
    SalesEngine.new(data[:items], data[:merchants], data[:invoices], data[:customers])
  end

  def analyst
    SalesAnalyst.new(@item_repository, @merchant_repository, @invoice_repository, @customer_repository)
  end
end
