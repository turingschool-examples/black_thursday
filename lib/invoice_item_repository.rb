class InvoiceItemRepository
  attr_reader :invoiceitems

  def inspect
    "#<#{self.class} #{@invoiceitems.size} rows>"
  end

  def initialize(invoiceitems)
    @invoiceitems = invoiceitems
  end

  def all
    @invoiceitems
  end

  def find_by_id(id)
    @invoiceitems.find {|invoiceitem| invoiceitem.id == id}
  end


end
