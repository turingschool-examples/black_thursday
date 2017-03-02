require 'pry'
require_relative'invoice'

class InvoiceRepository
  attr_reader :invoices, :sales_engine
  def initialize (invoices, sales_engine = nil)
    @invoices = invoices
    @sales_engine = sales_engine
  end

  def all
    invoices
  end

  def find_by_id(id)
    invoices.find { |row| row.id == id }
  end

  def find_all_by_customer_id(customer_id)
    invoices.select { |row| row.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.select { |row| row.merchant_id == merchant_id }
  end

  def find_all_by_status(status)
    invoices.select { |row| row.status == status }
  end

  def find_all_by_date(date)
    invoices.select { |row| row.created_at == date }
  end

  def all_paid_in_full
    invoices.select { |row| row.is_paid_in_full? }
  end

  def inspect
  "#<#{self.class} #{@merchants.size} rows>"
  end
end
