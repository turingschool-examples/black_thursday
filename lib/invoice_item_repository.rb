class InvoiceItemRepository

  def initialize
    @invoice_item = invoice_item
  end

  def all
    @invoice_item
  end

  def find_by_id(id)
    if !a_valid_id?()
      return nil
    else
      @invoice_item.find do |invoice|
        invoice.id == id
      end
    end
  end

  def a_valid_id?(id)
    @invoice_item.any? do |invoice| invoice.id == id
    end 
  end

  def create(attribute)
    new_invoice_item = @invoice_item.last.id + 1
    @invoice_item << Invoice.new({:id => new_id, :name => attribute})
  end

  def update(id, attribute)
    @invoice_item.each do |invoice|
      if invoice.id == id
        invoice_update = invoice.name.replace(attribute)
        return invoice_update
      end
    end
  end

  def delete(id)
    @invoice_item.delete(find_by_id(id))
  end
end