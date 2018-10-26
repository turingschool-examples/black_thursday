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
    items_file = load_csv(file_hash[:items])
    merchants_file = load_csv(file_hash[:merchants])
    invoices_file = load_csv(file_hash[:invoices])
    invoice_items_file = load_csv(file_hash[:invoice_items])
    customers_file = load_csv(file_hash[:customers])
    transactions_file = load_csv(file_hash[:transactions])

    item_repository = ItemRepository.new
    merchant_repository = MerchantRepository.new
    invoice_repository = InvoiceRepository.new
    invoice_item_repository = InvoiceItemRepository.new
    customer_repository = CustomerRepository.new
    transaction_repository = TransactionRepository.new

    populate_repository(item_repository, items_file)
    populate_repository(merchant_repository, merchants_file)
    populate_repository(invoice_repository, invoices_file)
    populate_repository(invoice_item_repository, invoice_items_file)
    populate_repository(customer_repository, customers_file)
    populate_repository(transaction_repository, transactions_file)
    
    self.new(item_repository, merchant_repository, invoice_repository, invoice_item_repository, customer_repository, transaction_repository)
  end

  def self.populate_repository(repository, csv_file)
    method = "build_#{repository.type.to_s.downcase}_args_from_row".to_sym
    binding.pry
    csv_file.each do |row|
      object_args = send(method, row)
      repository.create(object_args)
    end
  end

  def self.build_item_args_from_row(row)
    {
      id: row[:id].to_i,
      name: row[:name],
      description: row[:description],
      unit_price: BigDecimal.new(row[:unit_price],4) / 100,
      created_at: Time.parse(row[:created_at]),
      updated_at: Time.parse(row[:updated_at]),
      merchant_id: row[:merchant_id].to_i
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

  def self.build_invoiceitem_args_from_row(row)
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

  def self.build_customer_args_from_row(row)
    {
      id: row[:id].to_i,
      first_name: row[:first_name],
      last_name: row[:last_name],
      created_at: Time.parse(row[:created_at]),
      updated_at: Time.parse(row[:updated_at])
    }
  end

  def self.build_transaction_args_from_row(row)
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

  def self.load_csv(file)
    CSV.read(file, headers: true, header_converters: :symbol)
  end

  def analyst
    SalesAnalyst.new(@items, @merchants, @invoices, @invoice_items, @customers, @transactions)
  end
end
