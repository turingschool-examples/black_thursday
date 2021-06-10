class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :repo

  def initialize(info, repo)
    @id          = info[:id].to_i
    @customer_id = info[:customer_id].to_i
    @merchant_id = info[:merchant_id].to_i
    @status      = info[:status].to_sym
    @created_at  = info[:created_at].is_a?(Time) ? info[:created_at] : Time.parse(info[:created_at])
    @updated_at  = info[:updated_at].is_a?(Time) ? info[:updated_at] : Time.parse(info[:updated_at])
    @repo = repo
  end

  def update_invoice(attributes)
    @status = attributes[:status] unless attributes[:status].nil?
    @updated_at = Time.now
  end
end
