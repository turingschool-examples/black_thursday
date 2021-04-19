class InvoiceItemRepository
  attr_reader :invoice_items

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def initialize(filename)
    @invoice_items = create_invoice_items(filename)
  end

  def create_invoice_items(filename)
    FileIo.process_csv(filename, InvoiceItem)
  end

  def all
    @invoice_items
  end

  def find_by_id(id)
    @invoice_items.find do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_all_by_item_id(id)
    @invoice_items.select do |invoice_item|
      invoice_item.item_id == id
    end
  end

  def find_all_by_invoice_id(id)
    @invoice_items.select do |invoice_item|
      invoice_item.invoice_id == id
    end
  end

  def create_first_invoice_item(attributes)
    new_invoice_item = InvoiceItem.new(attributes)
    new_invoice_item.update_id(1)
    @invoice_items << new_invoice_item
  end

  def find_max_id
    @invoice_items.max_by(&:id).id
  end

  def create(attributes)
    if @invoice_items == []
      create_first_invoice_item(attributes)
    else
      new_invoice_item = InvoiceItem.new(attributes)
      new_invoice_item.update_id(find_max_id + 1)
      @invoice_items << new_invoice_item
    end
  end

  def update(id, attributes)
    invoice_item = find_by_id(id)
    unless invoice_item.nil?
      invoice_item.update_quantity(attributes[:quantity])
      invoice_item.update_unit_price(attributes[:unit_price])
      invoice_item.new_updated_at_time
    end
  end

  def delete(id)
    return nil if find_by_id(id).nil?

    invoice_item = find_by_id(id)
    @invoice_items.delete(invoice_item)
  end
end
