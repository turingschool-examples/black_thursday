require_relative "../lib/item_repository"
require_relative "../lib/merchant_repo"
require_relative "../lib/invoice_repo"
require_relative "../lib/sales_analyst"

class SalesEngine
  attr_reader   :item_path,
                :merchant_path,
                :customer_path,
                :invoice_path,
                :invoice_item_path,
                :transaction_path

  def initialize(item_path, merchant_path, customer_path, invoice_path, invoice_item_path, transaction_path)
    @item_path          = item_path
    @merchant_path      = merchant_path
    @customer_path      = customer_path
    @invoice_path       = invoice_path
    @invoice_item_path  = invoice_item_path
    @transaction_path   = transaction_path
  end

  def self.from_csv(file_path)
    item_path      = file_path[:items]
    merchant_path  = file_path[:merchants]
    customer_path  = file_path[:customers]
    invoice_path   = file_path[:invoices]
    invoice_item_path = file_path[:invoice_items]
    transaction_path = file_path[:transactions]

    SalesEngine.new(item_path, merchant_path, customer_path, invoice_path, invoice_item_path, transaction_path)
  end

  def merchants
    MerchantRepo.new(@merchant_path)
  end

  def items
    ItemRepository.new(@item_path)
  end

  def invoices
    InvoiceRepo.new(@invoice_path)
  end

  def customers
    CustomerRepo.new(@customer_path)
  end

  def invoice_items
    InvoiceItemRepo.new(@invoice_item_path)
  end

  def transactions
    TransactionRepo.new(@transaction_path)
  end

  def analyst
    SalesAnalyst.new(items, merchants, customers, invoices, invoice_items, transactions)
  end
end
