require_relative 'invoice.rb'
require_relative 'repository_helper.rb'

class InvoiceRepository
  include RepositoryHelper
  attr_reader :repository

  def initialize(file_contents)
    @repository = file_contents.map { |invoice| Invoice.new(invoice) }
  end

  def find_all_by_customer_id(customer_id)
    @repository.select { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_status(status)
    @repository.select { |invoice| invoice.status == status }
  end

  def create(attributes)
    sorted = @repository.sort_by(&:id)
    new_id = sorted.last.id + 1
    attributes[:id] = new_id
    new_invoice = Invoice.new(attributes)
    @repository << new_invoice
    new_invoice
  end

  def update(id, attributes)
    invoice = find_by_id(id)
    return if invoice.nil?
    invoice.status = attributes[:status]
    invoice.updated_at = Time.now
    invoice
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end
end
