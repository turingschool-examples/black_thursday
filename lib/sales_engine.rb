require 'csv'
require 'Time'
require 'bigdecimal'

require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'sales_analyst'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'
require_relative 'transaction_repository'

require 'pry'

class SalesEngine
  attr_reader :items, :merchants, :invoices, :invoice_items, :customers, :transactions
  def initialize(item_repository, merchant_repository, invoice_repository, invoice_items_repository, customers_repository, transactions_repository)
    @items = item_repository
    @merchants = merchant_repository
    @invoices = invoice_repository
    @invoice_items = invoice_items_repository
    @customers = customers_repository
    @transactions = transactions_repository
  end

  def self.from_csv(file_hash)
    items_file = CSV.read(file_hash[:items], headers: true, header_converters: :symbol)
    merchants_file = CSV.read(file_hash[:merchants], headers: true, header_converters: :symbol)
    invoices_file = CSV.read(file_hash[:invoices], headers: true, header_converters: :symbol)
    invoice_items_file = CSV.read(file_hash[:invoice_items], headers: true, header_converters: :symbol)
    customers_file = CSV.read(file_hash[:customers], headers: true, header_converters: :symbol)
    transactions_file = CSV.read(file_hash[:transactions], headers: true, header_converters: :symbol)

    item_repository = ItemRepository.new
    merchant_repository = MerchantRepository.new
    invoice_repository = InvoiceRepository.new
    invoice_items_repository = InvoiceItemRepository.new
    customers_repository = CustomerRepository.new
    transactions_repository = TransactionRepository.new

    merchants_file.each do |row|
      merchant_repository.create(build_merchant_args_from_row(row))
    end

    items_file.each do |row|
      item_repository.create(build_item_args_from_row(row))
    end

    invoices_file.each do |row|
      invoice = build_invoice_args_from_row(row)
      invoice_repository.create(invoice)
    end

    invoice_items_file.each do |row|
      invoice_item = build_invoice_item_from_row(row)
      invoice_items_repository.create(invoice_item)
    end

    customers_file.each do |row|
      customer = build_customer_from_row(row)
      customers_repository.create(customer)
    end

    transactions_file.each do |row|
      transaction = build_transaction_from_row(row)
      transactions_repository.create(transaction)
    end

    self.new(item_repository, merchant_repository, invoice_repository, invoice_items_repository, customers_repository, transactions_repository)
  end

  def self.build_item_args_from_row(row)
    {
      :id          => row[:id].to_i,
      :name        => row[:name],
      :description => row[:description],
      :unit_price  => BigDecimal.new(row[:unit_price],4) / 100,
      :created_at  => Time.parse(row[:created_at]),
      :updated_at  => Time.parse(row[:updated_at]),
      :merchant_id => row[:merchant_id].to_i
      }
  end

  def self.build_merchant_args_from_row(row)
    {
      id: row[:id].to_i,
      name: row[:name],
      created_at: row[:created_at],
      updated_at: row[:updated_at]
    }
  end

  def self.build_invoice_args_from_row(row)
    {
      id: row[:id].to_i,
      customer_id: row[:customer_id].to_i,
      merchant_id: row[:merchant_id].to_i,
      status: row[:status].to_sym,
      created_at: Time.parse(row[:created_at]),
      updated_at: Time.parse(row[:updated_at])
    }
  end

  def self.build_invoice_item_from_row(row)
    {
      id: row[:id].to_i,
      item_id: row[:item_id].to_i,
      invoice_id: row[:invoice_id].to_i,
      quantity: row[:quantity].to_i,
      unit_price: BigDecimal.new(row[:unit_price]) / 100,
      created_at: Time.parse(row[:created_at]),
      updated_at: Time.parse(row[:updated_at])
    }
  end

  def self.build_customer_from_row(row)
    {
      id: row[:id].to_i,
      first_name: row[:first_name],
      last_name: row[:last_name],
      created_at: Time.parse(row[:created_at]),
      updated_at: Time.parse(row[:updated_at])
    }
  end

  def self.build_transaction_from_row(row)
    {
      id: row[:id].to_i,
      invoice_id: row[:invoice_id].to_i,
      credit_card_number: row[:credit_card_number],
      credit_card_expiration_date: row[:credit_card_expiration_date],
      result: row[:result].to_sym,
      created_at: Time.parse(row[:created_at]),
      updated_at: Time.parse(row[:updated_at])
    }
  end

  def analyst
    SalesAnalyst.new(@items, @merchants, @invoices, @invoice_items, @customers, @transactions)
  end
end
