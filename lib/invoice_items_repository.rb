require 'pry'

require_relative 'csv_parse'
require_relative 'invoice_item'


class InvoiceItemRepository

  attr_reader :all,
              :invoice_items

  def initialize(path)
    @csv = CSVParse.create_repo(path)
    @invoice_items = []
    make_invoice_items
    @all = invoice_items  # retains permissions
  end


  def make_invoice_items
    @csv.each { |key, value|
      hash = make_hash(key, value)
      item = InvoiceItem.new(hash)
      @invoice_items << item
    }
    end

  def make_hash(key, value)
    hash = {id: key.to_s.to_i}
    value.each { |col, data| hash[col] = data }
    return hash
  end

end
