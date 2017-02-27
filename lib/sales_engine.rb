require_relative "merchant_repository"
require_relative "item_repository"
require_relative "invoice_repository"
require_relative "invoice_item_repository"
require_relative "transaction_repository"
require_relative "customer_repository"

class SalesEngine
    attr_accessor :paths, :items, :merchants, :invoices, :invoice_items, :transactions, :customers
  def initialize (hash)
    @paths = hash
    @items = ItemRepository.new(@paths[:items], self) unless @paths[:items] == nil
    @merchants = MerchantRepository.new(@paths[:merchants], self) unless @paths[:merchants] == nil
    @invoices = InvoiceRepository.new(@paths[:invoices], self) unless @paths[:invoices] == nil
    @invoice_items = InvoiceItemRepository.new(@paths[:invoice_items], self) unless @paths[:invoice_items] == nil
    @transactions = TransactionRepository.new(@paths[:transactions], self) unless @paths[:transactions] == nil
    @customers = CustomerRepository.new(@paths[:customers], self) unless @paths[:customers] == nil
  end

  def self.from_csv(hash)
    files = hash.each_pair do |key, value|
      @paths[key] = value
    end
    SalesEngine.new(files)
  end
end
