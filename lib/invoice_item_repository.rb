require_relative 'invoice_item'
require 'csv'
require 'pry'

class InvoiceItemRepository

  attr_reader :data

  def initialize
    @data = []
  end

  def from_csv(file_path)
    CSV.foreach(file_path, headers: true, :header_converters => :symbol) do |row|
      @data << InvoiceItem.new(row)
      # binding.pry
    end
    @data
  end
end





# require from_csv
# within csv method call on the invoice_item_truncated_file
# Iterate through each line, create an individual instance of invoice item
# then just call on the first instance