require 'csv'
require_relative '../lib/invoice_item'
require_relative 'repoable'

class InvoiceItemRepository
  include Repoable
  attr_reader :file_path,
              :all

 def initialize(file_path)
   @file_path = file_path
   @all = []
   CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
     @all << InvoiceItem.new({:id => row[:id], :item_id => row[:item_id], :invoice_id => row[:invoice_id], :quantity => row[:quantity], :unit_price => row[:unit_price], :created_at => row[:created_at], :updated_at => row[:updated_at]})
   end
 end

 def find_all_by_invoice_id(invoice_id)
   @all.find_all { |invoice_item| invoice_item.invoice_id == invoice_id}
 end

 def create(attributes)
   #using sort_by in case they are ever out of order
   id = @all.sort_by { |invoice_item| invoice_item.id }.last.id
   attributes[:id] = id + 1
   @all << InvoiceItem.new(attributes)
 end

 def update(invoice_item_id, attributes)
   invoice_item = find_by_id(invoice_item_id)
   invoice_item.quantity = attributes[:quantity]
   invoice_item.unit_price = attributes[:unit_price]
   invoice_item.updated_at = Time.now
 end
end
