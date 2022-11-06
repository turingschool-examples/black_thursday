require_relative 'repository'

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

  def create(attributes)
    attributes[:id] = max_id
    add_to_repo(Invoice.new(attributes))
  end

  def update(id, attributes)
    sanitized_attributes = {
      status: attributes[:status],
      updated_at: Time.now
    }
    super(id, sanitized_attributes)
  end
end