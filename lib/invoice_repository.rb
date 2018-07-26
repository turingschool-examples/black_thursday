require_relative 'invoice'
require_relative 'repository_assistant'

class InvoiceRepository
  include RepositoryAssistant

  def initialize(data_file)
    @repository = data_file.map {|item| Invoice.new(item)}
  end

  def find_all_by_customer_id(id)
    @repository.find_all do |invoice|
      invoice.customer_id == id
    end
  end

  def find_all_by_merchant_id(id)
    @repository.find_all do |invoice|
      invoice.merchant_id == id
    end
  end

  def find_all_by_status(status)
    @repository.find_all do |invoice|
      invoice.status.downcase.include?(status.downcase)
    end
  end

  def create(attributes)
    attributes[:id] = create_new_id_number
    @repository << Invoice.new(attributes)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end
end
