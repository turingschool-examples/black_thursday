class InvoiceRepository
  attr_reader :all

  def initialize(invoice_data)
    @all = fill_invoices(invoice_data)
  end

  def fill_invoices(invoice_data)
    all_invoices = CSV.parse(File.read(invoice_data))
    categories = all_invoices.shift
    all_invoices.map do |invoice|
      individual_invoice = {}
      categories.zip(invoice) do |category, attribute|
        individual_invoice[category.to_sym] = attribute
      end
      Invoice.new(individual_invoice)
    end
  end

  def find_by_id(id)
    all.find { |invoice| invoice.id.to_i == id.to_i }
  end

  def find_all_by_customer_id(customer_id)
    all.find_all do |invoice|
      invoice.customer_id.to_i == customer_id.to_i
    end
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all do |invoice|
      invoice.merchant_id.to_i == merchant_id.to_i
    end
  end

  def find_all_by_status(status)
    all.find_all do |invoice|
      invoice.status == status
    end
  end

  def create(customer_id, merchant_id, status)
    creation_time = Time.now
    all << Invoice.new(
      id: final_invoice.id.to_i + 1,
      customer_id: customer_id,
      merchant_id: merchant_id,
      status: status,
      created_at: creation_time,
      updated_at: creation_time
      )
  end

  def final_invoice
    all.max_by(&:id)
  end

  def update(id, attribute)
    find_by_id(id).update(attribute)
  end

  def delete(id)
    all.delete(find_by_id(id))
  end
end
