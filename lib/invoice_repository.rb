require_relative '../lib/invoice'

class InvoiceRepository
  attr_reader :list_of_invoices,
              :parent_engine

  def initialize(invoices_data, parent_engine)
    @parent_engine = parent_engine
    @list_of_invoices = populate_invoices(invoices_data)
  end

  def populate_invoices(invoices_data)
    invoices_data.map do |datum|
      Invoice.new(datum, self)
    end
  end

  def all
    list_of_invoices
  end

  def find_by_id(id_to_find)
    @list_of_invoices.find do |invoice|
      invoice.id == id_to_find
    end
  end

  def find_all_by_customer_id(customer_id_to_find)
    @list_of_invoices.find_all do |invoice|
      invoice.customer_id == customer_id_to_find
    end
  end

  def find_all_by_merchant_id(merchant_id_to_find)
    @list_of_invoices.find_all do |invoice|
      invoice.merchant_id == merchant_id_to_find
    end
  end

  def find_all_by_status(status_to_find)
    @list_of_invoices.find_all do |invoice|
      invoice.status == status_to_find
    end
  end

end
