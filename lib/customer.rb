class Customer

  attr_reader :id,
              :created_at
              
  attr_accessor :first_name,
                :last_name,
                :updated_at

  def initialize(hash)
    @id         = hash[:id].to_i
    @first_name = hash[:first_name]
    @last_name  = hash[:last_name]
    @created_at = hash[:created_at]
    @updated_at = hash[:updated_at]
  end

end
