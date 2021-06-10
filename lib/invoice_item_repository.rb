require_relative 'inspectable'

class InvoiceItemRepository
  include Inspectable
  attr_reader :file_path,
              :sales_engine,
              :all

  def initialize(file_path, sales_engine)
    @file_path = file_path
    @sales_engine = sales_engine
    @all = generate
  end

  def generate
    info = CSV.open(@file_path.to_s, headers: true, header_converters: :symbol)
    info.map do |row|
      InvoiceItem.new(row, self)
    end
  end

  def find_by_id(id)
    @all.find do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_all_by_item_id(item_id)
    @all.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def create(attributes)
    attributes[:id] = @all.last.id + 1
    @all << InvoiceItem.new(attributes, self)
  end

  def update(id, attributes)
    invoice_item = find_by_id(id)
    return nil if invoice_item.nil?

    invoice_item.update_invoice_item(attributes)
  end

  def delete(id)
    deleted_invoice_item = find_by_id(id)
    @all.delete(deleted_invoice_item)
  end
end
