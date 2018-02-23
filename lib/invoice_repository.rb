require_relative 'searching'
require_relative 'invoice'

# Repository for handling and storing invoice items
class InvoiceRepository
  include Searching
  attr_reader :all

  def initialize
    @all = []
  end

  def add_elements(data)
    @all = data.map { |row| Invoice.new(row) }
  end

  def find_all_by_customer_id(id)
    @all.find_all { |obj| obj.customer_id == id }
  end

  def find_all_by_status(status)
    @all.find_all { |obj| obj.status == status.to_sym }
  end

  def inspect
    self
  end
end
