

class InvoiceItemRepository

  attr_accessor :repository

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @repository = []
  end

  def all
    @repository
  end

  def find_by_id(id)
    @repository.find do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_all_by_item_id(id)
    @repository.find_all do |invoice_item|
      invoice_item.item_id == id
    end
  end

  def find_all_by_invoice_id(id)
    @repository.find_all do |invoice_item|
      invoice_item.invoice_id == id
    end
  end

  def find_all_by_date(date)
    @repository.find_all do |invoice_item|
      date.strftime('%Y%m%d') == invoice_item.created_at.strftime("%Y%m%d")
    end
  end


  def inspect
  end

end
