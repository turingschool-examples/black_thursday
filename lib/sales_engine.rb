require 'csv'
require 'Time'

require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'sales_analyst'
require_relative 'invoice_repository'

require 'pry'

class SalesEngine
  attr_reader :items, :merchants, :invoices
  def initialize(item_repository, merchant_repository, invoice_repository)
    @items = item_repository
    @merchants = merchant_repository
    @invoices = invoice_repository
  end

  def self.from_csv(file_hash)
    items_file = CSV.read(file_hash[:items], headers: true, header_converters: :symbol)
    merchants_file = CSV.read(file_hash[:merchants], headers: true, header_converters: :symbol)
    invoices_file = CSV.read(file_hash[:invoices], headers: true, header_converters: :symbol)
    item_repository = ItemRepository.new
    merchant_repository = MerchantRepository.new
    invoice_repository = InvoiceRepository.new

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

    self.new(item_repository, merchant_repository, invoice_repository)
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
      name: row[:name]
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

  def analyst
    SalesAnalyst.new(@items, @merchants)
  end
end
