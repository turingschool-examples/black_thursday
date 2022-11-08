require 'requirements'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at
              # :invoices

  def initialize(info, repo)
    @id           = info[:id].to_i
    @customer_id  = info[:customer_id].to_i
    @merchant_id  = info[:merchant_id].to_i
    @status       = info[:status].to_sym
    @created_at   = Time.parse(info[:created_at])
    @updated_at   = Time.parse(info[:updated_at])
    @repo = repo
    # @invoices = []
  end

  def update(attributes)
    @status       = attributes[:status] if !attributes[:status].nil?
    @updated_at   = Time.now
  end
end