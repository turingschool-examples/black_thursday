require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/customer_repository'

# sales engine class
class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def self.from_csv(files)
    new(files)
  end

  def initialize(files)
    @items = ItemRepository.new(files[:items], self)
    @merchants = MerchantRepository.new(files[:merchants], self)
    @invoices = InvoiceRepository.new(files[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(files[:invoice_items], self)
    @transactions = TransactionRepository.new(files[:transactions], self)
    @customers = CustomerRepository.new(files[:customers], self)
  end

  def pass_merchant_id_to_merchant_repo(id)
    @merchants.find_by_id(id)
  end

  def pass_id_to_item_repo(id)
    @items.find_all_by_merchant_id(id)
  end

  def pass_id_to_invoice_repo(id)
    @invoices.find_all_by_merchant_id(id)
  end
end
