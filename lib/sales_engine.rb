require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'

class SalesEngine

  attr_reader :items, :merchants, :invoices

  def self.from_csv(csv_file_paths)
    item_file_path = csv_file_paths[:items]
    merchant_file_path = csv_file_paths[:merchants]
    invoice_file_path = csv_file_paths[:invoices]

    SalesEngine.new(item_file_path, merchant_file_path, invoice_file_path)
  end


  def initialize(item_file_path, merchant_file_path, invoice_file_path)
    @items = ItemRepository.new(item_file_path, self)
    @merchants = MerchantRepository.new(merchant_file_path, self)
    @invoices = InvoiceRepository.new(invoice_file_path, self)
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

  # def inspect
  #   "#<#{self.class} #{@items.size} rows>"
  # end


end
