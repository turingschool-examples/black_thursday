class InvoiceRepo
  attr_reader :all

  def initialize(path)
    @path = path
    @all = to_array
  end

  def to_array
    invoices = []

    CSV.foreach(@path, headers: true, header_converters: :symbol) do |row|
      headers = row.headers
      invoices << Invoice.new(row.to_h)
    end
    invoices
  end

  def find_by_id(id)
    all.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(customer_id)
    all.select do | invoice |
      customer_id == invoice.customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    all.select do | item |
      merchant_id == item.merchant_id
    end
  end

  def find_all_by_status(status)
    all.select do | invoice |
      status == invoice.status
    end
  end

end
