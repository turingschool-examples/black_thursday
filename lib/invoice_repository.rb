require_relative 'invoice'

class InvoiceRepository
  attr_reader :all,
              :sales_engine

  def initialize(parent = nil)
    @all          = []
    @sales_engine = parent
  end

  def inspect
   "#<#{self.class} #{@all.size} rows>"
  end

  def populate(filename)
    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
      @all << Invoice.new(row, self)
    end
  end

  def find_by_id(id)
    @all.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_customer_id(customer_id)
    @all.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_status(status)
    @all.find_all do |invoice|
      invoice.status == status.to_sym
    end
  end

  def find_merchant_for_invoice(merchant_id)
    @sales_engine.find_merchant_for_invoice(merchant_id)
  end

  def find_item_ids_from_invoice_id(id)
    @sales_engine.find_item_ids_from_invoice_id(id)
  end

  def find_all_items_by_item_id(item_id)
    @sales_engine.find_all_items_by_item_id(item_id)
  end

  def find_transaction_by_invoice_id(invoice_id)
    @sales_engine.find_transaction_by_invoice_id(invoice_id)
  end

  def find_customer_by_customer_id(customer_id)
    @sales_engine.find_customer_by_customer_id(customer_id)
  end

  def find_invoice_item_id(id)
    @sales_engine.find_invoice_item_id(id)
  end

end
