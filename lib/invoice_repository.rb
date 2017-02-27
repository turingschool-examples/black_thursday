require './lib/invoice'

class InvoiceRepository
  def initialize(invoice_csv, parent)
    @invoice_csv = CSV.open invoice_csv, headers: true, header_converters: :symbol
    @parent = parent
    make_repository
  end

  def make_repository
    @repository = {}
    @invoice_csv.read.each do |invoice|
      @repository[invoice[:id]] = Invoice.new(invoice, self)
    end
    return self
  end

  def all
    @repository.map do  |key, value|
      value
    end
  end

  def find_by_id(id)
    if @repository[id.to_s]
      @repository[id.to_s]
    else
      nil
    end
  end

  def find_all_by_customer_id(customer_search)
    all.find_all do |invoice|
      invoice.customer_id.to_i == customer_search.to_i
    end
  end

  def find_all_by_merchant_id(merchant_search)
    all.find_all do |invoice|
      invoice.merchant_id.to_i == merchant_search.to_i
    end
  end

  def find_all_by_status(status_search)
    all.find_all do |invoice|
      invoice.status == status_search
    end
  end
end