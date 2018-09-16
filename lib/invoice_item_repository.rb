require 'pry'

require_relative 'csv_parse'
require_relative 'finderclass'

require_relative 'invoice_item'


class InvoiceItemRepository

  attr_reader :all

  def initialize(path)
    @csv = CSVParse.create_repo(path)
    @invoice_items = []
    make_invoice_items
    @all = @invoice_items  # retains permissions
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


  # --- Find By ---

  #returns either nil or an instance of InvoiceItem with a matching ID
  def find_by_id(id)
    FinderClass.find_by(all, :id, id)
  end

  # returns either [] or one or more matches which have a matching item ID
  def find_all_by_item_id(item_id)
    FinderClass.find_all_by(all, :item_id, item_id)
  end

  # returns either [] or one or more matches which have a matching invoice ID
  def find_all_by_invoice_id(invoice_id)
    FinderClass.find_all_by(all, :invoice_id, invoice_id)
  end

end
