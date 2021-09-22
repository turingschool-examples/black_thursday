require 'csv'
require_relative 'invoice_item'

class InvoiceItemRepository
  attr_reader :all

  def initialize(file_path, engine)
    @engine = engine
    @all = create_repository(file_path)
  end

  def create_repository(file_path)
    all = []

    csv = CSV.read(file_path, headers: true, header_converters: :symbol)
     csv.map do |row|
       all << InvoiceItem.new(row)
    end
    all
  end

  def find_by_id(id)
    @all.find_all do |invoiceitem|
      invoiceitem.id == id
    end.pop
  end

  def find_all_by_item_id(item_id)
    @all.find_all do |invoiceitem|
     invoiceitem.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |invoiceitem|
     invoiceitem.invoice_id == invoice_id
    end
  end

  def create(attributes)
    id_max = @all.max_by {|invoiceitem| invoiceitem.id}
    attributes[:id] = id_max.id + 1
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    new = InvoiceItem.new(attributes)
    @all.push(new)
  end

  def update(id, attribute)

    updated_invoice_item = self.find_by_id(id)
<<<<<<< HEAD
      if updated_invoice_item != nil
        updated_invoice_item.quantity = attribute[:quantity]
        updated_invoice_item.unit_price = attribute[:unit_price]
        updated_invoice_item.updated_at = Time.now
      end

=======
    if updated_invoice_item != nil
      updated_invoice_item.quantity = attribute[:quantity] if attribute[:quantity]
      updated_invoice_item.unit_price = attribute[:unit_price] if attribute[:unit_price]
      updated_invoice_item.updated_at = Time.now
    end
>>>>>>> bdc7986bcc5a2f66fae06366b867c00e7480b08b
  end

  def delete(id)
    @all.delete_if do |row|
      row.id == id
    end
  end

  def inspect
   "#<#{self.class} #{@invoiceitem.size} rows>"
  end
end
