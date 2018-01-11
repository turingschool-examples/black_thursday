require_relative 'invoice'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/customer_repository'
require 'csv'

class InvoiceRepository
  attr_reader :invoice_items,
              :transactions,
              :customers

  def initialize(data, parent)
    @invoices = []
    @sales_engine = parent
    @invoice_items = InvoiceItemRepository.new(self)
    @transactions = TransactionRepository.new(self)
    @customers = CustomerRepository.new(self)
    from_csv(data)
  end

  def from_csv(data)
    @invoice_items.from_csv(data[:invoice_items])
    @transactions.from_csv(data[:transactions])
    @customers.from_csv(data[:customers])
    invoice_data = CSV.open data[:invoices], headers: true,
      header_converters: :symbol, converters: :numeric
    invoice_data.each do |row|
      @invoices << Invoice.new(row.to_hash, self)
    end
  end

  def all
    return @invoices
  end

  def find_by_id(id)
    @invoices.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(customer_id)
    @invoices.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    @invoices.find_all do |invoice|
      invoice.status == status
    end
  end

  def find_merchant(merchant_id)
    @sales_engine.find_merchant_by_merchant_id(merchant_id)
  end

  def find_invoice_items_by_invoice_id(invoice_id)
    @invoice_items.find_all_by_invoice_id(invoice_id)
  end

  def find_items_by_invoice_id(invoice_id)
    invoice_items = find_invoice_items_by_invoice_id(invoice_id)
    invoice_items.map do |invoice_item|
      @sales_engine.find_item_by_item_id(invoice_item.item_id)
    end
  end

  def find_transactions_by_invoice_id(invoice_id)
    @transactions.find_all_by_invoice_id(invoice_id)
  end

  def find_customer_by_customer_id(customer_id)
    @customers.find_by_id(customer_id)
  end

  def invoices_each_weekday
    @invoices.group_by do |invoice|
      invoice.weekday
    end
  end

  def find_all_by_date(date)
    @invoices.find_all do |invoice|
      invoice.created_at == date
    end
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end
end
