require 'csv'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_repository'
require 'pry'


class SalesEngine

  attr_reader :items,
              :merchants,
              :invoices

  def initialize(csv_files)
    @items     = ItemRepository.new(csv_files[:items], self)
    @merchants = MerchantRepository.new(csv_files[:merchants], self)
    @invoices = InvoiceRepository.new(csv_files[:invoices], self)
  end

  def self.from_csv(files)
    SalesEngine.new({
      :items => read_csv(files[:items]),
      :merchants => read_csv(files[:merchants]),
      :invoices => read_csv(files[:invoices])
      })

  end

  def self.read_csv(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol)
  end

  def find_item_by_merchant_id(id) # NEEDS TESTS || RETURNS ITEM IF MERCHANT ID == ID
    items.find_item(id)
  end

  def find_merchant_by_id(id) # NEEDS TESTS || RETURNS MERCHNAT IF MERCHANT ID == ID
    merchants.find_by_id(id)
  end

  def grab_array_of_merchant_items # NEEDS TESTS || Returns array of items per merchant
    merchants.grab_array_of_items
  end

  def grab_all_merchants # PRIVATE
    merchants.all
  end

  def grab_all_items # PRIVATE
    items.all
  end

end
