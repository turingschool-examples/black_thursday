class InvoiceRepository
  def initialize(invoices)
    @invoices = invoices
  end

  def all
    @invoices
  end

  def find_by_id(id)
    if !a_valid_id?()
      return nil
    else
      @invoices.find do |invoice|
        invoice.id == id
      end
    end
  end

  def find_all_by_customer_id(id)
    if !a_valid_id?()
      return nil
    else
      @invoices.find do |invoice|
        invoice.id == id
      end
    end
  end

  def a_valid_id?(id)
    @merchants.any? do |merchant| merchant.id == id
    end 
  end

  def find_all_by_merchant_id(id)
    if !a_valid_id?()
      return nil
    else
      @invoices.find do |invoice|
        invoice.id == id
      end
    end
  end

  def find_all_by_status(id)
    if !a_valid_id?()
      return nil
    else
      @invoices.find do |invoice|
        invoice.id == id
      end
    end
  end

  def create(attribute)
    new_invoice = @invoices.last.id + 1
    @invoices << Invoice.new({:id => new_id, :name => attribute})
  end

  def update(id, attribute)
    @invoices.each do |invoice|
      if invoice.id == id
        invoice_new_status = invoice.name.replace(attribute)
        return invoice_new_status
      end
    end
  end

  def delete(id)
    @invoices.delete(find_by_id(id))
  end

    def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end