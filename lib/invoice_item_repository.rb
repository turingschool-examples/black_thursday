require './module/incravinable'

class InvoiceItemRepository
  include Incravinable

  def inspect
    "#<#{self.class} #{invoice_items.size} rows>"
  end

  attr_reader :all, 
              :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(path)
    @all = []
    create_invoice_items(path)
  end
  
  def create_invoice_items(path)
    invoice_items = CSV.foreach(path, headers: true, header_converters: :symbol) do |ii_data|
      ii_hash = {
        id: ii_data[:id].to_i,
        item_id: ii_data[:item_id].to_i,
        invoice_id: ii_data[:invoice_id].to_i,
        quantity: ii_data[:quantity].to_i,
        unit_price: ii_data[:unit_price],
        created_at: Time.parse(ii_data[:created_at]),
        updated_at: Time.parse(ii_data[:updated_at])
      }
      @all << InvoiceItem.new(ii_hash)
    end
  end

  def find_by_id(id)
    find_with_id(id)
  end

  def find_all_by_item_id(id)
    @all.find_all do |invoice|
      invoice.item_id == id
    end
  end
end