class TransactionRepository

  def initialize
    @invoice_item = invoice_item
  end

  def all
    @invoice_item
  end

  def a_valid_id?(id)
    @merchants.any? do |merchant| merchant.id == id
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

  def find_all_by_customer_id(id)
    if !a_valid_id?()
      return nil
    else
      @invoice_item.find do |invoice|
        invoice.id == id
      end
    end
  end

  def find_all_by_customer_id(id)
    if !a_valid_id?()
      return nil
    else
      @invoice_item.find do |invoice|
        invoice.id == id
      end
    end
  end

  def create(attribute)
    new_invoice = @invoice_item.last.id + 1
    @invoice_item << InvoiceItem.new({:id => new_id, :name => attribute})
  end

  def update(id, attribute)
    @invoice_item.each do |invoice|
      if invoice.id == id
        invoice_new_status = invoice.name.replace(attribute)
        return invoice_new_status
      end
    end
  end

  def delete(id)
    @invoice_item.delete(find_by_id(id))
  end
end
end