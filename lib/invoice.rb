require 'bigdecimal'
require 'time'

class Invoice
  attr_reader :repo,
              :id,
              :customer_id,
              :merchant_id,
              :created_at

  attr_accessor :status,
                :updated_at

  def initialize(invoice_hash, repo)
    @id = invoice_hash[:id].to_i
    @customer_id = invoice_hash[:customer_id].to_i
    @merchant_id = invoice_hash[:merchant_id].to_i
    @status = invoice_hash[:status].to_sym
    @created_at = Time.parse(invoice_hash[:created_at].to_s)
    @updated_at = Time.parse(invoice_hash[:updated_at].to_s)
    @repo = repo
  end

  def to_hash
    self_hash = Hash.new
    self_hash[:id] = @id
    self_hash[:customer_id] = @customer_id
    self_hash[:merchant_id] = @merchant_id
    self_hash[:status] = @status
    self_hash[:created_at] = @created_at
    self_hash[:updated_at] = @updated_at
    self_hash
  end
end
