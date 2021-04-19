require_relative './invoice_item'
require 'time'
require 'csv'
require 'bigdecimal'

class InvoiceItemRepo

  attr_reader :invoice_item_list

  def initialize(csv_files, engine)
    @invoice_item_list = invoice_item_instances(csv_files)
    @engine = engine
  end

  def invoice_item_instances(csv_files)
    invoice_items = CSV.open(csv_files, headers: true,
    header_converters: :symbol)

    @invoice_items_list = invoice_items.map do |invoice_item|
      InvoiceItem.new(invoice_item, self)
    end
  end

  def all
    @invoice_item_list
  end

  def find_by_id(id)
    @invoice_item_list.find do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_all_by_item_id(item_id)
    @invoice_item_list.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_item_list.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def create(attributes)
    new_invoice_item = InvoiceItem.new(attributes, self)
    new_invoice_item.id = (@invoice_item_list.last.id + 1)
    @invoice_item_list << new_invoice_item
  end

  def update(id, attributes)
    invoice_item = find_by_id(id)
    if !invoice_item.nil?
      invoice_item.quantity = attributes[:quantity] unless attributes[:quantity].nil?
      invoice_item.unit_price = BigDecimal(attributes[:unit_price]/100, 5) unless attributes[:unit_price].nil?
      invoice_item.updated_at = Time.now
    end
    invoice_item
  end

  def delete(id)

  end
end
