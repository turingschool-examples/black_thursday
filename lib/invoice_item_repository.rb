require_relative '../lib/invoice_item'
require 'csv'

class InvoiceItemRepository
  attr_reader :all,
              :parent

  def initialize(file_path, parent)
    contents = CSV.open(file_path, headers: true, header_converters: :symbol)
    @all = contents.map do |row|
      InvoiceItem.new({:id         => row[:id],
                       :item_id    => row[:item_id],
                       :invoice_id => row[:invoice_id],
                       :quantity   => row[:quantity],
                       :unit_price => row[:unit_price],
                       :created_at => row[:created_at],
                       :updated_at => row[:updated_at]
                       }, self)
    end
    @parent = parent
  end

  def find_by_id(id)
    all.find do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_all_by_item_id(item_id)
    all.select do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    all.select do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

end
