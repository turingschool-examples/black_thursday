require 'bigdecimal'
require 'time'

class Invoice
  attr_reader   :id,
                :customer_id,
                :merchant_id,
                :created_at,
                :invoice_repo

  attr_accessor :status,
                :updated_at

  def initialize(row, invoice_repo)
    @id = (row[:id]).to_i
    @customer_id = row[:customer_id].to_i
    @merchant_id = (row[:merchant_id]).to_i
    @status = (row[:status])
    @created_at = Time.parse(row[:created_at])
    @updated_at = Time.parse(row[:updated_at])
    @invoice_repo = invoice_repo
  end

  def update
    @updated_at = Time.now
  end

end
