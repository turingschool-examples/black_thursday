class Invoice
  attr_reader :id,
              :customer_id,
              :status,
              :created_at,
              :updated_at,
              :merchant_id,
              :inr

  def initialize(id, customer_id, status,
                 created_at, updated_at,
                 merchant_id, inr)
    @id = id
    @customer_id = customer_id
    @status = status
    @created_at = Time.parse(created_at)
    @updated_at = Time.parse(updated_at)
    @merchant_id = merchant_id
    @inr = inr
  end

  def merchant
    inr.fetch_merchant_from_invoice_id(merchant_id)
  end

  def items
    inr.fetch_items_from_invoice_id(id)
  end

  def transactions
    inr.fetch_transactions_from_invoice_id(id)
  end

  def customer
    inr.fetch_customer_from_invoice_id(customer_id)
  end

  def is_paid_in_full?
    #go to transactions with invoice id
    #get all transactions that match invoice id
    trans = transactions
    #if any transactions == success then it is true
    #else it is false
    trans.any? do |transaction|
      transaction.result == "success"
    end
  end

  def total
  end
end
