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

end
