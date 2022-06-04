require 'csv'
require_relative 'transaction'

class TransactionRepository
  attr_reader :all

  def initialize(filepath)
    @filepath = filepath
    @all = []
    CSV.foreach(@filepath, headers: true, header_converters: :symbol) do |row|
      @all << Transaction.new(row)
    end
  end

  def find_by_id(id)
    @all.find { |transaction| transaction.id == id }
  end

end
