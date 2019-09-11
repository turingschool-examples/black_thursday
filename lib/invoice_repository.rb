require_relative 'repository'
require_relative 'invoice'

class InvoiceRepository < Repository
  def find_all_by_customer_id(customer_id)
    by_customer_id = []
    @members.each do |invoice|
      if invoice.customer_id == customer_id
        by_customer_id << invoice
      end
    end
    by_customer_id.compact
  end

  def find_all_by_status(status)
    @members.map do |invoice|
      if invoice.status == status.to_sym
        invoice
      end
    end.compact
  end

  def create(attributes)
    if attributes[:id] == nil
      attributes[:id] = find_next_id
    end
    @members.push(Invoice.new(attributes))
  end
end
