require_relative 'invoice_item'

class InvoiceItemRepository
  attr_reader :repository
  def initialize(data, sales_engine = nil)
    @sales_engine = sales_engine
    @repository   = {}
    load_csv_file(data)
  end

  def load_csv_file(data)
    CSV.foreach(data, :headers => true, :header_converters => :symbol, :converters => :all) do |row|
      data = row.to_h
      repository[data[:id].to_i] = InvoiceItem.new(data, self)
    end
  end

  def all
    repository.values
  end

  def find_by_id(id)
    repository[id]
  end

  def find_all_by_item_id(item_id)
    all.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

end
