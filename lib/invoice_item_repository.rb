require_relative "../lib/invoice_item"
require_relative "../lib/data_access"

class InvoiceItemRepository
  attr_reader :all
  include DataAccess

  def initialize(parent)
    @all = []
    @parent = parent
  end

  def from_csv(path)
    file = CSV.open(path, headers: true, header_converters: :symbol)
    populate_repo(file)
  end

  def populate_repo(file)
  file.each do |row|
    invoice = InvoiceItem.new({:id => row[:id].to_i,
      :item_id => row[:item_id].to_i,
      :invoice_id => row[:invoice_id].to_i,
      :quantity => row[:quantity].to_i,
      :unit_price => transform_price(row[:unit_price]),
      :created_at => Time.parse(row[:created_at]),
      :updated_at => Time.parse(row[:updated_at])}, self)
      @all << invoice
    end
  end

  def find_all_by_item_id(item_id)
    all.select{ |invoice| invoice.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    all.select{ |invoice| invoice.invoice_id == invoice_id }
  end
end