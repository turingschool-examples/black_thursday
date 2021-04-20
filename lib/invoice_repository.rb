require_relative '../lib/invoice'
require_relative '../lib/repository'

class InvoiceRepository < Repository

  def initialize(path)
    super(path, Invoice)
  end

  def update(id, attributes)
    target = find_by_id(id)
    if target != nil
      target.status = attributes[:status] if attributes[:status] != nil
      target.updated_at = Time.now
    end
  end

  def find_all_by_customer_id(customer_id)
    @array_of_objects.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @array_of_objects.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    @array_of_objects.find_all do |invoice|
      invoice.status == status
    end
  end
end
