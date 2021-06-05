require 'time'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :repo

  def initialize(invoice_info, repo)
    @id          = invoice_info[:id].to_i
    @customer_id = invoice_info[:customer_id].to_i
    @merchant_id = invoice_info[:merchant_id].to_i
    @status      = invoice_info[:status].to_sym
    @created_at  = Time.parse(invoice_info[:created_at])
    @updated_at  = Time.parse(invoice_info[:updated_at])
    @repo        = repo
  end

  def self.create_new(attributes, repo)
    data_hash = {}
    time = time = Time.now.utc.strftime("%m-%d-%Y %H:%M:%S %Z")
    data_hash[:id] = repo.next_highest_id
    data_hash[:customer_id] = attributes[:customer_id]
    data_hash[:merchant_id] = attributes[:merchant_id]
    data_hash[:status] = attributes[:status]
    data_hash[:created_at] = time
    data_hash[:updated_at] = time
    new(data_hash, repo)
  end

  def update_invoice(attributes)
    @status = attributes[:status]
    @updated_at = Time.now
  end
end
