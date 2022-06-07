require 'csv'
require_relative '../lib/invoice_item'

class InvoiceItemRepository

  attr_reader :file_path, :all

  def initialize(file_path)
    @file_path = file_path
    @all = []
    
      if @file_path
        CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
        @all << InvoiceItem.new({:id => row[:id], :item_id => row[:item_id], :invoice_id => row[:invoice_id], :quantity => row[:quantity], :unit_price => row[:unit_price], :created_at => row[:created_at], :updated_at => row[:updated_at]})
      end
    end
  end

end
