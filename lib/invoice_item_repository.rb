require 'csv'

class InvoiceItemRepository
  def initialize(path)
    @path = path
    @rows = CSV.read(@path, headers: true, header_converters: :symbol)
    @all = all
  end

  def all
    @rows.map do |row|
      InvoiceItem.new(row)
    end
  end

  def find_by_id(id)
    result = @all.find do |row|
      row.id == id
    end
    result
  end

  def find_all_by_item_id(item_id)
    @all.find_all do |row|
      row.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |row|
      row.invoice_id == invoice_id
    end
  end

  def create(attributes)
    attributes[:id] = @all.last.id + 1
    @all << InvoiceItem.new(attributes)
  end

  def update(id, attributes)
    invoice_item_to_update = find_by_id(id)
    if attributes[:quantity] != nil
      invoice_item_to_update.quantity = attributes[:quantity]
    end
    if attributes[:unit_price] != nil
      invoice_item_to_update.unit_price = attributes[:unit_price]
    end
    invoice_item_to_update.updated_at = Time.now
    invoice_item_to_update
  end

  def delete(id)
    invoice_item_to_delete = find_by_id(id)
    @all.delete(invoice_item_to_delete)
  end
end
