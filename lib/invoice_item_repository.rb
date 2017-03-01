class InvoiceItemRepository
  attr_reader :path,
              :engine

  def initialize(path, engine)
    @path = path
    @engine = engine
  end

  def csv
    @csv ||= CSV.open(path, headers: true, header_converters: :symbol)
  end

  def all
    @all ||= csv.map do |row|
      InvoiceItem.new(row, self)
    end
  end

  def find_by_id(id)
    all.find do |invoice_item|
      invoice_item.id.to_i == invoice_item.id.to_i
    end
  end

  def find_all_by_item_id(item_id)
    all.find_all do |invoice_item|
      invoice_item.item_id == item_id.to_i
    end
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id.to_i
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
