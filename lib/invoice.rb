require 'time'

class Invoice
  attr_reader :id,
              :created_at,
              :invoice_repo
  attr_accessor :status,
                :updated_at,
                :customer_id,
                :merchant_id

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
end
