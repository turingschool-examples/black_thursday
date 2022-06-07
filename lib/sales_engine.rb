require_relative 'entry'
class SalesEngine
  attr_reader :item_repository,
              :merchant_repository,
              :invoice_repository,
              :invoice_item_repository,
              :transaction_repository,
              :customer_repository
  def initialize
    @item_repository = ItemRepository.new("./data/items.csv")
    @merchant_repository = MerchantRepository.new("./data/merchants.csv")
    @invoice_repository = InvoiceRepository.new("./data/invoices.csv")
    @invoice_item_repository = InvoiceItemRepository.new("./data/invoice_items.csv")
    @transaction_repository = TransactionRepository.new("./data/transactions.csv")
    @customer_repository = CustomerRepository.new("./data/customers.csv")
  end

  def self.from_csv(data)
    SalesEngine.new
  end

  def analyst
    SalesAnalyst.new
  end

  def merchants
    @merchant_repository
  end
end
