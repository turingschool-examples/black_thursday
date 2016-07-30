require "csv"
require_relative "../lib/item_repo"
require_relative "../lib/merchant_repo"
require_relative "../lib/invoice_repo"
require_relative "../lib/transaction_repo"
require_relative "../lib/customer_repo"

class SalesEngine

  def self.from_csv(files)
    SalesEngine.new(files)
  end

  def initialize(files)
    @files = files
  end

  def merchants
    @merchants = MerchantsRepo.new(@files[:merchants], self)
  end

  def items
    @items = ItemRepo.new(@files[:items], self)
  end

  def invoices
    @invoices = InvoiceRepo.new(@files[:invoices], self)
  end

  def transactions
    @transactions = TransactionRepo.new(@files[:transactions], self)
  end

  def customers
    @customers = CustomerRepo.new(@files[:customers], self)
  end

  def find_merchant_by_id(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

  def find_items_by_merchant_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def find_invoices_by_merchant_id(merchant_id)
    @invoices.find_all_by_merchant_id(merchant_id)
  end
end
