class InvoiceRepository
  attr_reader :all

  def initialize(path)
    @all = []
    create_invoices(path)
  end

  def create_invoices(path)
    invoices = CSV.foreach(path, headers: true, header_converters: :symbol) do |invoice_data|
      data_hash = {
                    id: invoice_data[:id],
                    status: invoice_data[:status],
                    customer_id: invoice_data[:customer_id].to_i,
                    merchant_id: invoice_data[:merchant_id].to_i,
                    created_at: Time.parse(invoice_data[:created_at]),
                    updated_at: Time.parse(invoice_data[:updated_at])
                  }
      @all << Invoice.new(data_hash)
    end
  end

  def find_by_id(id)
    @all.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(id)
    @all.find_all do |invoice|
      invoice.customer_id == id
    end
  end

  def find_all_by_merchant_id(id)
    @all.find_all do |invoice|
      invoice.merchant_id == id
    end
  end

  def find_all_by_status(status)
    @all.find_all do |invoice|
      invoice.status == status
    end
  end

  def create(attributes)
    highest_id = @all.max_by do |invoice|
      invoice.id
    end
    new_invoice = Invoice.new(attributes)
    new_invoice.new_id(highest_id.id + 1)
    @all << new_invoice
  end

  def update(id, attributes)
    @all.find do |invoice|
      invoice.new_status(attributes[:status])
      invoice.update_updated_at
    end
  end

  def delete(id)
    to_delete = @all.find do |invoice|
      invoice.id == id
    end
    @all.delete(to_delete)
  end
end
