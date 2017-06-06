require_relative '../lib/invoice_repository'

class Invoice
    attr_reader :id,
                :customer_id,
                :merchant_id,
                :status,
                :created_at,
                :updated_at,
                :all_invoice_data

  def initialize(invoice_data, invoice_repo)
    @id = invoice_data[:id].to_i
    @customer_id = invoice_data[:customer_id].to_i
    @merchant_id = invoice_data[:merchant_id].to_i
    @status = invoice_data[:status]
    @created_at = invoice_data[:created_at]
    @updated_at = invoice_data[:updated_at]
    @all_invoice_data = all_invoice_data
  end

end

# se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})
# invoice = se.invoices.find_by_id(6)
