require 'csv'
require_relative 'invoice'

class InvoiceRepository
  attr_reader :all

  def initialize(filepath)
    @filepath = filepath
    @all = []
    CSV.foreach(@filepath, headers: true, header_converters: :symbol) do |row|
      @all << Invoice.new(row)
    end
  end

  def find_by_id(id)
    @all.find { |invoice| invoice.id == id }
  end

  def find_all_by_customer_id(customer_id)
    @all.find_all { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_all_by_status(status)
    @all.find_all { |invoice| invoice.status == status }
  end

  def create(attributes)
    attributes[:id] = @all.max_by { |invoice| invoice.id }.id + 1
    @all << Invoice.new(attributes)
    @all.last
  end

  def update(id, attributes)
    if find_by_id(id)
      find_by_id(id).update(attributes)
    end
  end

  def delete(id)
    @all.delete_if { |invoice| invoice.id == id }
  end
end
