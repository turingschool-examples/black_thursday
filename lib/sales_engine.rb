require_relative './item_repo'
require_relative './merchant_repo'
require_relative './invoice_repo'
require_relative './invoice_item_repo'
require_relative './customer_repo'
require_relative './transaction_repo'
require_relative './file_loader'
require 'CSV'
require 'pry'

class SalesEngine
  attr_reader :merchant_repo,
              :item_repo,
              :invoice_repo,
              :invoice_item_repo,
              :customer_repo,
              :transaction_repo

  def initialize(csv_path_info)
    # we use <type>_repo, rather than just the type
    # as we find this to be clearer
    # e.g. merchant_repo rather than merchants
    @merchant_repo     = MerchantRepo.new(self)
    @item_repo         = ItemRepo.new(self)
    @invoice_repo      = InvoiceRepo.new(self)
    @invoice_item_repo = InvoiceItemRepo.new(self)
    @customer_repo     = CustomerRepo.new(self)
    @transaction_repo  = TransactionRepo.new(self)
    file_loader        = FileLoader.new(self)
    if csv_path_info.class == Hash
      file_loader.load_repos_from_csv(csv_path_info)
    end
  end

  def self.from_csv(csv_path_info)
    self.new(csv_path_info)
  end

  def items
    @item_repo
  end

  def merchants
    @merchant_repo
  end

  def invoices
    @invoice_repo
  end

  def invoice_items
    @invoice_item_repo
  end

  def customers
    @customer_repo
  end

  def transactions
    @transaction_repo
  end

  def all_merchants
    @merchant_repo.all
  end

  def all_items
    @item_repo.all
  end

  def all_invoices
    @invoice_repo.all
  end

  def all_invoice_items
    @invoice_item_repo.all
  end

  def all_customers
    @customer_repo.all
  end

  def all_transactions
    @transaction_repo.all
  end

  # these methods are for passing child queries
  # into other repos

  def find_all_items_by_merchant_id(merchant_id)
    @item_repo.find_all_by_merchant_id(merchant_id)
  end

  def find_item_by_item_id(item_id)
    @item_repo.find_by_id(item_id)
  end

  def find_merchant_by_merchant_id(merchant_id)
    @merchant_repo.find_by_id(merchant_id)
  end

  def find_invoices_by_merchant_id(merchant_id)
    @invoice_repo.find_all_by_merchant_id(merchant_id)
  end

  def find_invoice_items_by_invoice_id(invoice_id)
    @invoice_item_repo.find_all_by_invoice_id(invoice_id)
  end

  def find_invoices_by_customer_id(customer_id)
    @invoice_repo.find_all_by_customer_id(customer_id)
  end

  def find_customer_by_customer_id(customer_id)
    @customer_repo.find_by_id(customer_id)
  end

  def find_transactions_by_invoice_id(invoice_id)
    @transaction_repo.find_all_by_invoice_id(invoice_id)
  end

  def find_invoice_by_invoice_id(invoice_id)
    @invoice_repo.find_by_id(invoice_id)
  end

end
