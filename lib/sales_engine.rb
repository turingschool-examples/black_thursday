require 'pry'
require 'csv'
require_relative './item'
require_relative './merchant'

class SalesEngine
  attr_reader :table_hash
  def initialize(table_hash)
    @table_hash = table_hash
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
      Item.new({id: row[:id].to_i, name: row[:name], description: row[:description], unit_price: BigDecimal(row[:unit_price]), merchant_id: row[:merchant_id].to_i, created_at: row[:created_at], updated_at: row[:updated_at]})
    end
    ItemRepository.new(item_array)
  end

  def merchants
    merchant_array = @table_hash[:merchants].map do |row|
      Merchant.new({id: row[:id].to_i, name: row[:name]})
    end
    MerchantRepository.new(merchant_array)
  end

  def invoices
    invoice_array = @table_hash[:invoices].map do |row|
      Invoice.new({id: row[:id].to_i, customer_id: row[:customer_id].to_i, merchant_id: row[:merchant_id].to_i, status: row[:status].to_sym, created_at: row[:created_at], updated_at: row[:updated_at]})
    end
    InvoiceRepository.new(invoice_array)
  end
end
