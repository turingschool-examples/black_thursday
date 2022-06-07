require 'CSV'
require 'BigDecimal'
require_relative './invoice_item.rb'

class InvoiceItemRepository
  attr_reader :all
  def initialize(invoice_item_path)
    @invoice_item_path = invoice_item_path
    @all = []

    CSV.foreach(@invoice_item_path, headers: true, header_converters: :symbol) do |row|
    @all << InvoiceItem.new({
      :id => row[:id],
      :item_id => row[:item_id],
      :invoice_id => row[:invoice_id],
      :quantity => row[:quantity],
      :unit_price => row[:unit_price],
      :created_at => row[:created_at],
      :updated_at => row[:updated_at],
      :unit_price => row[:unit_price]
      })
		end
    require 'pry';binding.pry

  end



end
