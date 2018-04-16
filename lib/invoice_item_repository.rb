require_relative './repository'
require_relative './invoice_item'
require 'bigdecimal'
require 'time'

class InvoiceItemRepository
  include Repository
  attr_reader   :repository

  def initialize(invoice_items)
    invoice_item_array = []
    @repository = {}
    invoice_items.each { |invoice_item| invoice_item_array << InvoiceItem.new(to_invoice_item(invoice_item))}
    invoice_item_array.each do |invoice_item|
      if invoice_item.nil?
      else
        @repository[invoice_item.id] = invoice_item
      end
    end
  end

  def to_invoice_item(invoice_item)
    invoice_item_hash = {}
    invoice_item.each do |line|
      invoice_item_hash[line[0]] = line[1]
    end
    invoice_item_hash
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
