require 'CSV'

class Invoice
  attr_reader :id,
              :merchant_id,
              :created_at,
              :updated_at,
              :customer_id,
              :status

  def initialize(invoice_data, repo)
    @id = invoice_data[:id].to_i
    @merchant_id = invoice_data[:merchant_id].to_i
    @created_at = Time.parse(invoice_data[:created_at].to_s)
    @updated_at = Time.parse(invoice_data[:updated_at].to_s)
    @customer_id = invoice_data[:customer_id].to_i
    @repo = repo
    @status = invoice_data[:status].to_s
  end

  def update_time
    @updated_at = Time.now
  end

  def change_status(status)
    @status = status
  end

end
