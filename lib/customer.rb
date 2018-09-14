require './lib/finder'

class Customer
  include Finder 
  
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(hash)
    @id = hash[:id]
    @first_name = hash[:first_name]
    @last_name = hash[:last_name]
    @created_at = hash[:created_at]
    @updated_at = hash[:updated_at]
  end


end