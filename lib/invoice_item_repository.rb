require_relative 'repository'
require_relative 'invoice_item'

class InvoiceItemRepository
  include Repository

  def initialize(loaded_file)
    @repository = loaded_file.map { |inv_itm| InvoiceItem.new(inv_itm) }
  end

  def find_all_by_item_id(item_id)
    all.find_all { |inv_itm| inv_itm.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all { |inv_itm| inv_itm.invoice_id == invoice_id }
  end

  def create(attributes)
    attributes[:id] = new_highest_id
    @repository.push(InvoiceItem.new(attributes))
  end

  def update(id, attributes)
    invoice_item = find_by_id(id)
    return invoice_item if invoice_item.nil?
    invoice_item.update_quantity(attributes[:quantity]) unless attributes[:quantity].nil?
    invoice_item.update_unit_price(attributes[:unit_price]) unless attributes[:unit_price].nil?
    invoice_item.new_update_time(Time.now.utc) if attributes.count.positive?
  end

end
