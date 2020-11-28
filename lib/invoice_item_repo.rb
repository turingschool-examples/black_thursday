require 'CSV'
require 'pry'
require 'time'
require_relative '../lib/black_thursday_helper'
require_relative '../lib/invoice_item'

class InvoiceItemRepo
  include BlackThursdayHelper

  def initialize(filepath)
    @collections = []
    populate(filepath)
  end

  def populate(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |params|
      @collections << InvoiceItem.new(params)
    end
  end

  def update(id, attributes)
    if find_by_id(id) != nil
      object_to_be_updated = find_by_id(id)
      object_to_be_updated.quantity = attributes[:quantity]
      object_to_be_updated.unit_price = attributes[:unit_price]
      object_to_be_updated.updated_at = Time.now
    else
      nil
    end
  end

  def create(in_item_params)
    invoice_item = InvoiceItem.new(in_item_params)
    new_highest_current = object_id_counter.id + 1
    invoice_item.id = new_highest_current
    @collections << invoice_item
    invoice_item
  end

end
