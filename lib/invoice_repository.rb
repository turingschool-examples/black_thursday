require_relative 'repository'
require_relative 'invoice'

class InvoiceRepository
  include Repository

  def initialize(loaded_file)
    @repository = loaded_file.map { |invoice| Invoice.new(invoice)}
  end

  def all
    @repository
  end

  def find_by_id(id)
    all.find {|invoice| invoice.id == id}
  end

  def find_all_by_customer_id(customer_id)
    all.find_all {|invoice| invoice.customer_id == customer_id}
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all {|invoice| invoice.merchant_id == merchant_id}
  end

  def find_all_by_status(status)
    all.find_all {|invoice| invoice.status == status}
  end

  def create(attributes)
    highest = all.max_by {|invoice| invoice.id}
    invoice =  {id: (highest.id + 1),
                customer_id: attributes[:customer_id],
                merchant_id: attributes[:merchant_id],
                status: attributes[:status].to_sym,
                created_at: Time.now,
                updated_at: Time.now}
    @repository.push(Invoice.new(invoice))
  end

  def update(id, attributes)
    invoice = find_by_id(id)
    invoice.update_status(attributes[:status]) if !(attributes[:status].nil?)
    invoice.update_time(Time.now) if attributes.length > 0
  end

  def delete(id)
    invoice = find_by_id(id)
    @repository.delete(invoice)
  end

end
