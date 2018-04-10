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
    @updated_time = Time.now.strftime('%F')
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

end
