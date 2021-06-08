require './module/incravinable'

class InvoiceItemRepository
  include Incravinable

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  attr_reader :all, 
              :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :engine

  def initialize(path, engine)
    @all = []
    create_invoice_items(path)
    @engine = engine
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
      @all << InvoiceItem.new(ii_hash, self)
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

  def find_all_by_invoice_id(id)
    @all.find_all do |invoice|
      invoice.invoice_id == id
    end
  end

  def create(attributes)
    highest_id = @all.max_by do |invoice_item|
      invoice_item.id 
    end
    new_invoice_item = InvoiceItem.new(attributes, self)
    new_invoice_item.new_id(highest_id.id + 1)
    @all << new_invoice_item
  end

  def update(id, attribute)
    found_invoice_item = @all.find do |invoice_item|
      invoice_item.id == id
    end
    if find_by_id(id) != nil
      found_invoice_item.update_quantity(attribute[:quantity])
      found_invoice_item.update_unit_price(attribute[:unit_price])
      found_invoice_item.update_time
    end
  end

  def delete(id)
    remove(id)
  end
end