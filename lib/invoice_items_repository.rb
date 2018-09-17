require_relative 'invoice_item'
require 'bigdecimal'
require "time"

class InvoiceItemsRepository
  include Crud
  
    attr_reader :collection
  
    def initialize(filepath, parent)
      @collection = []
      loader(filepath)
      @parent = parent
    end

    def create(attributes)
      if @collection != []
        largest = (@collection.max_by {|element| element.id})
        attributes[:id] = (largest.id + 1)
      else
        attributes[:id] = 1
      end
      single_invoice_item = InvoiceItem.new(attributes, self)
      @collection << single_invoice_item
    end
  
    def find_all_by_item_id(string)
      find_all_by_exact(("item_id"), string)
    end
  
   def find_all_by_invoice_id(invoice_id)
     find_all_by_exact("invoice_id", invoice_id)
   end

    def all
      @collection
    end
  
    def loader(filepath)
      invoice_table = load(filepath)
       invoice_table.map do |invoice|
         invoice[:id] = invoice[:id].to_i
         invoice[:item_id] = invoice[:item_id].to_i
         invoice[:invoice_id] = invoice[:invoice_id].to_i
         invoice[:quantity] = invoice[:quantity].to_i
         invoice[:updated_at] = Time.parse(invoice[:updated_at])
         invoice[:created_at] = Time.parse(invoice[:created_at])
         @collection << InvoiceItem.new(invoice, @parent)
       end
    end
  
    def update(id, attributes)
      invoice = find_by_id(id)
      empty_quantity = attributes[:quantity].nil?
      empty_unit_price = attributes[:unit_price].nil?
      
      invoice.quantity = attributes[:quantity] unless empty_quantity
      invoice.unit_price = attributes[:unit_price] unless empty_unit_price
      invoice.updated_at = Time.now unless empty_quantity && empty_unit_price
      invoice
    end
  
end
  