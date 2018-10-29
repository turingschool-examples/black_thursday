require 'csv'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/customer_repository'
require_relative '../lib/invoice_item_repo'
require_relative './sales_analyst'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :transactions,
              :customers,
              :invoice_items
              :analyst


  def initialize(items, merchants, invoices, transactions, customers, invoice_items)
    @items = ItemRepository.new(populate_items(items))
    @merchants = MerchantRepository.new(populate_merchants(merchants))
    @invoices = InvoiceRepository.new(populate_invoices(invoices))
    @transactions = TransactionRepository.new(populate_transactions(transactions))
    @customers = CustomerRepository.new(populate_customers(customers))
    @invoice_items = InvoiceItemRepository.new(populate_invoice_item(invoice_items))
    @analyst = SalesAnalyst.new(@items, @merchants, @invoices, @transactions)
  end

  def self.from_csv(info)
    info[:items] ? items = info[:items] : items = nil
    info[:merchants] ? merchants = info[:merchants] : merchants = nil
    info[:invoices] ? invoices = info[:invoices] : invoices = nil
    info[:transactions] ? transactions = info[:transactions] : transactions = nil
    info[:customers] ? customers = info[:customers] : customers = nil
    info[:invoice_items] ? invoice_items = info[:invoice_items] : invoice_items = nil
    self.new(items, merchants, invoices, transactions, customers)
  end

  def populate_invoices(file_path)
    if file_path
      file = CSV.read(file_path, headers: true, header_converters: :symbol)
      file.map do |row|
        Invoice.new(row)
      end
    end
  end

  def populate_merchants(file_path)
    if file_path
      file = CSV.read(file_path, headers: true, header_converters: :symbol )
      file.map do |row|
        Merchant.new(row)
      end
    end
  end

  def populate_items(file_path)
    if file_path
      file = CSV.read(file_path, headers: true, header_converters: :symbol )
      file.map do |row|
        Item.new(row)
      end
    end
  end

  def populate_invoice_item(file_path)
    if file_path
      file = CSV.read(file_path, headers: true, header_converters: :symbol)
      file.map do |row|
       InvoiceItem.new(row)
      end
    end
  end

  def populate_transactions(file_path)
    if file_path
      file = CSV.read(file_path, headers: true, header_converters: :symbol )
      file.map do |row|
        Transaction.new(row)
      end
    end
  end

  def populate_customers(file_path)
    if file_path
      file = CSV.read(file_path, headers: true, header_converters: :symbol )
      file.map do |row|
        Customer.new(row)
      end
    end
  end

end
