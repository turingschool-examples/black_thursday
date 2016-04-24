class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at,
              :customer_repository

  def initialize(column, parent = nil)
    @id = column[:id].to_i
    @first_name = column[:first_name]
    @last_name = column[:last_name]
    @created_at = Time.parse(column[:created_at])
    @updated_at = Time.parse(column[:updated_at])
    @customer_repository = parent
  end

end
