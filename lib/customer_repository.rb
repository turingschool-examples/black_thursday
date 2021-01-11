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
    row = Customer.new({id: row[:id].to_i,
                    first_name: row[:first_name],
                    last_name: row[:last_name],
                    created_at: row[:created_at],
                    updated_at: row[:updated_at]
                   }, self)
  end


  def find_by_id(id)
    @all.find do |customer|
      customer.id == id
    end
  end

end
