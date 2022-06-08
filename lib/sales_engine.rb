class SalesEngine
  attr_reader :item_repository,
              :merchant_repository,
              :invoice_repository,
              :invoice_item_repository,
              :customer_repository,
              :transaction_repository

  def initialize(items_path, merchants_path, invoices_path, invoice_items_path, customers_path, transactions_path)
    @item_repository = ItemRepository.new(items_path)
    @merchant_repository = MerchantRepository.new(merchants_path)
    @invoice_repository = InvoiceRepository.new(invoices_path)
    @invoice_item_repository = InvoiceItemRepository.new(invoice_items_path)
    @customer_repository = CustomerRepository.new(customers_path)
    @transaction_repository = TransactionRepository.new(transactions_path)
  end

  def self.from_csv(data)
    SalesEngine.new(data[:items], data[:merchants], data[:invoices], data[:invoice_items], data[:customers], data[:transactions])
  end

  def analyst
    SalesAnalyst.new(@item_repository, @merchant_repository, @invoice_repository, @invoice_item_repository, @customer_repository, @transaction_repository )
  end
end
