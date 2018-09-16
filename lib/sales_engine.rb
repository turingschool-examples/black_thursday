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

  def initialize(params)
    @merchants = MerchantRepo.new(params[:merchants]) if params[:merchants]
    @items = ItemsRepo.new(params[:items]) if params[:items]
    @invoices = InvoiceRepository.new(params[:invoices]) if params[:invoices]
  end

  def self.from_csv(params)
    # merchants =  params[:merchants]
    # items =   params[:items]
    # invoices = params[:invoices]
    SalesEngine.new(params)
  end

  def analyst
    SalesAnalyst.new(self)
  end

  # def inspect
  #  instance.nil? ? nil : "#<#{self.class} #{instance.size} rows>"
  # end

  # def inspect
  #   "#<#{self.class} #{@collections.size} rows>"
  # end

  #maybe you may need to put this in all your repos

end
