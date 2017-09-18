require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'customer_repository'
require_relative 'transaction_repository'

class SalesEngine

  attr_reader :items, :merchants, :invoices, :customers, :transactions

  def self.from_csv(csv_file_paths)
    item_file_path = csv_file_paths[:items]
    merchant_file_path = csv_file_paths[:merchants]
    invoice_file_path = csv_file_paths[:invoices]
    customer_file_path = csv_file_paths[:customers]
    transaction_file_path = csv_file_paths[:transactions]

    SalesEngine.new(item_file_path, merchant_file_path, invoice_file_path, customer_file_path, transaction_file_path)
  end


  def initialize(item_file_path, merchant_file_path, invoice_file_path, customer_file_path, transaction_file_path)
    @items = ItemRepository.new(item_file_path, self)
    @merchants = MerchantRepository.new(merchant_file_path, self)
    @invoices = InvoiceRepository.new(invoice_file_path, self)
    @customers = CustomerRepository.new(customer_file_path, self)
    @transactions = TransactionRepository.new(transaction_file_path, self)
  end

  def item_list
    @items.items
  end

  def merchant_list
    @merchants.merchants
  end

  def invoice_list
    @invoices.invoices
  end

  def transaction_list
    @transactions.transactions
  end

  # def inspect
  #   "#<#{self.class} #{@items.size} rows>"
  # end


end
