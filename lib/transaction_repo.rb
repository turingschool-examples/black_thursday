require 'bigdecimal'
require 'CSV'
require 'time'
require 'item'

class TransactionRepo
  attr_reader :transactions
  def initialize(path, engine)
    @transactions = []
    @engine = engine
    populate_information(path)
  end

  def populate_information(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |transaction_info|
      @transactions << Transaction.new(transaction_info, @engine)
    end
  end

end
