require 'time'
require 'bigdecimal'
# require_relative "invoice_repo"

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :invoice_repo

  def initialize(row, invoice_repo)
    @id           = row[:id]
    @customer_id  = row[:customer_id]
    @merchant_id  = row[:merchant_id]
    @status       = row[:status].to_sym
    @created_at   = Time.parse(row[:created_at])
    @updated_at   = Time.parse(row[:updated_at])
    @invoice_repo = invoice_repo
  end

  def merchant
    @invoice_repo.find_merchant_by_id(self.merchant_id)
  end
end
