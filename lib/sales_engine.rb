require_relative './merchant_repository'
require_relative './item_repository'
require_relative './invoice_repository'
require_relative './invoice_item_repository'
require_relative './transaction_repository'
require_relative './sales_analyst'


class SalesEngine
  attr_reader :merchants, :items, :invoices, :invoice_items, :transactions, :customers

  def initialize(merch_repo, item_repo, invoice_repo, invoice_item_repo, transaction_repo, customer_repo)
    @merchants         = merch_repo
    @items             = item_repo
    @invoices          = invoice_repo
    @invoice_items     = invoice_item_repo
    @transactions      = transaction_repo
    @customers         = customer_repo
  end

  def self.from_csv(csv_data_paths)
    merch_repo        = MerchantRepository.new(csv_data_paths[:merchants])
    item_repo         = ItemRepository.new(csv_data_paths[:items])
    invoice_repo      = InvoiceRepository.new(csv_data_paths[:invoices])
    invoice_item_repo = InvoiceItemRepository.new(csv_data_paths[:invoice_items])
    transaction_repo  = TransactionRepository.new(csv_data_paths[:transactions])
    customer_repo     = CustomerRepository.new(csv_data_paths[:customers])
    self.new(merch_repo, item_repo, invoice_repo, invoice_item_repo, transaction_repo, customer_repo)
  end

  def analyst
    SalesAnalyst.new(@merchants, @items, @invoices, @invoice_items)
  end

end
