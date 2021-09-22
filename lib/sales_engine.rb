# frozen_string_literal: true
require_relative "../lib/item_repository"
require_relative "../lib/merchant_repo"
require_relative "../lib/invoice_repo"
require_relative "../lib/sales_analyst"
require_relative "../lib/customer_repo"
require_relative "../lib/invoice_item_repo"
require_relative "../lib/transaction_repo"

class SalesEngine
  attr_reader   :items,
                :merchants,
                :customers,
                :invoices,
                :invoice_items,
                :transactions

  def initialize(item_path, merchant_path, customer_path, invoice_path, invoice_item_path, transaction_path)
    @items = ItemRepository.new(item_path)
    @merchants = MerchantRepo.new(merchant_path)
    @customers = CustomerRepo.new(customer_path)
    @invoices = InvoiceRepo.new(invoice_path)
    @invoice_items = InvoiceItemRepo.new(invoice_item_path)
    @transactions = TransactionRepo.new(transaction_path)
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

  def analyst
    SalesAnalyst.new(@items, @merchants, @customers, @invoices, @invoice_items, @transactions)
  end
end
