class InvoiceItemRepository
  attr_reader :file_path, :invoice_items
  def initialize(file_path)
    @file_path = file_path
    @invoice_items = all
  end

  def all
    invoice_items = CSV.read(@file_path, headers: true, header_converters: :symbol)
    invoice_items_instances_array = []
    invoice_items.by_row!.each do |row|
      invoice_items_instances_array << InvoiceItem.new(row)
    end
    invoice_items_instances_array
  end

  def find_by_id(id)
    invoice_items.find do |instance|
      instance.invoice_item_attributes[:id] == id
    end
  end

  def find_all_by_item_id(id)
    invoice_items.find_all do |instance|
      instance.invoice_item_attributes[:item_id] == (id)
    end
  end
end
