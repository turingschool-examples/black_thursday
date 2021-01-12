require_relative './time_store_module'
require 'time'
require 'bigdecimal'

class Customer
  include TimeStoreable

  attr_reader :id,    
              :created_at

  attr_accessor :first_name,
                :last_name,
                :updated_at

  def initialize(data, repository)
    @id = data[:id]
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @created_at = time_store(data[:created_at])
    @updated_at = time_store(data[:updated_at])
    @repository = repository
  end

end
