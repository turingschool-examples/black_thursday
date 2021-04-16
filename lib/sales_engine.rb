require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_items_repository'
require_relative 'transactions_repository'
require_relative 'customer_repository'

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
    if !@location_hash[:invoiceitem].nil?
      @invoice_items_instance = InvoiceItemRepository.new(@location_hash, self)
    end
    if !@location_hash[:transaction].nil?
      @transactions_instance = TransactionRepository.new(@location_hash, self)
    end
    if !@location_hash[:customer].nil?
      @customers_instance = CustomerRepository.new(@location_hash, self)
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

  def invoices
    @invoices_instance
  end

  def invoice_items
    @invoice_items_instance
  end

  def transactions
    @transactions_instance
  end

  def customers
    @customers_instance
  end

  def analyst
    SalesAnalyst.new(self)
  end

  def all_merchant_ids
    @merchants_instance.all.map do |merchant|
      merchant.id
    end
  end
end
