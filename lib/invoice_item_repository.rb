require_relative 'entry'
class InvoiceItemRepository
  attr_reader :id,
              :item_id,
              :invoice_id,
              :created_at,
              :all
  attr_accessor :unit_price,
                :updated_at,
                :quantity

  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << InvoiceItem.new(
        :id => row[:id].to_i,
        :item_id => row[:item_id],
        :invoice_id => row[:invoice_id],
        :quantity => row[:quantity],
        :unit_price => row[:unit_price],
        :created_at => row[:created_at],
        :updated_at => row[:updated_at]
        )
      end
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def find_by_id(id)
    @all.find {|invoice_item| invoice_item.id == id}
  end

  def find_all_by_item_id(item_id)
    @all.find_all {|invoice_item| invoice_item.item_id.to_i == item_id.to_i}
  end

  def find_all_by_invoice_id(item_id)
    @all.find_all {|invoice_item| invoice_item.invoice_id.to_i == invoice_id.to_i}
  end

  def create(attributes)
    create_id = (@all.last.id + 1)
    @all << InvoiceItem.new({
      :id => create_id,
      :item_id => attributes[:item_id],
      :invoice_id => attributes[:invoice_id],
      :quantity => attributes[:quantity],
      :unit_price => attributes[:unit_price],
      :created_at => attributes[:created_at],
      :updated_at => attributes[:updated_at]
      })
  end

  def update(id, attributes)
    update_invoice = find_by_id(id)
    update_invoice.quantity = attributes[:quantity]
    update_invoice.unit_price = attributes[:unit_price]
    update_invoice.updated_at = Time.now
  end

  def delete(id)
    delete_invoice = find_by_id(id)
    @all.delete(delete_invoice)
  end

end
