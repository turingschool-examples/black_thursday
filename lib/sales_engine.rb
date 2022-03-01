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

class SalesEngine
  attr_accessor :invoice_repo, :merchant_repo, :item_repo
  attr_reader :table_hash

  def initialize(table_hash)
    @table_hash = table_hash
    @invoice_repo = nil
    @merchant_repo = nil
    @item_repo = nil
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

  def invoice_items
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

  def transactions
    transaction_array = @table_hash[:transactions].map do |row|
      Transaction.new ({id: row[:id].to_i, invoice_id: row[:invoice_id].to_i, credit_card_number: row[:credit_card_number], credit_card_expiration_date: row[:credit_card_expiration_date], result: row[:result], created_at: row[:created_at], updated_at: row[:updated_at]})
    end
    @transaction_repo == nil ? @transaction_repo = TransactionRepository.new(transaction_array) : @transaction_repo
  end
end
