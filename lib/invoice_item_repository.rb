require_relative './repository'
require_relative './invoice_item'
require 'bigdecimal'
require 'time'

class InvoiceItemRepository
  include Repository
  attr_reader   :repository

  def initialize(invoice_items)
    create_repository(invoice_items, InvoiceItem)
  end

  def find_all_by_item_id(ii)
    @repository.values.find_all do |invoice_item|
      invoice_item.item_id == ii
    end
  end

  def find_all_by_invoice_id(ii)
    @repository.values.find_all do |invoice_item|
      invoice_item.invoice_id == ii
    end
  end

  def create(attributes)
    attributes[:id] = (find_highest_id + 1)
    if attributes[:created_at].nil?
      attributes[:created_at] = Time.now.to_s
    else
      attributes[:created_at] = attributes[:created_at].to_s
    end
    attributes[:updated_at] = attributes[:updated_at].to_s
    invoice_item = InvoiceItem.new(attributes)
    @repository[invoice_item.id] = invoice_item
  end


end
