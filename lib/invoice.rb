require 'csv'
require 'time'

class Invoice

  attr_reader :id, :customer_id, :merchant_id,
              :status, :created_at, :updated_at,
              :repository

  def initialize(data, repository)
    @id = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status = data[:status].to_sym
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @repository = repository
  end

  def merchant
    repository.find_merchant(merchant_id)
  end

  def items
    repository.find_items_by_invoice_id(@id)
  end

  def transactions
    repository.find_transactions_by_invoice_id(@id)
  end

  def customer
    repository.find_customer(customer_id)
  end

  def is_paid_in_full?
    repository.transaction_result(@id).each do |transaction|
      return true if transaction.result == "success"
    end
    false
  end

  def total
    if is_paid_in_full?
      determine_total_cost
    end
  end

  def determine_total_cost
    invoice_items = repository.find_invoice_items_by_invoice_id(@id)
    invoice_items.reduce(0) do |result, invoice_item|
      result += (invoice_item.quantity * invoice_item.unit_price)
    end
  end
end
