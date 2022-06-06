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
    SalesEngine.new(data)
  end

  def check_items(data)
    return ItemRepository.new(data[:items]) if data.keys.include?(:items) == true
  end

  def check_merchants(data)
    return MerchantRepository.new(data[:merchants]) if data.keys.include?(:merchants) == true
  end

  def check_invoices(data)
    return InvoiceRepository.new(data[:invoices]) if data.keys.include?(:invoices) == true
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
    SalesAnalyst.new(@items, @merchants, @invoices)
  end
end
