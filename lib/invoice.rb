
class Invoice
  attr_reader :invoice_repo,
              :id,
              :customer_id,
              :status,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(invoice_data, invoice_repo)
    @invoice_repo = invoice_repo
    @id           = invoice_data[:id].to_i
    @customer_id  = invoice_data[:customer_id].to_i
    @status       = invoice_data[:status].to_sym
    @created_at   = Time.parse(invoice_data[:created_at].to_s)
    @updated_at   = Time.parse(invoice_data[:updated_at].to_s)
    @merchant_id  = invoice_data[:merchant_id].to_i
  end

  def merchant
    @invoice_repo.sales_engine.merchants.find_by_id(@merchant_id)
  end

  def items
    invoice_items = @invoice_repo.sales_engine.invoice_items.find_all_by_invoice_id(@id)
    items = invoice_items.map do |invoice_item|
      @invoice_repo.sales_engine.items.find_by_id(invoice_item.item_id)
    end
  end

  def transactions
    @invoice_repo.sales_engine.transactions.find_all_by_invoice_id(@id)
  end

  def customer
    @invoice_repo.sales_engine.customers.find_by_id(@customer_id)
  end

  def paid_in_full?
  end


end
