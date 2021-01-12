require 'csv'
require 'bigdecimal'
require 'time'
require_relative './invoice_item'

class InvoiceItemRepository
  attr_reader :all,
              :engine

  def initialize(invoice_items_path, engine)
    @all = []
    @engine = engine

    CSV.foreach(invoice_items_path, headers: true, header_converters: :symbol) do |row|
      @all << convert_to_invoice_item(row)
    end
  end

  def convert_to_invoice_item(row)
    row = InvoiceItem.new({
                      id: row[:id],
                 item_id: row[:item_id],
              invoice_id: row[:invoice_id],
                quantity: row[:quantity],
              unit_price: row[:unit_price],
              created_at: row[:created_at],
              updated_at: row[:updated_at]
                      }, self)
  end

  def find_by_id(id)
    @all.find do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_all_by_item_id(item_id)
    @all.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def new_highest_id
    @all.max_by do |invoice_item|
      invoice_item.id
    end.id + 1
  end

  def create(attributes)
    attributes[:id] = new_highest_id
    @all << InvoiceItem.new(attributes, self)
  end

  def update(id, attributes)
    if find_by_id(id) != nil
      update_invoice_item = all.find { |invoice_item| invoice_item.id == id }
      update_invoice_item.unit_price = BigDecimal(attributes[:unit_price]) if attributes[:unit_price] != nil
      update_invoice_item.quantity = attributes[:quantity] if attributes[:quantity] != nil
      update_invoice_item.updated_at = Time.now
    end
  end

  def delete(id)
    remove = find_by_id(id)
    @all.delete(remove)
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end
end
