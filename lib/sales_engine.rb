require 'CSV'
require_relative 'item_repo'
require_relative 'merchant_repo'
require_relative 'sales_analyst'
require_relative 'invoice_repo'
#require_relative 'invoice_items'
require_relative 'transaction_repo'

class SalesEngine
  attr_reader :items,
              :merchants,
              :analyst,
              :invoices,
              :invoice_items,
              :transactions

  def initialize(paths)
   @items = ItemRepo.new(paths[:items], self)
   @merchants = MerchantRepo.new(paths[:merchants], self)
   @analyst = SalesAnalyst.new(self)
   @invoices = InvoiceRepo.new(path[:invoices], self)
   @invoice_items = InvoiceItemRepo.new(path[:invoice_items], self)
   @transactions = TransactionRepo.new(paths[:transactions], self)
   @customers = CustomerRepo.new(paths[:customers], self)
  end

  def self.from_csv(paths)
    new(paths)
  end
  
  def all_items #Needs spec
    @items.all
  end

  def all_merchants #Needs spec
    @merchants.all
  end

  def item_count #Needs spec
    count = @items.all.length
    count.to_f
  end

  def merchant_count #Needs spec
    count = @merchants.all.length
    count.to_f
  end

  def average_item_price #Needs spec
    @items.average_price
  end

  def item_count_per_merchant #Needs spec
    @items.item_count_per_merchant
  end

  def find_merchant_id(id) #Needs spec
    @items.find_all_by_merchant_id(id)
  end
end
