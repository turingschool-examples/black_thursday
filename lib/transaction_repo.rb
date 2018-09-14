require 'pry'
require 'time'
require_relative '../lib/black_thursday_helper'
require_relative '../lib/transaction'


class TransactionRepo
  include BlackThursdayHelper

  def initialize(filepath)
    @collections = []
    populate(filepath)
  end

  def populate(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |params|
      @collections << Transaction.new(params)
    end
  end

end
