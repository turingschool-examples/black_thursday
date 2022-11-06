class InvoiceItemRepository

  def initialize(invoice_items, engine)
    @invoice_items = create_invoice_items(invoice_items)
  end

  def all
    @invoice_items
  end

  def find_by_id(id)
    if !a_valid_id?(id)
      return nil
    else
      @invoice_items.find do |invoice|
        invoice.id == id
      end
    end
  end

  def a_valid_id?(id)
    @invoice_items.any? do |invoice| invoice.id == id
    end 
  end

  def find_all_by_item_id(id)
    @invoice_items.find_all do |invoice|
      invoice.item_id == id
    end
  end

  def find_all_by_invoice_id(id)
    @invoice_items.find_all do |invoice|
      invoice.invoice_id == id
    end
  end

  def create(attribute)
    new_invoice_item = @invoice_items.last.id + 1
    @invoice_items << InvoiceItem.new({:id => new_invoice_item, :item_id => attribute[:item_id],
      :invoice_id => attribute[:invoice_id],
      :quantity => attribute[:quanity],
      :unit_price => attribute[:unit_price],
      :created_at => attribute[:created_at].to_s,
      :updated_at => attribute[:updated_at].to_s
      }, self)
  end

  def update(id, attribute)
    # require 'pry'; binding.pry
    @invoice_items.each do |invoice|
      invoice.update(attribute) if invoice.id == id
      # if invoice.id == id
      #   invoice_update = invoice.name.replace(attribute)
      #   return invoice_update
      # end
    end
  end

  def delete(id)
    @invoice_items.delete(find_by_id(id))
  end

  def create_invoice_items(filepath)
    contents = CSV.open filepath, headers: true, header_converters: :symbol, quote_char: '"'
    make_invoice_item_object(contents)
  end
  
  def make_invoice_item_object(contents)
    contents.map do |row|
      invoice_item = {
              :id => row[:id].to_i, 
              :item_id => row[:item_id].to_i,
              :invoice_id => row[:invoice_id].to_i,
              :quantity => row[:quantity].to_i,
              :unit_price => row[:unit_price].to_f,
              :created_at => row[:created_at],
              :updated_at => row[:updated_at]
            }
      InvoiceItem.new(invoice_item, self)
    end
  end

    def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end