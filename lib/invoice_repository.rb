
class InvoiceRepository
  attr_reader :path,
              :invoices

  def initialize(path)
    @path = path
    @invoices = []
    read_invoice
  end

  def read_invoice
    CSV.foreach(@path, headers: true, header_converters: :symbol) do |row|
      @invoices << Invoice.new(row)
    end

    @invoices
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(id)
    @invoices.find_all do |invoice|
      invoice.customer_id == id
    end
  end

  def find_all_by_merchant_id(id)
    @invoices.find_all do |invoice|
      invoice.merchant_id == id
    end
  end

  def find_all_by_status(status)
    @invoices.find_all do |invoice|
      invoice.status == status
    end
  end

  def create(attributes)
    attributes[:created_at] = Time.new.to_s
    attributes[:updated_at] = Time.new.to_s
    attributes[:id] = highest_id.id + 1
    @invoices.insert(2, Invoice.new(attributes))
  end

  def update(id, attributes)
    update = find_by_id(id)
    return nil if update.nil?

    update.status = attributes[:status]
    update.updated_at = Time.now
  end

  def delete(id)
    delete = find_by_id(id)
    @invoices.delete(delete)
  end

  def highest_id
    @invoices.max do |invoice|
      invoice.id
    end
  end
end
