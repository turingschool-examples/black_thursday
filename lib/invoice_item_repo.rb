class InvoiceItemRepo
  attr_reader :all

  def initialize(csv_data, engine)
    create_invoice_items(csv_data)
    @engine = engine
  end

  def create_invoice_items(csv_data)
    invoice_items = CSV.open(csv_data, headers: true,
    header_converters: :symbol)

    @all = invoice_items.map do |invoice_item|
      InvoiceItem.new(invoice_item)
    end
  end

  def find_by_id(id)
    @all.find do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_all_by_item_id(id)
    @all.find_all do |invoice_item|
      invoice_item.item_id == id
    end
  end

  def find_all_by_invoice_id(id)
    @all.find_all do |invoice|
      invoice.invoice_id == id
    end
  end

  def max_invoice_item_id
    @all.max_by do |invoice|
      invoice.id
    end.id
  end

  def create(attributes)
    @all.push(InvoiceItem.new({
                          id: max_invoice_item_id + 1,
                          item_id:  attributes[:item_id],
                          invoice_id:  attributes[:invoice_id],
                          quantity: attributes[:quantity],
                          unit_price:  attributes[:unit_price],
                          created_at:  Time.now,
                          updated_at:  Time.now
                          }))
  end

  def update(id, attributes)
    invoice_item = find_by_id(id)
    attributes.each_key do |key|
      case
      when key == :quantity
        invoice_item.update_quantity(attributes[:quantity])
        invoice_item.update_updated_time
      when key == :unit_price
        invoice_item.update_unit_price(attributes[:unit_price])
        invoice.item.update_updated_time
      end
    end
  end

  def delete(id)
      @all.reject! do |invoice_item|
        invoice_item.id == id
      end
    end
end
