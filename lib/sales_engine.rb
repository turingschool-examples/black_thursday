require 'csv'
require_relative './item_repository'
require_relative './merchant_repository'
require_relative './invoice_repository'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices

  def initialize(items, merchants, invoices)
    @items = ItemRepository.new(items, self)
    @merchants = MerchantRepository.new(merchants, self)
    @invoices = InvoiceRepository.new(invoices, self)
  end

  def self.from_csv(files)
    SalesEngine.new(
      load_csv(files[:items]),
      load_csv(files[:merchants]),
      load_csv(files[:invoices])
    )
  end

  def self.load_csv(file_name)
    CSV.readlines(file_name, headers: true, header_converters: :symbol) do |row|
      row
    end
  end

  def find_items_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end

  def find_merchant_by_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end
end
