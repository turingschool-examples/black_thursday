require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require_relative 'load_data'

class SalesEngine
  attr_reader :repo_rows
  attr_accessor :items, :merchants, :invoices, :invoice_items, :transactions, :customers

  def initialize(repo_rows)
    start_up_engine(repo_rows)
  end

  def self.from_csv(csv_hash)
    repo_rows = csv_hash.map do |type, filename|
      [type, LoadData.load_data(filename)]
    end.to_h
    SalesEngine.new(repo_rows)
  end

  def start_up_engine(repo_rows)
    load_merchants_repo(repo_rows) if repo_rows[:merchants]
    load_items_repo(repo_rows) if repo_rows[:items]
    load_invoice_repo(repo_rows) if repo_rows[:invoices]
    load_invoice_item_repo(repo_rows) if repo_rows[:invoice_items]
    load_transaction_repo(repo_rows) if repo_rows[:transactions]
    load_customer_repo(repo_rows) if repo_rows[:customers]
  end

  def load_merchants_repo(repo_rows)
    @merchants  ||= MerchantRepository.new(repo_rows[:merchants])
  end

  def load_items_repo(repo_rows)
    @items      ||= ItemRepository.new(repo_rows[:items])
    if repo_rows[:merchants]
      items_to_merchants
      merchants_to_items
    end
  end

  def load_invoice_repo(repo_rows)
    @invoices   ||= InvoiceRepository.new(repo_rows[:invoices])
    if repo_rows[:merchants]
      invoices_to_merchants
      merchants_to_invoices
    end
  end

  def load_invoice_item_repo(repo_rows)
    @invoice_items ||= InvoiceItemRepository.new(repo_rows[:invoice_items])
    if repo_rows[:items] && repo_rows[:invoices]
      items_to_invoice
      item_price_quantity
    end
  end

  def load_transaction_repo(repo_rows)
    @transactions ||= TransactionRepository.new(repo_rows[:transactions])
    if repo_rows[:invoices]
      transactions_to_invoice
      invoice_to_transaction
    end
  end

  def load_customer_repo(repo_rows)
    @customers ||= CustomerRepository.new(repo_rows[:customers])
    if repo_rows[:invoices]
      customers_to_invoice
      merchants_to_customer
      customers_to_merchants
    end
  end

  def items_to_merchants
    merchants.all.map { |merchant|
      merchant.items = items.find_all_by_merchant_id(merchant.id)}
  end

  def merchants_to_items
    items.all.map { |item|
      item.merchant = merchants.find_by_id(item.merchant_id)}
  end

  def invoices_to_merchants
    merchants.all.map { |merchant|
      merchant.invoices = invoices.find_all_by_merchant_id(merchant.id)}
  end

  def merchants_to_invoices
    invoices.all.map { |invoice|
      invoice.merchant = merchants.find_by_id(invoice.merchant_id)}
  end

  def item_to_invoice_item
    invoice_items.all.map { |invoice_item|
      invoice_item.item = items.find_by_id(invoice_item.item_id)}
  end

  def items_to_invoice
    item_to_invoice_item
    invoices.all.map do |invoice|
      invoice.items = invoice_items.find_all_by_invoice_id(invoice.id).map(&:item)
    end
  end

  def item_to_price_array(all_items)
    all_items.map do |invoice_item|
      [invoice_item.unit_price, invoice_item.quantity]
    end
  end

  def item_price_quantity
     invoices.all.map do |invoice|
       all_items = invoice_items.find_all_by_invoice_id(invoice.id)
       invoice.item_price_quantity = item_to_price_array(all_items)
     end
  end

  def transactions_to_invoice
    invoices.all.map do |invoice|
      invoice.transactions =  transactions.find_all_by_invoice_id(invoice.id)
    end
  end

  def invoice_to_transaction
    transactions.all.map do |transaction|
      transaction.invoice =  invoices.find_by_id(transaction.invoice_id)
    end
  end

  def merchants_to_customer
    customers.all.map do |customer|
      customer.merchants = invoices.find_all_by_customer_id(customer.id).map(&:merchant)
    end
  end

  def customers_to_invoice
    invoices.all.map do |invoice|
      invoice.customer =  customers.find_by_id(invoice.customer_id)
    end
  end

  def customers_to_merchants
    merchants.all.map do |merchant|
      merchant.customers = invoices.find_all_by_merchant_id(merchant.id).map(&:customer).uniq
    end
  end

end
