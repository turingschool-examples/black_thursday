require 'csv'

class InvoiceItemRepository
  def initialize(path)
    @path = path
    @rows = CSV.read(@path, headers: true, header_converters: :symbol)
    @all = all
  end

  def all
    result = @rows.map do |row|
      InvoiceItem.new(row)
    end
  end

  def find_by_id(id)
    result = @all.find do |row|
      row.id == id
    end
    result
  end

  def find_all_by_item_id(item_id)
    result = @all.find do |row|
      row.item_id == item_id
    end
    result
  end

  def find_all_by_invoice_id(invoice_id)
    result = @all.find do |row|
      row.invoice_id == invoice_id
    end
    result
  end

  def create(attributes)
    attributes[:id] = @all.last.id.to_i + 1
    @all << InvoiceItem.new(attributes)
  end 
end
