require 'csv'
require './lib/invoice_item'

class InvoiceItemRepository

  def initialize
    @invoice_items      = []
  end

  def from_csv(file)
    CSV.readlines(file, headers: true, header_converters: :symbol) do |row|
      invoice_items << InvoiceItem.new(row)
    end
  end
  #
  # def all
  #   return merchants
  # end
  #
  # def count
  #   merchants.count
  # end
  #
  # def find_by_name(name)
  #   merchants.find do |merchant|
  #     merchant.name.downcase == name.downcase
  #   end
  # end


end
