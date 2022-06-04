require_relative './enumerable'

class InvoiceItemRepository
  include Enumerable
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << InvoiceItem.new({
        id: row[:id],
        item_id: row[:item_id],
        invoice_id: row[:invoice_id],
        quantity: row[:quantity],
        unit_price: BigDecimal(row[:unit_price].to_i * 0.01, 4),
        created_at: Time.now,
        updated_at: Time.now
        })
    end
  end

  def find_all_by_invoice_id(inv_id)
    @all.find_all {|row| row.invoice_id == inv_id}
  end

  def add_new(new_id, attributes)
    ii = InvoiceItem.new({
      id: new_id,
      :item_id => attributes[:item_id],
      :invoice_id => attributes[:invoice_id],
      :quantity => attributes[:quantity],
      :unit_price => attributes[:unit_price],
      :created_at => attributes[:created_at],
      :updated_at => attributes[:updated_at]
      })
    @all.append(ii)
    ii
  end

  def change(id, key, value)
    if key == :quantity
      find_by_id(id).quantity = value
    elsif key == :unit_price
      find_by_id(id).unit_price = value
    else
      return nil
    end
    find_by_id(id).updated_at = Time.now
  end

end
