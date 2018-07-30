require 'time'

class Customer 
  attr_accessor :id,
                :first_name,
                :last_name,
                :created_at,
                :updated_at
                
  def initialize(hash)
    @id = hash[:id].to_i
    @first_name = hash[:first_name]
    @last_name = hash[:last_name]
    @created_at = if hash[:created_at].class == String
                  Time.parse(hash[:created_at])
                    else
                      Time.now
                  end
    @updated_at = if hash[:updated_at].class == String
                    Time.parse(hash[:updated_at])
                    else
                      Time.now
                  end  
  end 
  
end
