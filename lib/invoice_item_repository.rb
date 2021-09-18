class InvoiceItemRepository
  attr_reader :all

  def initialize(file)
    @all = iir_setup(file)
  end

  def iir_setup(file)
    all_invoice_items = CSV.parse(File.read(file))
    categories = all_invoice_items.shift
    all_invoice_items.map do |invoice_item|
      individual_invoice_item = {}
      categories.zip(invoice_item) do |category, attribute|
        individual_invoice_item[category.to_sym] = attribute
      end
      InvoiceItem.new(individual_invoice_item)
    end
  end

  def find_by_id(id)
    all.find { |invoice_item| invoice_item.id.to_i == id }
  end

  def find_all_by_item_id(item_id)
    all.find_all { |invoice_item| invoice_item.item_id.to_i == item_id}
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all { |invoice_item| invoice_item.invoice_id.to_i == invoice_id}
  end
end
