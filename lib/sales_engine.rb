require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'item'
require_relative 'merchant'
require_relative 'invoice'

# This class births all our repositories
class SalesEngine
  def initialize(file_hash)
    @location_hash = file_hash
    if !@location_hash[:items].nil?
      @items_instance = ItemRepository.new(@location_hash, self)
    end
    if !@location_hash[:merchants].nil?
      @merchants_instance = MerchantRepository.new(@location_hash, self)
    end
    if !@location_hash[:invoices].nil?
      @invoices_instance = InvoiceRepository.new(@location_hash, self)
    end
  end

  def self.from_csv(file_hash)
    SalesEngine.new(file_hash)
  end

  def items
    @items_instance
  end

  def merchants
    @merchants_instance
  end

  def analyst
    SalesAnalyst.new(self)
  end

  def invoices
    @invoices_instance
  end

  def all_merchant_ids
    @merchants_instance.all.map do |merchant|
      merchant.id
    end
  end
end
