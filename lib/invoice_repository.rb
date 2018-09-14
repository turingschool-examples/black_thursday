require 'CSV'
require_relative 'repo_module'

class InvoiceRepository
  include RepoModule

  attr_reader :repo
  def initialize(file_path)
    @repo = []
    load_invoice(file_path)
  end

  def load_invoice(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @repo << Invoice.new(row)
    end
  end

  def find_all_by_customer_id(id_number)
    @repo.find_all do |invoice|
      invoice.customer_id == id_number
    end
  end

  def find_all_by_status(status)
    @repo.find_all do |invoice|
      invoice.status == status
    end
  end

  def create(attributes)
    attributes[:id] = @repo[-1].id + 1
    @repo << Invoice.new(attributes)
  end

  def update(id, attributes)
    invoice = find_by_id(id)
    invoice.status = attributes[:status] unless attributes[:status].nil?
    invoice.updated_at = Time.now unless attributes[:status].nil?
  end

end
