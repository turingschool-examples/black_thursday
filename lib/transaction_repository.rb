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

end
