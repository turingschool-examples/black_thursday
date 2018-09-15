require_relative './invoice_item'

require 'time'
require 'pry'

class InvoiceItemRepository
  attr_reader :invoice_items_array
  def initialize(file_path)
    @invoice_items_array = invoice_item_csv_converter(file_path)
  end

  def invoice_item_csv_converter(file_path)
    csv_objs = CSV.read(file_path, {headers: true, header_converters: :symbol})
    csv_objs.map do |obj|
      obj[:id] = obj[:id].to_i
      obj[:item_id] = obj[:item_id].to_i
      obj[:invoice_id] = obj[:invoice_id].to_i
      obj[:quantity] = obj[:quantity].to_i
      obj[:unit_price] = BigDecimal.new(obj[:unit_price])/100
      obj[:updated_at] = Time.parse(obj[:updated_at])
      obj[:created_at] = Time.parse(obj[:created_at])
      InvoiceItem.new(obj.to_h)
    end
  end

  def inspect
    "#<#{self.class} #{@invoice_items_array.size} rows>"
  end

  def all
    @invoice_items_array
  end

  def find_by_id(id)
    findings = @invoice_items_array.find_all do |invoice_item|
      invoice_item.id == id
    end
    findings[0]
  end

  def find_all_by_item_id(id)
    @invoice_items_array.find_all do |invoice_item|
      invoice_item.item_id == id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items_array.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def create(attributes)
    last_invoice = @invoice_items_array.last
    if last_invoice == nil
      max_id = 1
    else
      max_id = last_invoice.id + 1
    end
    time = attributes[:created_at].getutc
    attributes = {:id => max_id,
                  :item_id => attributes[:item_id],
                  :invoice_id => attributes[:invoice_id],
                  :quantity => attributes[:quantity],
                  :unit_price => attributes[:unit_price],
                  :created_at => time,
                  :updated_at => time }
    @invoice_items_array << InvoiceItem.new(attributes)
  end

  def update(id, attributes)
    invoice_item = find_by_id(id)
    if attributes[:quantity].class == Fixnum
      invoice_item.updated_at = Time.now
      invoice_item.quantity = attributes[:quantity]
    else
      "Not a valid entry"
    end
  end

  def delete(id)
    invoice_item = find_by_id(id)
    if invoice_item != nil
      @invoice_items_array.delete(invoice_item)
    else
      puts 'Invoice_item not found'
    end
  end
end
