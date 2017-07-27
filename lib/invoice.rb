
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
end
