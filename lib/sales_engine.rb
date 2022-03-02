require 'pry'
require 'csv'
require_relative './item'
require_relative './merchant'
require_relative './merchant_repository'
require_relative './item_repository'
require_relative './invoice_repository'
require_relative './invoice'
require_relative './transaction'
require_relative './transaction_repository'
require_relative './customer'
require_relative './customer_repository'
require_relative './invoice_item'
require_relative './invoice_item_repository'

class SalesEngine
  attr_accessor :invoice_repo, :merchant_repo, :item_repo, :customer_repo, :invoice_item_repo
  attr_reader :table_hash

  def initialize(table_hash)
    @table_hash = table_hash
    @invoice_repo = nil
    @merchant_repo = nil
    @customer_repo = nil
    @item_repo = nil
    @invoice_item_repo = nil
    @transaction_repo = nil
  end

  def self.from_csv(path_hash)
    table_hash = {}
    path_hash.each do |name, path|
      csv = CSV.read(path, headers: true, header_converters: :symbol)
      table_hash[name] = csv
    end
    SalesEngine.new(table_hash)
  end

  def items
    item_array = @table_hash[:items].map do |row|
      Item.new({ id: row[:id].to_i, name: row[:name], description: row[:description],
                 unit_price: BigDecimal(row[:unit_price].to_f / 100, row[:unit_price].length), merchant_id: row[:merchant_id].to_i, created_at: row[:created_at], updated_at: row[:updated_at] })
    end
    if @item_repo == nil
      @item_repo = ItemRepository.new(item_array)
    else
      @item_repo
    end
  end

  def merchants
    merchant_array = @table_hash[:merchants].map do |row|
      Merchant.new({ id: row[:id].to_i, name: row[:name] })
    end
    if @merchant_repo == nil
      @merchant_repo = MerchantRepository.new(merchant_array)
    else
      @merchant_repo
    end
  end

  def customers
    customer_array = @table_hash[:customers].map do |row|
      Customer.new({ id: row[:id].to_i, first_name: row[:first_name], last_name: row[:last_name],
                     created_at: Time.parse(row[:created_at]), updated_at: Time.parse(row[:updated_at]) })
    end
    if @customer_repo == nil
      @customer_repo = CustomerRepository.new(customer_array)
    else
      @customer_repo
    end
  end

  def invoices
    invoice_array = @table_hash[:invoices].map do |row|
      Invoice.new({ id: row[:id].to_i, customer_id: row[:customer_id].to_i, merchant_id: row[:merchant_id].to_i,
                    status: row[:status].to_sym, created_at: row[:created_at], updated_at: row[:updated_at] })
    end
    if @invoice_repo == nil
      @invoice_repo = InvoiceRepository.new(invoice_array)
    else
      @invoice_repo
    end
  end

  def analyst
    merchants
    items
    transactions
    invoice_items
    invoices
    customers
    SalesAnalyst.new(@merchant_repo, @item_repo, @transaction_repo, @invoice_item_repo, @invoice_repo, @customer_repo)
  end

  def invoice_items
    iir_array = @table_hash[:invoice_items].map do |row|
      InvoiceItem.new({ id: row[:id].to_i, item_id: row[:item_id].to_i, invoice_id: row[:invoice_id].to_i,
                        quantity: row[:quantity].to_i, unit_price: BigDecimal((row[:unit_price].to_f / 100), row[:unit_price].length), created_at: Time.parse(row[:created_at]), updated_at: Time.parse(row[:updated_at]) })
    end
    if @invoice_item_repo == nil
      @invoice_item_repo = InvoiceItemRepository.new(iir_array)
    else
      @invoice_item_repo
    end
  end

  def transactions
    transaction_array = @table_hash[:transactions].map do |row|
      Transaction.new ({ id: row[:id].to_i, invoice_id: row[:invoice_id].to_i,
                         credit_card_number: row[:credit_card_number], credit_card_expiration_date: row[:credit_card_expiration_date], result: row[:result].to_sym, created_at: Time.parse(row[:created_at]), updated_at: Time.parse(row[:updated_at]) })
    end
    @transaction_repo == nil ? @transaction_repo = TransactionRepository.new(transaction_array) : @transaction_repo
  end
end
