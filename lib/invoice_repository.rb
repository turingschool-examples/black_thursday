require 'CSV'
require 'pry'
require 'time'
require 'bigdecimal'
require_relative '../lib/black_thursday_helper'
require_relative '../lib/invoice'

class InvoiceRepository
  include BlackThursdayHelper

  def initialize(file_path)
    @collections = []
    populate(file_path)
  end

  def update(id, attributes)
      if find_by_id(id) != nil
      object_to_be_updated = find_by_id(id)
      object_to_be_updated.status = attributes[:status]
      object_to_be_updated.updated_at = Time.now
      else
        nil
      end
  end

  def populate(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @collections << Invoice.new(data)
    end
  end

  def create(invoice_params)
    invoice = Invoice.new(invoice_params)
    highest_current = object_id_counter.id
    new_highest_current = highest_current += 1
    invoice.id = new_highest_current
    @collections << invoice
    invoice
  end

end
