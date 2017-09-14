# require './lib/merchant_repository'
# require './lib/item_repository'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'

class SalesEngine

  attr_accessor :merchant_csv_filepath, :item_csv_filepath, :invoice_csv_filepath

  def self.from_csv(info)
    se = SalesEngine.new
    se.merchant_csv_filepath = info[:merchants]
    se.item_csv_filepath = info[:items]
    se.invoice_csv_filepath = info[:invoices]
    se
  end

  def initialize
    @merchant_csv_filepath = ''
    @item_csv_filepath = ''
    @invoice_csv_filepath = ''
  end

  def merchants
    if @merchant_repository.nil?
      @merchant_repository = MerchantRepository.new(@merchant_csv_filepath, self)
    else
      @merchant_repository
    end
  end

  def items
    if @item_repository.nil?
      @item_repository = ItemRepository.new(@item_csv_filepath, self)
    else
      @item_repository
    end
  end

  def invoices
    if @invoice_repository.nil?
      @invoice_repository = InvoiceRepository.new(@invoice_csv_filepath, self) 
    else  
      @invoice_repository
    end 
  end 
 
  def total_merchants
    self.merchants.merchants.length
  end

  def total_items
    self.items.items.length
  end

  def average_items_per_merchant
    total_items / total_merchants.to_f
  end

  def merchant_item_count
    self.merchants.merchants.map do |merchant|
      merchant.items.count
    end
  end

end
