require_relative '../module/incravinable'

class InvoiceRepository

  include Incravinable

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  attr_reader :all,
              :engine 

  def initialize(path, engine)
    @all = []
    create_invoices(path)
    @engine = engine
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
      @all << Invoice.new(data_hash, self)
    end
  end

  def find_by_id(id)
    find_with_id(id, @all)
  end

  def find_all_by_customer_id(id)
    @all.find_all do |invoice|
      invoice.customer_id == id
    end
  end

  def find_all_by_merchant_id(id)
    find_all_with_merchant_id(id, @all)
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
    new_invoice = Invoice.new(attributes, self)
    new_invoice.new_id(highest_id.id + 1)
    @all << new_invoice
  end

  def update(id, attributes)
    found_invoice = @all.find do |invoice|
      invoice.id == id
    end
    if find_by_id(id) != nil
      found_invoice.new_status(attributes)
      found_invoice.update_time
    end
  end

  def delete(id)
    remove(id, @all)
  end
end
