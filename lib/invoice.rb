require 'time'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :invoices

  def initialize(info, repo)
    @id           = info[:id]
    @customer_id  = info[:customer_id]
    @merchant_id  = info[:merchant_id]
    @status       = info[:status]
    @created_at   = Time.parse(info[:created_at])
    @updated_at   = Time.parse(info[:updated_at])
    @repo = repo
    @invoices = []
  end

  def update(info)
    @status       = info[:status] if (info[:status] != nil)
    @updated_at   = Time.now
  end
end