require 'csv'
require_relative 'invoice_item'

class InvoiceItemRepository
  attr_reader :file_path,
              :all

 def initialize(file_path)
   @file_path = file_path
   @all = []
   CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
     @all << InvoiceItem.new({:id => row[:id], :item_id => row[:item_id], :invoice_id => row[:invoice_id], :quantity => row[:quantity], :unit_price => row[:unit_price], :created_at => row[:created_at], :updated_at => row[:updated_at]})
   end
 end

 def find_by_id(invoice_item_id)
   @all.find { |invoice| invoice.id == invoice_item_id}
 end

 def find_all_by_invoice_id(invoice_id)
   @all.find_all {|invoice| invoice.invoice_id == invoice_id}
 end
end
