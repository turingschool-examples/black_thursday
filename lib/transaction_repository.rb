require 'pry'
require './lib/findable'

class TransactionRepository
  include Findable
  attr_reader :all

  def initialize(array)
    @all = array
  end
end
