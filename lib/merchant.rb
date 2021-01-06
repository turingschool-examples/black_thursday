require 'csv'
require 'pry'
require_relative "./time_store_module"

class Merchant
  include TimeStoreable

  attr_reader :id

  attr_accessor :name

  def initialize(data)
     @id = data[:id].to_i
     @name = data[:name]
     @created_at = time_store(data[:created_at])
     @updated_at = time_store(data[:updated_at])
  end
end
