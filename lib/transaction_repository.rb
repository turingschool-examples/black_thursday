require 'pry'

class TransactionRepository
  attr_reader :all
  def initialize(array)
    @all = array
  end
end
