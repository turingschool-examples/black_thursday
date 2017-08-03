class Invoice
  attr_reader         :id,
                      :customer_id,
                      :merchant_id,
                      :status,
                      :created_at,
                      :updated_at

  def initialize(data, invoice_repo = nil)
    @invoice_repo     = invoice_repo
    @id               = data[:id]
    @customer_id      = data[:customer_id]
    @merchant_id      = data[:merchant_id]
    @status           = data[:status].to_sym
    @created_at       = Time.parse(data[:created_at])
    @updated_at       = Time.parse(data[:updated_at])
  end

  def merchant
    @invoice_repo.fetch_merchant_id(merchant_id)
  end

  def items
    @invoice_repo.fetch_invoice_id_for_items(id)
  end

  def transactions
    @invoice_repo.fetch_invoice_id_for_transactions(id)
  end

  def invoice_items
    @invoice_repo.sales_engine.invoice_items.find_all_by_invoice_id(id)
  end

  def customer
    @invoice_repo.fetch_invoice_id_for_customers(customer_id)
  end

  def is_paid_in_full?
    return false if transactions.empty?
    transactions.any? {|transaction| transaction.result == "success"}
  end

  def total
    @invoice_repo.fetch_invoice_id_for_invoice_items(id)
  end

  def invoice_items
    @invoice_repo.fetch_invoice_items(id)
  end

end
