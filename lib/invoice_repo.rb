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

  def find_highest_id
    highest = all.max_by do |invoice|
      invoice.id
    end
    highest.id
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

  def create(attributes)
    id = find_highest_id + 1
    current_time = Time.now.strftime("%F")
    attributes = {
      id: id.to_s,
      status: attributes[:status],
      customer_id: attributes[:customer_id].to_s,
      merchant_id: attributes[:merchant_id].to_s,
      created_at: current_time,
      updated_at: current_time
    }
    @all << Invoice.new(attributes)
  end

  def update(id, attributes)
    find_by_id(id).change_status(attributes[:status])
  end

  def delete(id)
    all.delete(find_by_id(id))
  end

end
