class InvoiceItemRepository
  attr_reader :file_path, :items
  def initialize(file_path)
    @file_path = file_path
    @items = all
  end

  def all
    items = CSV.read(@file_path, headers: true, header_converters: :symbol)
    invoice_items_instances_array = []
    items.by_row!.each do |row|
      invoice_items_instances_array << InvoiceItem.new(row)
    end
    invoice_items_instances_array
  end
end
