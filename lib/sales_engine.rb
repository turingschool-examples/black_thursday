require 'csv'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/invoice_repository'

class SalesEngine
  attr_reader :item_repository,
              :merchant_repository,
              :invoice_repository

  def initialize(item_repository, merchant_repository, invoice_repository)
    @item_repository = item_repository
    @merchant_repository = merchant_repository
    @invoice_repository = invoice_repository
  end

  def self.from_csv(files)
    item_repository = ItemRepository.new(load_csv(files[:items]))
    merchant_repository = MerchantRepository.new(load_csv(files[:merchants]))
    invoice_repository = InvoiceRepository.new(load_csv(files[:invoices]))
    SalesEngine.new(item_repository, merchant_repository, invoice_repository)
  end

  def self.load_csv(file_name)
    CSV.readlines(file_name, headers: true, header_converters: :symbol) do |row|
      row
    end
  end
end
