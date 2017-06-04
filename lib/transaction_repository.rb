require_relative 'transaction'
require 'csv'

class TransactionRepository

  attr_reader :file_path,
              :contents

  def initialize(file_path, parent)
    @file_path = file_path
    @parent    = parent
    @contents  = load_library
  end

  def load_library
    library = {}
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      h = Hash[row]
      d = h[:id]
      library[d.to_i] = Transaction.new(h, self)
    end
    @contents = library
  end

  def all
    contents.map { |k,v| v }
  end

  def find_by_id(transaction_id)
    contents[transaction_id]
  end

  def find_all_by_invoice_id(inv_id)
    contents.values.find_all { |v| v.invoice_id == inv_id }
  end

end
