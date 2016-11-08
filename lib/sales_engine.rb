require_relative '../lib/merchant_repo'
require_relative "../lib/item_repo"
require_relative "../lib/invoice_repo"
require_relative "../lib/customer_repo"
require_relative "../lib/transaction_repo"
require_relative "../lib/invoice_item_repo"
require 'csv'
require 'pry'

class SalesEngine

  attr_reader   :files, 
                :items, 
                :merchants, 
                :invoices, 
                :customers, 
                :transactions, 
                :invoice_items
  attr_accessor :merchant_repo, 
                :item_repo,
                :invoice_repo,
                :customers,
                :transactions,
                :invoice_items
  

  def self.from_csv(files)
    @merchant_repo     = MerchantRepo.new(files[:merchants], self)
    @item_repo         = ItemRepo.new(files[:items], self)
    @invoice_repo      = InvoiceRepo.new(files[:invoices], self)
    @customer_repo     = CustomerRepo.new(files[:customers], self)
    @transaction_repo  = TransactionRepo.new(files[:transactions], self)
    @invoice_item_repo = InvoiceItemRepo.new(files[:invoice_items], self)
    self
  end

  def self.merchants
    @merchant_repo
  end

  def self.items
    @item_repo
  end

  def self.invoices
    @invoice_repo
  end

  def self.customers
    @customer_repo
  end

  def self.transactions
    @transaction_repo
  end

  def self.invoice_items
    @invoice_item_repo
  end

  def self.total_merchants
    @merchant_repo.all.length
  end

  def self.total_invoices
    @invoice_repo.all.length
  end

  def self.total_customers
    @customer_repo.all.length
  end

  def total_transactions
    @transaction_repo.all.length
  end

  def self.find_all_by_merchant_id(id)
    @item_repo.find_all_by_merchant_id(id)
  end

  def self.find_all_invoices_by_id(merchant_id)
    @invoice_repo.find_all_by_merchant_id(merchant_id)
  end

  def self.find_invoice_items(id)
    @invoice_item_repo.find_all_by_invoice_id(id)
  end

  def self.find_merchant_for_item(merchant_id)
    @merchant_repo.find_by_id(merchant_id)
  end

  def self.find_items_for_invoice(item_id)
    @item_repo.find_by_id(item_id)
  end

  def self.find_merchant_for_invoice(merchant_id)
    @merchant_repo.find_by_id(merchant_id)
  end

  def self.find_invoice_for_transaction(invoice_id)
    @invoice_repo.find_by_id(invoice_id)
  end

  def self.find_transactions_by_id(id)
    @transaction_repo.find_all_by_invoice_id(id)
  end

  def self.find_customer_from_invoice(customer_id)
   @customer_repo.find_by_id(customer_id)
  end

  def self.find_customers(customer_id)
    @customer_repo.find_by_id(customer_id)
  end

end