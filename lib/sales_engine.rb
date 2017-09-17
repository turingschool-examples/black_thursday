
require_relative "item_repository"
require_relative "merchant_repository"
require_relative "invoice_repository"
require_relative "invoice_item_repository"
require_relative "transaction_repository"
require_relative "customer_repository"
require_relative "sales_analyst"

class SalesEngine
  attr_reader :items, :merchants, :invoices, :invoice_items, :transactions, :customers

  def self.from_csv(file_names)
    @item_file = file_names[:items]
    @merchant_file = file_names[:merchants]
    @invoice_file = file_names[:invoices]
    @invoice_item_file = file_names[:invoice_items]
    @transaction_file = file_names[:transactions]
    @customer_file = file_names[:customers]
    SalesEngine.new(@item_file,
                    @merchant_file,
                    @invoice_file,
                    @invoice_item_file,
                    @transaction_file,
                    @customer_file)
  end

  def initialize(item_csv, merchant_csv, invoice_csv, invoice_items_csv, transaction_csv, customer_csv)
    @items = ItemRepository.new(self, item_csv)
    @merchants = MerchantRepository.new(self, merchant_csv)
    @invoices = InvoiceRepository.new(self, invoice_csv)
    @invoice_items = InvoiceItemRepository.new(self, invoice_items_csv)
    @transactions = TransactionRepository.new(self, transaction_csv)
    @customers = CustomerRepository.new(self, customer_csv)
  end
end
