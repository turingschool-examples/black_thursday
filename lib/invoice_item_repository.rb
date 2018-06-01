require_relative 'invoice_item'

class InvoiceItemsRepository
  attr_reader :all

  def initialize
    @all = []
  end

  def load_invoice_items(csv)
    csv.each do |invoice_item|
      invoice_item[:unit_price] = BigDecimal(invoice_item[:unit_price]) / 100
      invoice_item[:created_at] = Time.parse(invoice_item[:created_at])
      invoice_item[:updated_at] = Time.parse(invoice_item[:updated_at])
      @all << InvoiceItem.new(invoice_item)
    end
  end

  def find_by_id(id) # module
    @all.find do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_all_by_item_id(id)
    @all.find_all do |invoice_item|
      invoice_item.item_id == id
    end
  end

  def find_all_by_invoice_id(id)
    @all.find_all do |invoice_item|
      invoice_item.invoice_id == id
    end
  end

  def create(attributes)
    attributes[:id] = @all.map do |invoice_item|
      invoice_item.id
    end.max + 1
    @all << InvoiceItem.new(attributes)
  end

  def update(id, attributes)
    invoice_item = find_by_id(id)
    if invoice_item
      invoice_item.update_quantity(attributes[:quantity])
      invoice_item.update_price(attributes[:unit_price])
      invoice_item.update_updated_at(Time.now)
    end
  end

  def delete(id)
    @all.each do |invoice_item|
      if invoice_item.id == id
        @all.delete(invoice_item)
      end
    end
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end
end
