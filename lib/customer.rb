require 'time'

class Customer
  attr_reader :id,
              :created_at
  attr_accessor :first_name,
                :last_name,
                :updated_at

  def initialize(hash)
    @id = hash[:id].to_i
    @first_name = hash[:first_name]
    @last_name = hash[:last_name]
    @created_at = Time.parse(hash[:created_at].to_s)
    @updated_at = Time.parse(hash[:updated_at].to_s)
  end

end
