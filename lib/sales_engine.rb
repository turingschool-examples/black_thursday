require 'time'
require 'CSV'
require_relative "../lib/items_repo"
require_relative "../lib/merchant_repo"
require_relative "../lib/sales_analyst"
require_relative "../lib/invoice_repository"

class SalesEngine
  attr_reader :merchants,
              :items,
              :invoices
  def initialize(merchants, items, invoices)
    @merchants = MerchantRepo.new(merchants)
    @items = ItemsRepo.new(items)
    @invoices = InvoiceRepository.new(invoices)
  end

  def self.from_csv(params)
    merchants =  params[:merchants]
    items =   params[:items]
    invoices = params[:invoices]
    SalesEngine.new(merchants, items, invoices)
  end

  def analyst
    SalesAnalyst.new(self)
  end

end
