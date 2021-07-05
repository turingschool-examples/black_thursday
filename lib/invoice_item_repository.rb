require_relative 'invoice_item'

class InvoiceItemRepository
  def initialize(loaded_file)
    @repository = loaded_file.map {|inv_itm| InvoiceItem.new(inv_itm)}
  end

  def all
    @repository
  end

  def find_by_id(id)
    all.find {|inv_itm| id == inv_itm.id}
  end

  def find_all_by_item_id(item_id)
    all.find_all {|inv_itm| inv_itm.item_id == item_id}
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all {|inv_itm| inv_itm.invoice_id == invoice_id}
  end

  def create(attributes)
    highest = all.max_by {|inv_itm| inv_itm.id}
    attributes[:id] = (highest.id + 1)
    @repository << InvoiceItem.new(attributes)
  end

  def update(id, attributes)
    invoice_item = find_by_id(id)
    return invoice_item if invoice_item == nil
    invoice_item.update_quantity(attributes[:quantity]) if attributes[:quantity] != nil
    invoice_item.update_unit_price(attributes[:unit_price]) if attributes[:unit_price] != nil
    invoice_item.new_update_time(Time.now.utc) if attributes.count > 0
  end

  def delete(id)
    invoice_item = find_by_id(id)
    @repository.delete(invoice_item)
  end

  def inspect
   "#{self.class} #{@repository.size} rows"
  end
end
