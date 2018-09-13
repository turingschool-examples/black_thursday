require_relative './invoice_item'
require_relative './repository'

class InvoiceItemRepository < Repository

  def initialize(filepath)
    super()
    load_items(filepath)
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol ) do |datum|
      datum[:unit_price] = BigDecimal(datum[:unit_price],4)/100
      @data << InvoiceItem.new(datum)
    end
  end

  def find_all_by_item_id(item_id)
    @data.find_all do |datum|
      datum.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @data.find_all do |datum|
      datum.invoice_id == invoice_id
    end
  end

  def create(attributes)
    highest_id = @data.max_by do |datum|
      datum.id
    end.id
    new_item_id = highest_id += 1
    attributes[:id] = new_item_id
    new_item = InvoiceItem.new(attributes)

    @data << new_item
    return new_item
  end

  def update(id, attributes)
    item = find_by_id(id)
    return if item.nil?
    attributes.each do |key, value|
      item.quantity = value if key == :quantity
      item.unit_price = value if key == :unit_price
    end
    current_time = Time.now + 1
    item.updated_at = current_time.to_s
  end
end
