require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require 'pry'

class SalesEngine
  attr_reader :merchant_contents, :item_contents, :invoice_contents

  def initialize(merchant_contents, item_contents, invoice_contents)
    @merchant_contents = merchant_contents
    @item_contents = item_contents
    @invoice_contents = invoice_contents
    @items = ItemRepository.new(self)
    @merchants = MerchantRepository.new(self)
    @invoices = InvoiceRepository.new(self)
    merchants
    items
    invoices
  end

  def self.from_csv(files_to_parse = {})
    item_file = files_to_parse.fetch(:items)
    item_contents = CSV.open item_file, headers: true, header_converters: :symbol

    merchant_file = files_to_parse.fetch(:merchants)
    merchant_contents = CSV.open merchant_file, headers: true, header_converters: :symbol

    invoice_contents = files_to_parse.fetch(:invoices)
    invoice_contents = CSV.open merchant_file, headers: true, header_converters: :symbol

    SalesEngine.new(merchant_contents, item_contents, invoice_contents)
  end

  def merchants
    @merchants.merchant_repo(merchant_contents)
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
end
