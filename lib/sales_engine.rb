require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require 'pry'

class SalesEngine
  attr_reader :merchant_contents, :item_contents, :invoice_contents

  def initialize(merchant_file, item_file, invoice_file)
    @merchant_contents = open_csv(merchant_file)
    @item_contents = open_csv(item_file)
    @invoice_contents = open_csv(invoice_file)
    @items = ItemRepository.new(self)
    @merchants = MerchantRepository.new(self)
    @invoices = InvoiceRepository.new(self)
    load_repositories
  end

  def self.from_csv(files_to_parse = {})
    item_file = files_to_parse.fetch(:items)
    merchant_file = files_to_parse.fetch(:merchants)
    invoice_file = files_to_parse.fetch(:invoices)
    SalesEngine.new(merchant_file, item_file, invoice_file)
  end

  def merchants
    @merchants.merchant_repo(merchant_contents)
  end

  def open_csv(file)
    CSV.open file, headers: true, header_converters: :symbol
  end

  def load_repositories
    merchants
    items
    invoices
  end

  def items
    @items.item(item_contents)
  end

  def invoices
    @invoices.invoice(invoice_contents)
  end

  def find_items_by_merch_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)

  end

  def find_merchant_by_merch_id(id)
    @merchants.find_by_id(id)
  end

  def find_invoices_by_merch_id(merchant_id)
    @invoices.find_all_by_merchant_id(merchant_id)
  end

end
