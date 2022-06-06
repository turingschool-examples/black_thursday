require 'helper'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions,
              :customers,
              :analyst

  def initialize(data)
    @items = check_items(data)
    @merchants = check_merchants(data)
    @invoices = check_invoices(data)
    @invoice_items = check_invoice_items(data)
    @transactions = check_transactions(data)
    @customers = check_customers(data)
  end

  def self.from_csv(data)
    SalesEngine.new(data[:items], data[:merchants], data[:invoices])
  end

  def merchants
    @merchant_repository
  end

  def items
    @item_repository
  end

  def invoices
    @invoice_repository
  end

  def check_invoice_items(data)
    return InvoiceItemRepository.new(data[:invoice_items]) if data.keys.include?(:invoice_items) == true
  end

  def check_transactions(data)
    return TransactionRepository.new(data[:transactions]) if data.keys.include?(:transactions) == true
  end

  def check_customers(data)
    return CustomerRepository.new(data[:customers]) if data.keys.include?(:customers) == true
  end

  def analyst
    SalesAnalyst.new(@item_repository,@merchant_repository,@invoice_repository)
  end

end
