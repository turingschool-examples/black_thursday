require 'csv'
require_relative 'transaction'

class TransactionRepository
  attr_reader :all

  def initalize(attributes)
    @filepath = filepath
    @all = []
    CSV.foreach(@filepath, headers: true, header_converters: :symbol) do |row|
      @all << Transaction.new(row)
    end
  end


end
