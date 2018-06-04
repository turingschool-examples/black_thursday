require_relative 'repository'
require_relative 'invoice'

class InvoiceRepository
  include Repository

  def initialize(loaded_file)
    @repository = loaded_file.map { |invoice| Invoice.new(invoice) }
  end

  def find_all_by_customer_id(customer_id)
    all.find_all { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_all_by_status(status)
    all.find_all { |invoice| invoice.status == status }
  end

  def create(attributes)
    attributes[:id] = new_highest_id
    @repository.push(Invoice.new(attributes))
  end

  def update(id, attributes)
    invoice = find_by_id(id)
    invoice.update_status(attributes[:status]) unless attributes[:status].nil?
    invoice.update_time(Time.now) unless attributes.empty?
  end
end
