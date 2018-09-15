require 'time'
require 'bigdecimal'

class Customer
  attr_accessor :id,
                :first_name,
                :last_name,
                :created_at,
                :updated_at

  def initialize(item_hash)
    @id = item_hash[:id]
    @first_name = item_hash[:first_name]
    @last_name = item_hash[:last_name]
    @created_at = (item_hash[:created_at])
    @updated_at = (item_hash[:updated_at])
  end

end
