class InvoiceItemRepository
  attr_reader :all

  def initialize(all)
    @all = all
  end

  def find_by_id(id)
    @all.find_all do |invoiceitem|
      invoiceitem.id == id
    end.pop
  end

  def find_all_by_item_id(item_id)
    @all.find_all do |invoiceitem|
     invoiceitem.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |invoiceitem|
     invoiceitem.invoice_id == invoice_id
    end
  end

  def create(attributes)
    id_max = @all.max_by {|invoiceitem| invoiceitem.id}
    attributes[:id] = id_max.id + 1
    new = InvoiceItem.new(attributes)
    @all.push(new)
  end

  def update(id, attribute)

    updated_invoice_item = self.find_by_id(id)
      updated_invoice_item.quantity = attribute[:quantity]
      updated_invoice_item.unit_price = attribute[:unit_price]
      updated_invoice_item.updated_at = attribute[:updated_at]
    updated_invoice_item
  end

  def delete(id)
    x = (self.all).find_index(self.find_by_id(id))
    self.all.delete_at(x)
    self.all
  end

  def inspect
   "#<#{self.class} #{@invoiceitem.size} rows>"
 end
end
