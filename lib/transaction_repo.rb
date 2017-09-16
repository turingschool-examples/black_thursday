require 'csv'
require_relative 'transaction'
class TransactionRepo

  attr_reader :all_transactions, :parent

  def initialize(file, se=nil)
    @all_transactions = []
    open_file(file)
    @parent = se
  end

  def open_file(file)
    CSV.foreach file,  headers: true, header_converters: :symbol do |row|
      all_transactions << Transaction.new(row, self)
    end
  end
  def all
    @all_transactions
  end
end
