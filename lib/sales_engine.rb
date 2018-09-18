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

    file_path_hash.each do |key, value|
      eval('se.create_and_populate_' + key.to_s[0..-2] + '_repo(' + 'value' + ')')
    end
    
    return se
  end

  def create_and_populate_item_repo(file_path)
    CSV.read(
      file_path,
      headers: true,
      header_converters: :symbol
    ).each do |item|
      @items.create(item)
    end
  end

  def create_and_populate_merchant_repo(file_path)
    CSV.read(
      file_path,
      headers: true,
      header_converters: :symbol
    ).each do |element|
      @merchants.create(element)
    end
  end

  def create_and_populate_invoice_repo(file_path)
    CSV.read(
      file_path,
      headers: true,
      header_converters: :symbol
    ).each do |element|
      @invoices.create(element)
    end
  end

  def create_and_populate_invoice_item_repo(file_path)
    CSV.read(
      file_path,
      headers: true,
      header_converters: :symbol
    ).each do |element|
      @invoice_items.create(element)
    end
  end

  def create_and_populate_transaction_repo(file_path)
    CSV.read(
      file_path,
      headers: true,
      header_converters: :symbol
    ).each do |element|
      @transactions.create(element)
    end
  end

  def create_and_populate_customer_repo(file_path)
    CSV.read(
      file_path,
      headers: true,
      header_converters: :symbol
    ).each do |element|
      @customers.create(element)
    end
  end

  def analyst
    args = {
      items: @items,
      merchants: @merchants,
      invoices: @invoices,
      transactions: @transactions,
      invoice_items: @invoice_items,
      customers: @customers
    }
    SalesAnalyst.new(args)
  end
end
