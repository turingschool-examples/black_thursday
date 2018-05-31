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

  def inspect
   "#{self.class} #{@repository.size} rows"
  end
end
