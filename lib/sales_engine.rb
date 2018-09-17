require_relative 'merchant_repository'
require_relative 'merchant'
require_relative 'item'
require_relative 'item_repository'
require_relative 'csv_adapter'
require_relative 'crud'
require_relative 'invoice_repository'
require_relative 'invoice_item'
require_relative 'transaction'
require_relative 'transaction_repository'
require 'csv'

class SalesEngine
include Crud

  attr_reader :filepath
  attr_accessor :merchants, :items, :analyst

  def initialize(filepath)
    @filepath = filepath
  end

  def self.from_csv(filepath)
    SalesEngine.new(filepath)
  end

  def create_instance_of_items(items_array)
    items_array.map do |hash|
     Item.new(hash)
   end
 end

  def merchants
    @merchants ||= MerchantRepository.new(filepath[:merchants], self)
  end

  def items
    @items ||= ItemRepository.new(filepath[:items], self)
  end

  def invoices
    @invoices ||= InvoiceRepository.new(filepath[:invoices], self)
  end

  def analyst
    @sales_analyst = SalesAnalyst.new(self)
  end

  def transactions
    @transactions ||= TransactionRepository.new(filepath[:transactions], self)
  end

end
