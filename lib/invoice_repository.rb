class InvoiceRepository
  attr_reader :path,
              :engine

  def initialize(path, engine)
    @path = path
    @engine = engine
  end

  def csv
    @csv ||= CSV.open(path, headers:true, header_converters: :symbol)
  end

  def all
    @all ||= csv.map do |row|
      Invoice.new(row, self)
    end
  end

  def find_by_id(id)
    all.find do |invoice|
      invoice.id.to_i == id.to_i
    end
  end

  def find_all_by_customer_id(customer_id)
    all.find_all do |invoice|
      invoice.customer_id == customer_id.to_i
    end
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all do |invoice|
      invoice.merchant_id == merchant_id.to_i
    end
  end

  def find_all_by_status(status)
    all.find_all do |invoice|
      invoice.status == status
    end
  end

  def inspect
  "#<#{self.class} #{@merchants.size} rows>"
  end

end
