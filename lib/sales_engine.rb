require 'Csv'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_analyst'
require_relative '../lib/transaction_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/customer_repository'

class SalesEngine

  attr_reader :items,
              :merchants,
              :invoices,
              :transactions,
              :invoice_items,
              :customers

  def initialize
    @items = ItemRepository.new
    @merchants = MerchantRepository.new
    @invoices = InvoiceRepository.new
    @transactions = TransactionRepository.new
    @invoice_items = InvoiceItemRepository.new
    @customers = CustomerRepository.new
  end

  def self.from_csv(file_path_hash)
    se = SalesEngine.new
    repo_hash = {}
    #is there a way to do this dynamically?
    if file_path_hash[:items] != nil
      repo_hash[:items] = CSV.read(file_path_hash[:items],
      headers: true, header_converters: :symbol)
      se.create_and_populate_item_repo(repo_hash[:items])
    end
    if file_path_hash[:merchants] != nil
      repo_hash[:merchants] = CSV.read(file_path_hash[:merchants],
      headers: true, header_converters: :symbol)
      se.create_and_populate_merchant_repo(repo_hash[:merchants])
    end
    if file_path_hash[:invoices] != nil
      repo_hash[:invoices] = CSV.read(file_path_hash[:invoices],
      headers: true, header_converters: :symbol)
      se.create_and_populate_invoice_repo(repo_hash[:invoices])
    end
    if file_path_hash[:invoice_items] != nil
      repo_hash[:invoice_items] = CSV.read(file_path_hash[:invoice_items],
      headers: true, header_converters: :symbol)
      se.create_and_populate_invoice_item_repo(repo_hash[:invoice_items])
    end
    if file_path_hash[:transactions] != nil
      repo_hash[:transactions] = CSV.read(file_path_hash[:transactions],
      headers: true, header_converters: :symbol)
      se.create_and_populate_transaction_repo(repo_hash[:transactions])
    end
    if file_path_hash[:customers] != nil
      repo_hash[:customers] = CSV.read(file_path_hash[:customers],
      headers: true, header_converters: :symbol)
      se.create_and_populate_customer_repo(repo_hash[:customers])
    end
    return se
  end

  def create_and_populate_item_repo(items_objs)
    items_objs.each do |item|
      @items.create(item)
    end
  end

  def create_and_populate_merchant_repo(merchant_objs)
    merchant_objs.each do |item|
      @merchants.create(item)
    end
  end

  def create_and_populate_invoice_repo(invoice_objs)
    invoice_objs.each do |item|
      @invoices.create(item)
    end
  end

  def create_and_populate_invoice_item_repo(invoice_item_objs)
    invoice_item_objs.each do |item|
      @invoice_items.create(item)
    end
  end

  def create_and_populate_transaction_repo(transaction_objs)
    transaction_objs.each do |item|
      @transactions.create(item)
    end
  end

  def create_and_populate_customer_repo(customer_objs)
    customer_objs.each do |item|
      @customers.create(item)
    end
  end

  def analyst
    SalesAnalyst.new(@items, @merchants, @invoices, @transactions, @invoice_items, @customers)
  end
end
