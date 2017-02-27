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
    success_or_failure = transactions.map do |transaction|
      transaction.result
    end

    if success_or_failure.include?("success")
      true
    else
      false
    end
  end

  def total # invoice.total returns the total $ amount of the invoice
      items.map do |item|
        item.unit_price /
      end.reduce(:+).round(2)
  end
  # Note: Failed charges should never be counted in revenue totals or statistics.

end
