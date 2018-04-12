require 'time'
class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :invoice_repo


  def initialize(data, invoice_repo)
    @invoice_repo = invoice_repo
    @id = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status = data[:status].to_sym
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
  end

  def merchant
    invoice_repo.sales_engine.merchants.find_by_id(merchant_id)
  end

  def update_updated_time
    @updated_at = Time.now
  end

  def update_status(status)
    @status = status
  end

  def update_merchant_id(id)
    @merchant_id = id
  end

  def update_customer_id(id)
    @customer_id = id
  end

  def items
    array = @invoice_repo.sales_engine.invoice_items.find_all_by_invoice_id(id)
    array.map do |invoice_item|
      @invoice_repo.sales_engine.items.find_by_id(invoice_item.item_id)
    end.uniq
  end

  def transactions
    @invoice_repo.sales_engine.transactions.find_all_by_invoice_id(id)
  end

  def customer
    @invoice_repo.sales_engine.customers.find_by_id(customer_id)
  end

  def is_paid_in_full?
    a = @invoice_repo.sales_engine.transactions.find_all_by_invoice_id(id)
    a.any? do |transaction|
      transaction.result == "success"
    end
  end

  def total
    @invoice_repo.sales_engine.invoice_items.find_all_by_invoice_id(id).reduce(0) do |sum, invoice_item|
      sum + (invoice_item.quantity * invoice_item.unit_price) if is_paid_in_full?
    end
  end
end
