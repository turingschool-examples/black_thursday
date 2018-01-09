class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(data, parent)
    @id = data[:id]
    @customer_id = data[:customer_id]
    @merchant_id = data[:merchant_id]
    @status = data[:status]
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @invoice_repository = parent
  end

  def merchant
    @invoice_repository.find_merchant(@merchant_id)
  end

  def invoice_items
    @invoice_repository.find_invoice_items_by_invoice_id(@id)
  end

  def items
    @invoice_repository.find_items_by_invoice_id
  end

  def transactions
    @invoice_repository.find_transactions_by_invoice_id(@id)
  end

  def customer
    @invoice_repository.find_customer_by_customer_id(@customer_id)
  end

  def is_paid_in_full?
    all_succesful = transactions.all? do |transaction|
      transaction.result == 'success'
    end
    return all_succesful && !transactions.empty?
  end

  def total
    invoice_items.sum do |invoice_item|
      invoice_item.total_cost
    end
  end
end
