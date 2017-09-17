class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(information)
    @id = information[:id]
    @first_name = information[:first_name]
    @last_name = information[:last_name]
    @created_at = information[:created_at]
    @updated_at = information[:updated_at]
  end

end
