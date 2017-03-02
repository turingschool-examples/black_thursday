require 'time'
require 'date'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :repo

  def initialize(row, repo)
    @id = row[:id].to_i
    @customer_id = row[:customer_id].to_i
    @merchant_id = row[:merchant_id].to_i
    @status = row[:status].to_sym
    @created_at = Time.parse(row[:created_at])
    @updated_at = Time.parse(row[:updated_at])
    @repo = repo
  end

  def merchant
    repo.sales_engine.merchants.find_by_id(self.merchant_id)
  end

  def day_of_the_week_on_which_an_invoice_is_created
    @created_at.strftime('%A')
  end

  def invoice_items
    repo.sales_engine.invoice_items.find_all_by_invoice_id(self.id)
  end

  def items
    invoice_items.map do |invoice_item|
      invoice_item.item
    end
  end

  def transactions
    repo.sales_engine.transactions.find_all_by_invoice_id(self.id)
  end

  def customer
    repo.sales_engine.customers.find_by_id(self.customer_id)
  end

  def is_paid_in_full?
    transactions.any?{ |transaction| transaction.success? }
  end

  def total
    return 0.0 unless is_paid_in_full?
      invoice_items.map { |i_item| i_item.total_price }.reduce(:+).round(2)
  end
end
