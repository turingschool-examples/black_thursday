require_relative "item_repository"
require_relative "merchant_repository"
require_relative "invoice_repository"
require_relative "customer_repository"
require_relative "transaction_repository"
require_relative "invoice_item_repository"

class SalesEngine

  attr_accessor :items,
                :merchants,
                :invoices,
                :customers,
                :transactions,
                :invoice_items

  def initialize
    @items         = ItemRepository.new(self)
    @merchants     = MerchantRepository.new(self)
    @invoices      = InvoiceRepository.new(self)
    @customers     = CustomerRepository.new(self)
    @transactions  = TransactionRepository.new(self)
    @invoice_items = InvoiceItemRepository.new(self)
  end

  def self.from_csv(repo)
    se = SalesEngine.new
    se.items.populate(repo[:items]) if repo[:items]
    se.merchants.populate(repo[:merchants]) if repo[:merchants]
    se.invoices.populate(repo[:invoices]) if repo[:invoices]
    se.customers.populate(repo[:customers]) if repo[:customers]
    se.transactions.populate(repo[:transactions]) if repo[:transactions]
    se.invoice_items.populate(repo[:invoice_items]) if repo[:invoice_items]
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

  def find_item_ids_from_invoice_id(id)
    @invoice_items.find_all_by_invoice_id(id)
  end

  def find_all_items_by_item_id(item_id)
    @items.find_by_id(item_id)
  end

  def find_transaction_by_invoice_id(invoice_id)
    @transactions.find_all_by_invoice_id(invoice_id)
  end

  def find_customer_by_customer_id(customer_id)
    @customers.find_by_id(customer_id)
  end

  def find_by_invoice_id(invoice_id)
    @invoices.find_by_id(invoice_id)
  end

  def find_invoices_by_customer_id(customer_id)
    @invoices.find_all_by_customer_id(customer_id)
  end

  def find_invoice_item_id(id)
    @invoice_items.find_all_by_invoice_id(id)
  end

end
