class InvoiceRepository
  attr_reader :invoices,
              :parent

  def initialize(csv_filename, parent)
    @invoices  = load_csv(csv_filename).map { |row| Invoice.new(row, self) }
    @parent    = parent
  end

  def load_csv(filename)
    # require "pry"; binding.pry
    CSV.open filename, headers: true, header_converters: :symbol
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find { |invoice| invoice.id == id }
  end

  def find_all_by_merchant_id(merchant_id)
    return [] if merchant_id.nil?
    invoices.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_customer_id(customer_id)
    return [] if customer_id.nil?
    invoices.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_status(status)
    return [] if status.nil?
    invoices.find_all do |invoice|
      invoice.status == status
    end
  end
end
