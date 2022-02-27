require 'pry'
require './lib/findable'

class TransactionRepository
  include Findable
  attr_reader :all

  def initialize(array)
    @all = array
  end

  def find_all_by_invoice_id
    @all.find do |one|
      one. == name
    end
  end

  def find_all_by_item_id

  end




end
