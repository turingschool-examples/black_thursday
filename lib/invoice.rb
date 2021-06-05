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
    @created_at  = invoice_info[:created_at]
    @updated_at  = invoice_info[:updated_at]
    @repo        = repo
  end

  def self.create_new(attributes, invoice_repo)
    data_hash = {}
    data_hash[:id] = invoice_repo.next_highest_id
    data_hash[:customer_id] = attributes[:customer_id]
    data_hash[:merchant_id] = attributes[:merchant_id]
    data_hash[:status] = attributes[:status]
    data_hash[:created_at] = Time.now
    data_hash[:updated_at] = Time.now
    new(data_hash, invoice_repo)
  end

end
