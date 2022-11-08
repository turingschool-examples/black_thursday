require_relative 'repository'
require_relative 'merchant'

class InvoiceRepository < Repository
  def find_all_by_customer_id(id)
    @all.select do |invoice|
      invoice.customer_id == id
    end
  end

  def find_all_by_status(status)
    @all.select do |invoice|
      invoice.status == status
    end
  end

  def update(id, attributes)
    sanitized_attributes = {
      status: attributes[:status],
      updated_at: Time.now
    }.compact
    super(id, sanitized_attributes)
  end
end