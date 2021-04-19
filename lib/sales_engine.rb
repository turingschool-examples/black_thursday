require_relative './items_repo'
require_relative './merchants_repo'
require_relative './invoices_repo'
require_relative './invoice_item_repo'
require_relative './transaction_repo'
require_relative './customer_repo'
require 'csv'

class SalesEngine
  attr_accessor :items,
                :merchants,
                :invoices,
                :invoice_items,
                :transactions,
                :customers

  def initialize(csv_files)
    @items = ItemRepo.new(csv_files[:items], self) unless csv_files[:items] == nil
    @merchants = MerchantRepo.new(csv_files[:merchants], self) unless csv_files[:merchants] == nil
    @invoices = InvoiceRepo.new(csv_files[:invoices], self) unless csv_files[:invoices] == nil
    @invoice_items = InvoiceItemRepo.new(csv_files[:invoice_items], self) unless csv_files[:invoice_items] == nil
    @transactions = TransactionRepo.new(csv_files[:transactions], self) unless csv_files[:transactions] == nil
    @customers = CustomerRepo.new(csv_files[:customers], self) unless csv_files[:customers] == nil
  end

  def self.from_csv(csv_files)
    SalesEngine.new(csv_files)
  end

  def analyst
    SalesAnalyst.new(@items, @merchants, @invoices)
  end

  def find_items_by_id(id)
    @items.find_by_id(id)
  end

  def find_merchants_by_id(id)
    @merchants.find_by_id(id)
  end
end
