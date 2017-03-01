require_relative 'invoice_item'
class InvoiceItemRepository
  attr_reader :parent
  def initialize(csv_path, parent)
    @invoice_item_csv = CSV.open(csv_path, headers: true, header_converters: :symbol)
    @parent = parent
    make_repository
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

  def make_repository
    @repository = {}
    @invoice_item_csv.read.each do |invoice|
      @repository[invoice[:id]] = InvoiceItem.new(invoice, self)
    end

    return self
  end

  def all
    @repository.map do  |key, value|
      value
    end
  end

  def find_by_id(id)
    if @repository[id.to_s]
      @repository[id.to_s]
    else
      nil
    end
  end

  def find_all_by_item_id(item_search)
    all.find_all do |invoice|
      invoice.item_id.to_i == item_search.to_i
    end
  end

  def find_all_by_invoice_id(invoice_search)
    all.find_all do |invoice|
      invoice.invoice_id.to_i == invoice_search.to_i
    end
  end
end