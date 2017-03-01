require 'csv'
require_relative 'invoice_item'
require 'pry'

class InvoiceItemRepository
  attr_reader :all,
              :engine

  def initialize(file_input = nil, engine ="")
    @all = []
    @engine = engine
    from_csv(file_input) if !file_input.nil?
  end

  def from_csv(info)
    CSV.foreach(info, headers: true, header_converters: :symbol) do |row|
      all << InvoiceItem.new({
                              id: row[:id],
                              item_id: row[:item_id],
                              invoice_id: row[:invoice_id],
                              quantity: row[:quantity],
                              unit_price: row[:unit_price],
                              created_at: row[:created_at],
                              updated_at: row[:updated_at]},
                              self)
    end
  end

  def find_by_id(id_num)
    all.find {|invoiceitem| invoiceitem.id == id_num}
  end

  def find_all_by_item_id(item_num)
    all.select {|invoiceitem| invoiceitem.item_id == item_num}
  end

  def find_all_by_invoice_id(invoice_num)
    all.select {|invoiceitem| invoiceitem.invoice_id == invoice_num}
  end

  def invoice_items_paid_in_full
    all.select do |invoiceitem|
      engine.invoices.find_by_id(invoiceitem.invoice_id).is_paid_in_full?
    end
  end

  def inspect
    "#<#{self.class} #{all.size} rows>"
  end
end
