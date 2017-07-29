require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require 'csv'
require 'pry'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices

  def initialize(data)
    @items = ItemRepository.new(data[:items], self)
    @merchants = MerchantRepository.new(data[:merchants], self)
    @invoices = InvoiceRepository.new(data[:invoices], self)
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end

  def collected_invoices(merchant_id)
    @invoices.find_all_by_merchant_id(merchant_id)
  end



  def fetch_items(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def fetch_merchant(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

  def fetch_invoices(merchant_id)
    @invoices.find_all_by_merchant_id(merchant_id)
  end

  def fetch_merchant_id(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

end
