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
end
