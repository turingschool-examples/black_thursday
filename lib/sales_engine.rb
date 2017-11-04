require 'pry'
require_relative "item_repository"
require_relative "merchant_repository"
require_relative "invoice_repository"
require_relative "customer_repository"
require_relative "transaction_repository"
require_relative "invoice_item_repository"


class SalesEngine

  attr_accessor   :items,
                  :merchants,
                  :invoices,
                  :customers,
                  :transactions,
                  :invoice_items

  def initialize
    @items                    = ItemRepository.new(self)
    @merchants                = MerchantRepository.new(self)
    @invoices                 = InvoiceRepository.new(self)
    @customers                = CustomerRepository.new(self)
    @transactions             = TransactionRepository.new(self)
    @invoice_item_repository  = InvoiceItemRepository.new(self)
  end

  def self.from_csv(repo)
    items_CSV = repo[:items]
    merchants_CSV = repo[:merchants]
    invoices_CSV = repo[:invoices]
    customers_CSV = repo[:customers]
    transactions_CSV = repo[:transactions]
    inv_item_CSV = rep[:invoice_items]

    se = SalesEngine.new
    se.items.populate(items_CSV)
    se.merchants.populate(merchants_CSV)
    se.invoices.populate(invoices_CSV)
    se.customers.populate(customers_CSV)
    se.transactions.populate(transactions_CSV)
    se.invoice_item_repository.populate(inv_item_CSV)
    return se
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def find_merchant_by_id(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

  def find_invoices_for_merchant(merchant_id)
    @invoices.find_all_by_merchant_id(merchant_id)
  end

  def find_merchant_for_invoice(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

end
