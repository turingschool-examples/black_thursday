require 'csv'

class InvoiceRepository

  def initialize(path)
    @path = path
    @rows = CSV.read(@path, headers: true, header_converters: :symbol)
    @all = all
  end

  def all
    @rows.map do |row|
      Invoice.new(row)
    end
  end

  def find_by_id(id)
    @all.find do |row|
      row.id == id
    end
  end

  def find_all_by_customer_id(customer_id)
    @all.find_all do |row|
      row.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |row|
      row.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    @all.find_all do |row|
      row.status == status
    end
  end

  def create(attributes)
    attributes[:id] = @all.last.id.to_i + 1
    @all << Invoice.new(attributes)
  end

  def update(id, attributes)
    invoice_to_update = find_by_id(id)
    invoice_to_update.status = attributes[:status]
    invoice_to_update.updated_at = Time.now
  end
end
