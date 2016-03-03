require 'csv'
require 'time'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'
require_relative '../lib/repository_loaders'


class SalesEngine
  include RepositoryLoaders
  attr_reader :items, :merchants, :invoices

  def initialize
    @items = ItemRepository.new(self)
    @merchants = MerchantRepository.new(self)
    #@invoices = InvoiceRepository.new(self)
  end

  def self.from_csv(loadpath_hash)
    items = load_file(loadpath_hash[:items])
    merchants = load_file(loadpath_hash[:merchants])
    invoices = load_file(loadpath_hash[:invoices])
    @sales_engine = SalesEngine.new

    @sales_engine.load_items_into_repository(@sales_engine, items)
    @sales_engine.load_merchants_into_repository(@sales_engine, merchants)
    # @sales_engine.load_invoices_into_repository(@sales_engine, invoices)




    @sales_engine
  end

  def self.load_file(loadpath)
    contents = CSV.open "#{loadpath}", headers: true, header_converters: :symbol
  end



end
