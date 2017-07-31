require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'

class SalesEngine

  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(files)
    @items = new_items_if(files[:items])
    @merchants = new_merchants_if(files[:merchants])
    @invoices = new_invoices_if(files[:invoices])
    @invoice_items = new_invoice_items_if(files[:invoice_items])
    @transactions = new_transactions_if(files[:transactions])
    @customers = new_customers_if(files[:customers])
  end

  def self.from_csv(files = {})
    SalesEngine.new(files)
  end

  def initialize_if_it_exists(repository_proc, file)
    if !(file.nil?)
      repository_proc.call(file)
    else
      nil
    end
  end

  def new_items_if(item_file)
    item_proc = Proc.new {|file| ItemRepository.new(file, self)}
    initialize_if_it_exists(item_proc, item_file)
  end

  def new_merchants_if(merchant_file)
    merchant_proc = Proc.new {|file| MerchantRepository.new(file, self)}
    initialize_if_it_exists(merchant_proc, merchant_file)
  end

  def new_invoices_if(invoice_file)
    invoice_proc = Proc.new {|file| InvoiceRepository.new(file, self)}
    initialize_if_it_exists(invoice_proc, invoice_file)
  end

  def new_invoice_items_if(invoice_item_file)
    invoice_item_proc = Proc.new {|file| InvoiceItemRepository.new(file, self)}
    initialize_if_it_exists(invoice_item_proc, invoice_item_file)
  end

  def new_transactions_if(transaction_file)
    transaction_proc = Proc.new {|file| TransactionRepository.new(file, self)}
    initialize_if_it_exists(transaction_proc, transaction_file)
  end

  def new_customers_if(customer_file)
    customer_proc = Proc.new {|file| CustomerRepository.new(file, self)}
    initialize_if_it_exists(customer_proc, customer_file)
  end

  def merchant_by_merchant_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def items_by_merchant_id(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end

  def invoices_by_merchant_id(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
  end

  def items_by_invoice_id(invoice_id)
    invoice_items = invoice_items_by_invoice_id(invoice_id)
    items.items_by_invoice_id(invoice_items)
  end

  def invoice_items_by_invoice_id(invoice_id)
    invoice_items.find_all_by_invoice_id(invoice_id)
  end

  def transactions_by_invoice_id(invoice_id)
    transactions.find_all_by_invoice_id(invoice_id)
  end

  def customer_by_customer_id(customer_id)
    customers.find_by_id(customer_id)
  end

  def invoice_by_invoice_id(invoice_id)
    invoices.find_by_id(invoice_id)
  end

end
