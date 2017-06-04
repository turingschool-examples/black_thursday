require_relative 'transaction'
require 'csv'

class TransactionRepository

  attr_reader :all

  def initialize(file_path, parent = nil)
    @parent = parent
    @all = []
    populate_items(file_path)
  end

  def populate_items(file_path)
    CSV.foreach(file_path, row_sep: :auto, headers: true) do |line|
      self.all << Transaction.new(line, self)
    end
  end


end
