class Invoice
  attr_reader :id, :custumer_id, :merchant_id, :status,
              :created_at, :updated_at, :repository

  def initialize(invoice_hash, repository)
    @repository = repository
    @id = invoice_hash[:id].to_i
    @costumer_id = invoice_hash[:costumer_id]
    @merchant_id = invoice_hash[:merchant_id]
    @status = invoice_hash[:status]
    @created_at = Time.parse(invoice_hash[:created_at])
    @updated_at = Time.parse(invoice_hash[:updated_at])
  end

  # def items
  #   @repository.find_items(@id)
  # end
end
