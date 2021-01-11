require 'csv'
require 'bigdecimal'
require 'time'
require_relative './customer'

class CustomerRepository
  attr_reader :all,
              :engine

  def initialize(items_path, engine)
    @all = []
    @engine = engine

    CSV.foreach(items_path, headers: true, header_converters: :symbol) do |row|
      @all << convert_to_customer(row)
    end
  end

  def convert_to_customer(row)

  end


end
