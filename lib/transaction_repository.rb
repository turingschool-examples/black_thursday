require_relative 'transaction'
require 'csv'

class TransactionRepository

  attr_reader :all

  def initialize
    @all = []
  end

  def from_csv(file_path)
    CSV.foreach(file_path, headers: true, :header_converters => :symbol) do |row|
      @all << Transaction.new(row)
    end
  end

end
