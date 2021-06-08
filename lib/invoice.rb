require 'CSV'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :repo

  def initialize(invoice_data, repo)
    @id = invoice_data[:id].to_i
    @customer_id = invoice_data[:customer_id].to_i
    @merchant_id = invoice_data[:merchant_id].to_i
    @status = invoice_data[:status].to_s
    @created_at = invoice_data[:created_at]
    @updated_at = invoice_data[:updated_at]
    @repo = repo

  end

  def update_time
    @updated_at = Time.now
  end

  def change_status(status)
    @status = status
  end

end
