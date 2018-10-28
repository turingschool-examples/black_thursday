require 'csv'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/transaction_repository'
require_relative './sales_analyst'


class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :transactions,
              :analyst


  def initialize(items, merchants, invoices = nil, transactions)
    @items = ItemRepository.new(populate_items(items))
    @merchants = MerchantRepository.new(populate_merchants(merchants))
    @invoices = InvoiceRepository.new(populate_invoices(invoices))
    @transactions = TransactionRepository.new(populate_transactions(transactions))
    @analyst = SalesAnalyst.new(@items, @merchants, @invoices, @transactions)
  end

  def self.from_csv(info)
    info[:items] ? items = info[:items] : items = nil
    info[:merchants] ? merchants = info[:merchants] : merchants = nil
    info[:invoices] ? invoices = info[:invoices] : invoices = nil
    info[:transactions] ? transactions = info[:transactions] : transactions = nil
    self.new(items, merchants, invoices, transactions)
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

  def populate_transactions(file_path)
    if file_path
      file = CSV.read(file_path, headers: true, header_converters: :symbol )
      file.map do |row|
        Transaction.new(row)
      end
    end
  end

  # def populate_invoice_item(file_path)
  #   file - CSV.read(file_path, headers: true, header_converters: :symbol)
  #   file.map do |row|
  #
  # end

  
end
