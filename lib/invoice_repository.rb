require 'pry'
require 'CSV'
require 'time'
require_relative './invoice'
require_relative './repository'

class InvoiceRepository < Repository

  def new_record(row)
    Invoice.new(row)
  end

  def find_all_by_status(status)
    @all.find_all do |item|
      item.status == status
    end
  end

  def create(attributes)
    attributes[:id] = new_highest_id
    @all << new_item = Invoice.new(attributes)
    new_item
  end

  def update(id, attributes)
    invoice = find_by_id(id)
    return nil if invoice.nil?
    invoice.status = attributes[:status] unless attributes[:status].nil?
    invoice.updated_at = Time.now
    invoice
  end

  def find_all_by_updated_at(date)
    @all.find_all do |invoice|
      invoice.updated_at == date
    end
  end


end
